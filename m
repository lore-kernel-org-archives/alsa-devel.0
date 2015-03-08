From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 3/5] ALSA: hdalib - fix existing checkpatch issues
Date: Sun,  8 Mar 2015 20:07:57 +0530
Message-ID: <1425825479-28780-4-git-send-email-vinod.koul@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C93FE2604A9
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:30 +0100 (CET)
In-Reply-To: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The existing code seems to have a bit of checkpatch errors creeped in, so
take this opportinuty to fix them as well

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_codec.h |   10 +++++-----
 include/sound/hda_local.h |   14 +++++++-------
 sound/hda/hda_beep.c      |    2 +-
 sound/hda/hda_codec.c     |    4 ++--
 sound/hda/hda_proc.c      |    8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 9c8820f21f94..f5d7717dfca6 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -144,11 +144,11 @@ struct hda_bus {
 	DECLARE_BITMAP(pcm_dev_bits, SNDRV_PCM_DEVICES);
 
 	/* misc op flags */
-	unsigned int needs_damn_long_delay :1;
+	unsigned int needs_damn_long_delay:1;
 	unsigned int allow_bus_reset:1;	/* allow bus reset at fatal error */
 	unsigned int sync_write:1;	/* sync after verb write */
 	/* status for codec/controller */
-	unsigned int shutdown :1;	/* being unloaded */
+	unsigned int shutdown:1;	/* being unloaded */
 	unsigned int rirb_error:1;	/* error in codec communication */
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
@@ -174,7 +174,7 @@ struct hda_codec_preset {
 	const char *name;
 	int (*patch)(struct hda_codec *codec);
 };
-	
+
 struct hda_codec_preset_list {
 	const struct hda_codec_preset *preset;
 	struct module *owner;
@@ -345,7 +345,7 @@ struct hda_codec {
 #endif
 
 	/* misc flags */
-	unsigned int spdif_status_reset :1; /* needs to toggle SPDIF for each
+	unsigned int spdif_status_reset:1; /* needs to toggle SPDIF for each
 					     * status change
 					     * (e.g. Realtek codecs)
 					     */
@@ -367,7 +367,7 @@ struct hda_codec {
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 #ifdef CONFIG_PM
-	unsigned int power_on :1;	/* current (global) power-state */
+	unsigned int power_on:1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	unsigned int pm_up_notified:1;	/* PM notified to controller */
 	unsigned int in_pm:1;		/* suspend/resume being performed */
diff --git a/include/sound/hda_local.h b/include/sound/hda_local.h
index 62658f2f8c9f..d5aedd811806 100644
--- a/include/sound/hda_local.h
+++ b/include/sound/hda_local.h
@@ -26,7 +26,7 @@
 /* We abuse kcontrol_new.subdev field to pass the NID corresponding to
  * the given new control.  If id.subdev has a bit flag HDA_SUBDEV_NID_FLAG,
  * snd_hda_ctl_add() takes the lower-bit subdev value as a valid NID.
- * 
+ *
  * Note that the subdevice field is cleared again before the real registration
  * in snd_hda_ctl_add(), so that this value won't appear in the outside.
  */
@@ -36,18 +36,18 @@
 /*
  * for mixer controls
  */
-#define HDA_COMPOSE_AMP_VAL_OFS(nid,chs,idx,dir,ofs)		\
+#define HDA_COMPOSE_AMP_VAL_OFS(nid, chs, idx, dir, ofs)		\
 	((nid) | ((chs)<<16) | ((dir)<<18) | ((idx)<<19) | ((ofs)<<23))
 #define HDA_AMP_VAL_MIN_MUTE (1<<29)
-#define HDA_COMPOSE_AMP_VAL(nid,chs,idx,dir) \
+#define HDA_COMPOSE_AMP_VAL(nid, chs, idx, dir) \
 	HDA_COMPOSE_AMP_VAL_OFS(nid, chs, idx, dir, 0)
 /* mono volume with index (index=0,1,...) (channel=1,2) */
 #define HDA_CODEC_VOLUME_MONO_IDX(xname, xcidx, nid, channel, xindex, dir, flags) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xcidx,  \
 	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
 	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
-	  	    SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-	  	    SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
 	  .info = snd_hda_mixer_amp_volume_info, \
 	  .get = snd_hda_mixer_amp_volume_get, \
 	  .put = snd_hda_mixer_amp_volume_put, \
@@ -187,8 +187,8 @@ void snd_hda_sync_vmaster_hook(struct hda_vmaster_mute_hook *hook);
 	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, indices, direction) }
 
 /* stereo switch binding multiple inputs */
-#define HDA_BIND_MUTE(xname,nid,indices,dir) \
-	HDA_BIND_MUTE_MONO(xname,nid,3,indices,dir)
+#define HDA_BIND_MUTE(xname, nid, indices, dir) \
+	HDA_BIND_MUTE_MONO(xname, nid, 3, indices, dir)
 
 int snd_hda_mixer_bind_switch_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol);
diff --git a/sound/hda/hda_beep.c b/sound/hda/hda_beep.c
index 3ce849899bb5..dda5b1b6ee1a 100644
--- a/sound/hda/hda_beep.c
+++ b/sound/hda/hda_beep.c
@@ -57,7 +57,7 @@ static void snd_hda_generate_beep(struct work_struct *work)
 	}
 }
 
