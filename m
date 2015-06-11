From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Re-add the lost fake mute support
Date: Thu, 11 Jun 2015 11:02:16 +0200
Message-ID: <1434013336-26011-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF7F3264F10
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 11:02:17 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 68B2CABE8
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 09:02:17 +0000 (UTC)
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

Yet another regression by the transition to regmap cache; for better
usability, we had the fake mute control using the zero amp value for
Conexant codecs, and this was forgotten in the new hda core code.

Since the bits 4-7 are unused for the amp registers (as we follow the
syntax of AMP_GET verb), the bit 4 is now used to indicate the fake
mute.  For setting this flag, snd_hda_codec_amp_update() becomes a
function from a simple macro.  The bonus is that it gained a proper
function description.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_regmap.h |  2 ++
 sound/hda/hdac_regmap.c    |  5 +++++
 sound/pci/hda/hda_codec.c  | 23 +++++++++++++++++++++++
 sound/pci/hda/hda_local.h  |  4 ++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/sound/hda_regmap.h b/include/sound/hda_regmap.h
index 53a18b3635e2..df705908480a 100644
--- a/include/sound/hda_regmap.h
+++ b/include/sound/hda_regmap.h
@@ -9,6 +9,8 @@
 #include <sound/core.h>
 #include <sound/hdaudio.h>
 
+#define AC_AMP_FAKE_MUTE	0x10	/* fake mute bit set to amp verbs */
+
 int snd_hdac_regmap_init(struct hdac_device *codec);
 void snd_hdac_regmap_exit(struct hdac_device *codec);
 int snd_hdac_regmap_add_vendor_verb(struct hdac_device *codec,
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index c4f5e61d4404..1eabcdf69457 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -246,6 +246,9 @@ static int hda_reg_read(void *context, unsigned int reg, unsigned int *val)
 		return hda_reg_read_stereo_amp(codec, reg, val);
 	if (verb == AC_VERB_GET_PROC_COEF)
 		return hda_reg_read_coef(codec, reg, val);
+	if ((verb & 0x700) == AC_VERB_SET_AMP_GAIN_MUTE)
+		reg &= ~AC_AMP_FAKE_MUTE;
+
 	err = snd_hdac_exec_verb(codec, reg, 0, val);
 	if (err < 0)
 		return err;
@@ -283,6 +286,8 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 
 	switch (verb & 0xf00) {
 	case AC_VERB_SET_AMP_GAIN_MUTE:
+		if ((reg & AC_AMP_FAKE_MUTE) && (val & AC_AMP_MUTE))
+			val = 0;
 		verb = AC_VERB_SET_AMP_GAIN_MUTE;
 		if (reg & AC_AMP_GET_LEFT)
 			verb |= AC_AMP_SET_LEFT >> 8;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b7782212dd64..3a3670168f12 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1376,6 +1376,29 @@ int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 EXPORT_SYMBOL_GPL(snd_hda_override_amp_caps);
 
 /**
+ * snd_hda_codec_amp_update - update the AMP mono value
+ * @codec: HD-audio codec
+ * @nid: NID to read the AMP value
+ * @ch: channel to update (0 or 1)
+ * @dir: #HDA_INPUT or #HDA_OUTPUT
+ * @idx: the index value (only for input direction)
+ * @mask: bit mask to set
+ * @val: the bits value to set
+ *
+ * Update the AMP values for the given channel, direction and index.
+ */
+int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid,
+			     int ch, int dir, int idx, int mask, int val)
+{
+	unsigned int cmd = snd_hdac_regmap_encode_amp(nid, ch, dir, idx);
+
+	if (query_amp_caps(codec, nid, dir) & AC_AMPCAP_MIN_MUTE)
+		cmd |= AC_AMP_FAKE_MUTE;
+	return snd_hdac_regmap_update_raw(&codec->core, cmd, mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_hda_codec_amp_update);
+
+/**
  * snd_hda_codec_amp_stereo - update the AMP stereo values
  * @codec: HD-audio codec
  * @nid: NID to read the AMP value
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 3b567f42296b..bed66c314431 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -129,8 +129,8 @@ int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 /* lowlevel accessor with caching; use carefully */
 #define snd_hda_codec_amp_read(codec, nid, ch, dir, idx) \
 	snd_hdac_regmap_get_amp(&(codec)->core, nid, ch, dir, idx)
-#define snd_hda_codec_amp_update(codec, nid, ch, dir, idx, mask, val) \
-	snd_hdac_regmap_update_amp(&(codec)->core, nid, ch, dir, idx, mask, val)
+int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid,
+			     int ch, int dir, int idx, int mask, int val);
 int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 			     int dir, int idx, int mask, int val);
 int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
-- 
2.4.3
