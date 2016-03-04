From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 3/7] ALSA: hda - Use hdac name space for CEA
	spk alloc structure
Date: Fri,  4 Mar 2016 19:59:48 +0530
Message-ID: <1457101792-19441-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DA42654BA
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:29:51 +0100 (CET)
In-Reply-To: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_chmap.h  |  6 +++---
 sound/pci/hda/patch_hdmi.c | 26 ++++++++++++++------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/sound/hda_chmap.h b/include/sound/hda_chmap.h
index 713b2452..d3f80e7 100644
--- a/include/sound/hda_chmap.h
+++ b/include/sound/hda_chmap.h
@@ -7,7 +7,7 @@
 
 #include <sound/hdaudio.h>
 
-struct cea_channel_speaker_allocation {
+struct hdac_cea_channel_speaker_allocation {
 	int ca_index;
 	int speakers[8];
 
@@ -23,9 +23,9 @@ struct hdac_chmap_ops {
 	 * for devices that have non-standard mapping requirements.
 	 */
 	int (*chmap_cea_alloc_validate_get_type)(struct hdac_chmap *chmap,
-		struct cea_channel_speaker_allocation *cap, int channels);
+		struct hdac_cea_channel_speaker_allocation *cap, int channels);
 	void (*cea_alloc_to_tlv_chmap)
-		(struct cea_channel_speaker_allocation *cap,
+		(struct hdac_cea_channel_speaker_allocation *cap,
 		unsigned int *chmap, int channels);
 
 	/* check that the user-given chmap is supported */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 04333ec..d73f54e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -297,7 +297,7 @@ static int hdmi_channel_mapping[0x32][8] = {
  * The preceding ones have better chances to be selected by
  * hdmi_channel_allocation().
  */
-static struct cea_channel_speaker_allocation channel_allocations[] = {
+static struct hdac_cea_channel_speaker_allocation channel_allocations[] = {
 /*			  channel:   7     6    5    4    3     2    1    0  */
 { .ca_index = 0x00,  .speakers = {   0,    0,   0,   0,   0,    0,  FR,  FL } },
 				 /* 2.1 */
@@ -683,7 +683,7 @@ static inline void eld_proc_free(struct hdmi_spec_per_pin *per_pin)
 static void init_channel_allocations(void)
 {
 	int i, j;
-	struct cea_channel_speaker_allocation *p;
+	struct hdac_cea_channel_speaker_allocation *p;
 
 	for (i = 0; i < ARRAY_SIZE(channel_allocations); i++) {
 		p = channel_allocations + i;
@@ -791,7 +791,7 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 				       int ca)
 {
 	struct hdmi_spec *spec = codec->spec;
-	struct cea_channel_speaker_allocation *ch_alloc;
+	struct hdac_cea_channel_speaker_allocation *ch_alloc;
 	int i;
 	int err;
 	int order;
@@ -2358,7 +2358,7 @@ static int hdmi_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 }
 
 static int hdmi_chmap_cea_alloc_validate_get_type(struct hdac_chmap *chmap,
-		struct cea_channel_speaker_allocation *cap, int channels)
+		struct hdac_cea_channel_speaker_allocation *cap, int channels)
 {
 	/* If the speaker allocation matches the channel count, it is OK.*/
 	if (cap->channels != channels)
@@ -2368,8 +2368,9 @@ static int hdmi_chmap_cea_alloc_validate_get_type(struct hdac_chmap *chmap,
 	return SNDRV_CTL_TLVT_CHMAP_VAR;
 }
 
-static void hdmi_cea_alloc_to_tlv_chmap(struct cea_channel_speaker_allocation *cap,
-					unsigned int *chmap, int channels)
+static void hdmi_cea_alloc_to_tlv_chmap(
+		struct hdac_cea_channel_speaker_allocation *cap,
+		unsigned int *chmap, int channels)
 {
 	int count = 0;
 	int c;
@@ -2439,7 +2440,7 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	dst = tlv + 2;
 	for (chs = 2; chs <= chmap->channels_max; chs++) {
 		int i;
-		struct cea_channel_speaker_allocation *cap;
+		struct hdac_cea_channel_speaker_allocation *cap;
 		cap = channel_allocations;
 		for (i = 0; i < ARRAY_SIZE(channel_allocations); i++, cap++) {
 			int chs_bytes = chs * 4;
@@ -3519,7 +3520,7 @@ static int patch_nvhdmi_8ch_7x(struct hda_codec *codec)
  * - 0x10de0040
  */
 static int nvhdmi_chmap_cea_alloc_validate_get_type(struct hdac_chmap *chmap,
-		struct cea_channel_speaker_allocation *cap, int channels)
+		struct hdac_cea_channel_speaker_allocation *cap, int channels)
 {
 	if (cap->ca_index == 0x00 && channels == 2)
 		return SNDRV_CTL_TLVT_CHMAP_FIXED;
@@ -3800,7 +3801,7 @@ static int atihdmi_paired_swap_fc_lfe(int pos)
 
 static int atihdmi_paired_chmap_validate(int ca, int chs, unsigned char *map)
 {
-	struct cea_channel_speaker_allocation *cap;
+	struct hdac_cea_channel_speaker_allocation *cap;
 	int i, j;
 
 	/* check that only channel pairs need to be remapped on old pre-rev3 ATI/AMD */
@@ -3911,7 +3912,7 @@ static int atihdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_n
 
 static int atihdmi_paired_chmap_cea_alloc_validate_get_type(
 		struct hdac_chmap *chmap,
-		struct cea_channel_speaker_allocation *cap,
+		struct hdac_cea_channel_speaker_allocation *cap,
 		int channels)
 {
 	int c;
@@ -3939,8 +3940,9 @@ static int atihdmi_paired_chmap_cea_alloc_validate_get_type(
 	return SNDRV_CTL_TLVT_CHMAP_PAIRED;
 }
 
-static void atihdmi_paired_cea_alloc_to_tlv_chmap(struct cea_channel_speaker_allocation *cap,
-						  unsigned int *chmap, int channels)
+static void atihdmi_paired_cea_alloc_to_tlv_chmap(
+		struct hdac_cea_channel_speaker_allocation *cap,
+		unsigned int *chmap, int channels)
 {
 	/* produce paired maps for pre-rev3 ATI/AMD codecs */
 	int count = 0;
-- 
1.9.1