-/* (non-standard) Linear beep tone calculation for IDT/STAC codecs 
+/* (non-standard) Linear beep tone calculation for IDT/STAC codecs
  *
  * The tone frequency of beep generator on IDT/STAC codecs is
  * defined from the 8bit tone parameter, in Hz,
diff --git a/sound/hda/hda_codec.c b/sound/hda/hda_codec.c
index 5eb244a02b59..46eb8e14c884 100644
--- a/sound/hda/hda_codec.c
+++ b/sound/hda/hda_codec.c
@@ -2817,7 +2817,7 @@ typedef int (*map_slave_func_t)(struct hda_codec *, void *, struct snd_kcontrol
 
 /* apply the function to all matching slave ctls in the mixer list */
 static int map_slaves(struct hda_codec *codec, const char * const *slaves,
-		      const char *suffix, map_slave_func_t func, void *data) 
+			const char *suffix, map_slave_func_t func, void *data)
 {
 	struct hda_nid_item *items;
 	const char * const *s;
@@ -2877,7 +2877,7 @@ static int get_kctl_0dB_offset(struct hda_codec *codec,
 			return -1;
 		if (*step_to_check && *step_to_check != step) {
 			codec_err(codec, "Mismatching dB step for vmaster slave (%d!=%d)\n",
--				   *step_to_check, step);
+				*step_to_check, step);
 			return -1;
 		}
 		*step_to_check = step;
diff --git a/sound/hda/hda_proc.c b/sound/hda/hda_proc.c
index 9c60c8cbe89d..0f4992f93bf8 100644
--- a/sound/hda/hda_proc.c
+++ b/sound/hda/hda_proc.c
@@ -1,6 +1,6 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
- * 
+ *
  * Generic proc interface
  *
  * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
@@ -215,7 +215,7 @@ static const char *get_jack_connection(u32 cfg)
 {
 	static char *names[16] = {
 		"Unknown", "1/8", "1/4", "ATAPI",
-		"RCA", "Optical","Digital", "Analog",
+		"RCA", "Optical", "Digital", "Analog",
 		"DIN", "XLR", "RJ11", "Comb",
 		NULL, NULL, NULL, "Other"
 	};
@@ -671,7 +671,7 @@ static void print_codec_info(struct snd_info_entry *entry,
 	else
 		snd_iprintf(buffer, "No Modem Function Group found\n");
 
-	if (! codec->afg)
+	if (!codec->afg)
 		return;
 	snd_hda_power_up(codec);
 	snd_iprintf(buffer, "Default PCM:\n");
@@ -684,7 +684,7 @@ static void print_codec_info(struct snd_info_entry *entry,
 	print_power_state(buffer, codec, codec->afg);
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
-	if (! nid || nodes < 0) {
+	if (!nid || nodes < 0) {
 		snd_iprintf(buffer, "Invalid AFG subtree\n");
 		snd_hda_power_down(codec);
 		return;
-- 
1.7.9.5
