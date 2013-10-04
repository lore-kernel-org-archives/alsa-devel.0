From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 5/7] ALSA: hda - hdmi: Fix channel maps with
	less common speakers
Date: Sat,  5 Oct 2013 02:25:42 +0300
Message-ID: <1380929144-24944-6-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 184CB261740
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:16 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For some speakers and slots the CEA slot <-> speaker assignment depends
on the used CEA Channel Allocation value.

Therefore the from_cea_slot() and to_cea_slot() helpers currently only
work correctly for the regular 7.1 speakers.

Fix them to work with all speakers, taking the re-ordered CA index as
input and adapting use sites accordingly.

This change allows manual channel mapping to actually work for all CEA
allocated speakers. Additionally, this fixes incorrect channel map
reporting in automatic channel mapping mode when an affected speaker
position is used (e.g. 6.1 map which contains an RC speaker).

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 70 +++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 30cf9a9..3c89e48 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -645,19 +645,27 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 
 struct channel_map_table {
 	unsigned char map;		/* ALSA API channel map position */
-	unsigned char cea_slot;		/* CEA slot value */
 	int spk_mask;			/* speaker position bit mask */
 };
 
 static struct channel_map_table map_tables[] = {
-	{ SNDRV_CHMAP_FL,	0x00,	FL },
-	{ SNDRV_CHMAP_FR,	0x01,	FR },
-	{ SNDRV_CHMAP_RL,	0x04,	RL },
-	{ SNDRV_CHMAP_RR,	0x05,	RR },
-	{ SNDRV_CHMAP_LFE,	0x02,	LFE },
-	{ SNDRV_CHMAP_FC,	0x03,	FC },
-	{ SNDRV_CHMAP_RLC,	0x06,	RLC },
-	{ SNDRV_CHMAP_RRC,	0x07,	RRC },
+	{ SNDRV_CHMAP_FL,	FL },
+	{ SNDRV_CHMAP_FR,	FR },
+	{ SNDRV_CHMAP_RL,	RL },
+	{ SNDRV_CHMAP_RR,	RR },
+	{ SNDRV_CHMAP_LFE,	LFE },
+	{ SNDRV_CHMAP_FC,	FC },
+	{ SNDRV_CHMAP_RLC,	RLC },
+	{ SNDRV_CHMAP_RRC,	RRC },
+	{ SNDRV_CHMAP_RC,	RC },
+	{ SNDRV_CHMAP_FLC,	FLC },
+	{ SNDRV_CHMAP_FRC,	FRC },
+	{ SNDRV_CHMAP_FLH,	FLH },
+	{ SNDRV_CHMAP_FRH,	FRH },
+	{ SNDRV_CHMAP_FLW,	FLW },
+	{ SNDRV_CHMAP_FRW,	FRW },
+	{ SNDRV_CHMAP_TC,	TC },
+	{ SNDRV_CHMAP_FCH,	FCH },
 	{} /* terminator */
 };
 
@@ -673,25 +681,19 @@ static int to_spk_mask(unsigned char c)
 }
 
 /* from ALSA API channel position to CEA slot */
-static int to_cea_slot(unsigned char c)
+static int to_cea_slot(int ordered_ca, unsigned char pos)
 {
-	struct channel_map_table *t = map_tables;
-	for (; t->map; t++) {
-		if (t->map == c)
-			return t->cea_slot;
-	}
-	return -1;
-}
+	int mask = to_spk_mask(pos);
+	int i;
 
-/* from CEA slot to ALSA API channel position */
-static int from_cea_slot(unsigned char c)
-{
-	struct channel_map_table *t = map_tables;
-	for (; t->map; t++) {
-		if (t->cea_slot == c)
-			return t->map;
+	if (mask) {
+		for (i = 0; i < 8; i++) {
+			if (channel_allocations[ordered_ca].speakers[7 - i] == mask)
+				return i;
+		}
 	}
-	return 0;
+
+	return -1;
 }
 
 /* from speaker bit mask to ALSA API channel position */
@@ -705,6 +707,14 @@ static int spk_to_chmap(int spk)
 	return 0;
 }
 
+/* from CEA slot to ALSA API channel position */
+static int from_cea_slot(int ordered_ca, unsigned char slot)
+{
+	int mask = channel_allocations[ordered_ca].speakers[7 - slot];
+
+	return spk_to_chmap(mask);
+}
+
 /* get the CA index corresponding to the given ALSA API channel map */
 static int hdmi_manual_channel_allocation(int chs, unsigned char *map)
 {
@@ -731,14 +741,16 @@ static int hdmi_manual_channel_allocation(int chs, unsigned char *map)
 /* set up the channel slots for the given ALSA API channel map */
 static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 					     hda_nid_t pin_nid,
-					     int chs, unsigned char *map)
+					     int chs, unsigned char *map,
+					     int ca)
 {
+	int ordered_ca = get_channel_allocation_order(ca);
 	int alsa_pos, hdmi_slot;
 	int assignments[8] = {[0 ... 7] = 0xf};
 
 	for (alsa_pos = 0; alsa_pos < chs; alsa_pos++) {
 
-		hdmi_slot = to_cea_slot(map[alsa_pos]);
+		hdmi_slot = to_cea_slot(ordered_ca, map[alsa_pos]);
 
 		if (hdmi_slot < 0)
 			continue; /* unassigned channel */
@@ -765,7 +777,7 @@ static void hdmi_setup_fake_chmap(unsigned char *map, int ca)
 	int ordered_ca = get_channel_allocation_order(ca);
 	for (i = 0; i < 8; i++) {
 		if (i < channel_allocations[ordered_ca].channels)
-			map[i] = from_cea_slot(hdmi_channel_mapping[ca][i] & 0x0f);
+			map[i] = from_cea_slot(ordered_ca, hdmi_channel_mapping[ca][i] & 0x0f);
 		else
 			map[i] = 0;
 	}
@@ -778,7 +790,7 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 {
 	if (!non_pcm && chmap_set) {
 		hdmi_manual_setup_channel_mapping(codec, pin_nid,
-						  channels, map);
+						  channels, map, ca);
 	} else {
 		hdmi_std_setup_channel_mapping(codec, pin_nid, non_pcm, ca);
 		hdmi_setup_fake_chmap(map, ca);
-- 
1.8.1.5
