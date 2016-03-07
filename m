From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix unexpected resume through
	regmap code path
Date: Mon,  7 Mar 2016 17:22:24 +0100
Message-ID: <1457367744-4449-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C473126145A
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 17:22:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 02D47ADDF
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 16:22:26 +0000 (UTC)
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

HD-audio driver has a mechanism to trigger the runtime resume
automatically at accessing the verbs.  This auto-resume, however,
causes the mutex deadlock when invoked from the regmap handler since
the regmap keeps the mutex while auto-resuming.  For avoiding that,
there is some tricky check in the HDA regmap handler to return -EAGAIN
error to back-off when the codec is powered down.  Then the caller of
regmap r/w will retry after properly turning on the codec power.

This works in most cases, but there seems a slight race between the
codec power check and the actual on-demand auto-resume trigger.  This
resulted in the lockdep splat, eventually leading to a real deadlock.

This patch tries to address the race window by getting the runtime PM
refcount at the check time using pm_runtime_get_if_in_use().  With
this call, we can keep the power on only when the codec has been
already turned on, and back off if not.

For keeping the code consistency, the code touching the runtime PM is
stored in hdac_device.c although it's used only locally in
hdac_regmap.c.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h |  2 ++
 sound/hda/hdac_device.c | 16 ++++++++++++
 sound/hda/hdac_regmap.c | 69 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index c21c38ce7450..93e63c56f48f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -168,11 +168,13 @@ int snd_hdac_power_up(struct hdac_device *codec);
 int snd_hdac_power_down(struct hdac_device *codec);
 int snd_hdac_power_up_pm(struct hdac_device *codec);
 int snd_hdac_power_down_pm(struct hdac_device *codec);
+int snd_hdac_keep_power_up(struct hdac_device *codec);
 #else
 static inline int snd_hdac_power_up(struct hdac_device *codec) { return 0; }
 static inline int snd_hdac_power_down(struct hdac_device *codec) { return 0; }
 static inline int snd_hdac_power_up_pm(struct hdac_device *codec) { return 0; }
 static inline int snd_hdac_power_down_pm(struct hdac_device *codec) { return 0; }
+static inline int snd_hdac_keep_power_up(struct hdac_device *codec) { return 0; }
 #endif
 
 /*
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index e361024eabb6..d1a4d6973330 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,6 +611,22 @@ int snd_hdac_power_up_pm(struct hdac_device *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 
+/* like snd_hdac_power_up_pm(), but only increment the pm count when
+ * already powered up.  Returns -1 if not powered up, 1 if incremented
+ * or 0 if unchanged.  Only used in hdac_regmap.c
+ */
+int snd_hdac_keep_power_up(struct hdac_device *codec)
+{
+	if (!atomic_inc_not_zero(&codec->in_pm)) {
+		int ret = pm_runtime_get_if_in_use(&codec->dev);
+		if (!ret)
+			return -1;
+		if (ret < 0)
+			return 0;
+	}
+	return 1;
+}
+
 /**
  * snd_hdac_power_down_pm - power down the codec
  * @codec: the codec object
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index eb8f7c30cb09..bdbcd6b75ff6 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -21,13 +21,16 @@
 #include <sound/hdaudio.h>
 #include <sound/hda_regmap.h>
 
-#ifdef CONFIG_PM
-#define codec_is_running(codec)				\
-	(atomic_read(&(codec)->in_pm) ||		\
-	 !pm_runtime_suspended(&(codec)->dev))
-#else
-#define codec_is_running(codec)		true
-#endif
+static int codec_pm_lock(struct hdac_device *codec)
+{
+	return snd_hdac_keep_power_up(codec);
+}
+
+static void codec_pm_unlock(struct hdac_device *codec, int lock)
+{
+	if (lock == 1)
+		snd_hdac_power_down_pm(codec);
+}
 
 #define get_verb(reg)	(((reg) >> 8) & 0xfff)
 
@@ -238,20 +241,28 @@ static int hda_reg_read(void *context, unsigned int reg, unsigned int *val)
 	struct hdac_device *codec = context;
 	int verb = get_verb(reg);
 	int err;
+	int pm_lock = 0;
 
-	if (!codec_is_running(codec) && verb != AC_VERB_GET_POWER_STATE)
-		return -EAGAIN;
+	if (verb != AC_VERB_GET_POWER_STATE) {
+		pm_lock = codec_pm_lock(codec);
+		if (pm_lock < 0)
+			return -EAGAIN;
+	}
 	reg |= (codec->addr << 28);
-	if (is_stereo_amp_verb(reg))
-		return hda_reg_read_stereo_amp(codec, reg, val);
-	if (verb == AC_VERB_GET_PROC_COEF)
-		return hda_reg_read_coef(codec, reg, val);
+	if (is_stereo_amp_verb(reg)) {
+		err = hda_reg_read_stereo_amp(codec, reg, val);
+		goto out;
+	}
+	if (verb == AC_VERB_GET_PROC_COEF) {
+		err = hda_reg_read_coef(codec, reg, val);
+		goto out;
+	}
 	if ((verb & 0x700) == AC_VERB_SET_AMP_GAIN_MUTE)
 		reg &= ~AC_AMP_FAKE_MUTE;
 
 	err = snd_hdac_exec_verb(codec, reg, 0, val);
 	if (err < 0)
-		return err;
+		goto out;
 	/* special handling for asymmetric reads */
 	if (verb == AC_VERB_GET_POWER_STATE) {
 		if (*val & AC_PWRST_ERROR)
@@ -259,7 +270,9 @@ static int hda_reg_read(void *context, unsigned int reg, unsigned int *val)
 		else /* take only the actual state */
 			*val = (*val >> 4) & 0x0f;
 	}
-	return 0;
+ out:
+	codec_pm_unlock(codec, pm_lock);
+	return err;
 }
 
 static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
@@ -267,6 +280,7 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct hdac_device *codec = context;
 	unsigned int verb;
 	int i, bytes, err;
+	int pm_lock = 0;
 
 	if (codec->caps_overwriting)
 		return 0;
@@ -275,14 +289,21 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 	reg |= (codec->addr << 28);
 	verb = get_verb(reg);
 
-	if (!codec_is_running(codec) && verb != AC_VERB_SET_POWER_STATE)
-		return codec->lazy_cache ? 0 : -EAGAIN;
+	if (verb != AC_VERB_SET_POWER_STATE) {
+		pm_lock = codec_pm_lock(codec);
+		if (pm_lock < 0)
+			return codec->lazy_cache ? 0 : -EAGAIN;
+	}
 
-	if (is_stereo_amp_verb(reg))
-		return hda_reg_write_stereo_amp(codec, reg, val);
+	if (is_stereo_amp_verb(reg)) {
+		err = hda_reg_write_stereo_amp(codec, reg, val);
+		goto out;
+	}
 
-	if (verb == AC_VERB_SET_PROC_COEF)
-		return hda_reg_write_coef(codec, reg, val);
+	if (verb == AC_VERB_SET_PROC_COEF) {
+		err = hda_reg_write_coef(codec, reg, val);
+		goto out;
+	}
 
 	switch (verb & 0xf00) {
 	case AC_VERB_SET_AMP_GAIN_MUTE:
@@ -319,10 +340,12 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 		reg |= (verb + i) << 8 | ((val >> (8 * i)) & 0xff);
 		err = snd_hdac_exec_verb(codec, reg, 0, NULL);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
-	return 0;
+ out:
+	codec_pm_unlock(codec, pm_lock);
+	return err;
 }
 
 static const struct regmap_config hda_regmap_cfg = {
-- 
2.7.2
