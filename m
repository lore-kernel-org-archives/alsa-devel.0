From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 002/112] ALSA: hda/realtek - List up all
	available DACs
Date: Tue,  8 Jan 2013 12:37:55 +0100
Message-ID: <1357645185-7645-3-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0992615F0
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 12DC2A51CA
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the probing phase, create a list of all available DACs in the codec
and use it for checking the single DAC connections.
This list will be used in more other places in the later commits, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 76 +++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d8118c9..50e079f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -172,6 +172,10 @@ struct alc_spec {
 	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
 	hda_nid_t inv_dmic_pin;
 
+	/* DAC list */
+	int num_all_dacs;
+	hda_nid_t all_dacs[16];
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2916,48 +2920,42 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 	return false;
 }
 
+/* check whether the DAC is reachable from the pin */
+static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
+				      hda_nid_t pin, hda_nid_t dac)
+{
+	if (!pin || !dac)
+		return false;
+	return snd_hda_get_conn_index(codec, pin, dac, true) >= 0;
+}
+
 /* look for an empty DAC slot */
 static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 {
-	hda_nid_t srcs[5];
-	int i, num;
+	struct alc_spec *spec = codec->spec;
+	int i;
 
-	pin = alc_go_down_to_selector(codec, pin);
-	num = snd_hda_get_connections(codec, pin, srcs, ARRAY_SIZE(srcs));
-	for (i = 0; i < num; i++) {
-		hda_nid_t nid = alc_auto_mix_to_dac(codec, srcs[i]);
-		if (!nid)
+	for (i = 0; i < spec->num_all_dacs; i++) {
+		hda_nid_t nid = spec->all_dacs[i];
+		if (!nid || alc_is_dac_already_used(codec, nid))
 			continue;
-		if (!alc_is_dac_already_used(codec, nid))
+		if (alc_auto_is_dac_reachable(codec, pin, nid))
 			return nid;
 	}
 	return 0;
 }
 
-/* check whether the DAC is reachable from the pin */
-static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
-				      hda_nid_t pin, hda_nid_t dac)
-{
-	if (!pin || !dac)
-		return false;
-	return snd_hda_get_conn_index(codec, pin, dac, true) >= 0;
-}
-
 static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t sel = alc_go_down_to_selector(codec, pin);
-	hda_nid_t nid, nid_found, srcs[5];
-	int i, num = snd_hda_get_connections(codec, sel, srcs,
-					  ARRAY_SIZE(srcs));
-	if (num == 1)
-		return alc_auto_look_for_dac(codec, pin);
-	nid_found = 0;
-	for (i = 0; i < num; i++) {
-		if (srcs[i] == spec->mixer_nid)
+	int i;
+	hda_nid_t nid_found = 0;
+
+	for (i = 0; i < spec->num_all_dacs; i++) {
+		hda_nid_t nid = spec->all_dacs[i];
+		if (!nid || alc_is_dac_already_used(codec, nid))
 			continue;
-		nid = alc_auto_mix_to_dac(codec, srcs[i]);
-		if (nid && !alc_is_dac_already_used(codec, nid)) {
+		if (alc_auto_is_dac_reachable(codec, pin, nid)) {
 			if (nid_found)
 				return 0;
 			nid_found = nid;
@@ -3308,6 +3306,26 @@ static void debug_show_configs(struct alc_spec *spec, struct auto_pin_cfg *cfg)
 		      spec->multiout.extra_out_nid[3]);
 }
 
+/* find all available DACs of the codec */
+static void alc_fill_all_nids(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+	hda_nid_t nid = codec->start_nid;
+
+	spec->num_all_dacs = 0;
+	memset(spec->all_dacs, 0, sizeof(spec->all_dacs));
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_OUT)
+			continue;
+		if (spec->num_all_dacs >= ARRAY_SIZE(spec->all_dacs)) {
+			snd_printk(KERN_ERR "hda: Too many DACs!\n");
+			break;
+		}
+		spec->all_dacs[spec->num_all_dacs++] = nid;
+	}
+}
+
 static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -3319,6 +3337,8 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 	bool best_wired = true, best_mio = true;
 	bool hp_spk_swapped = false;
 
+	alc_fill_all_nids(codec);
+
 	best_cfg = kmalloc(sizeof(*best_cfg), GFP_KERNEL);
 	if (!best_cfg)
 		return -ENOMEM;
-- 
1.8.0.1
