From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Check the return value from
	pm_runtime_get/put*()
Date: Fri, 17 Jul 2015 17:08:03 +0200
Message-ID: <1437145683-24477-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 726242604D5
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 17:08:06 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34FFDAC1D
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 15:08:05 +0000 (UTC)
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

This patch changes the return type of snd_hdac_power_up/down() and
variants to pass the error code from the underlying
pm_runtime_get/put() calls.  Currently they are ignored, but in most
places, these should be handled properly.

As an example, the regmap handler is updated to check the return value
and accesses the register only when the wakeup succeeds.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h | 16 ++++++++--------
 sound/hda/hdac_device.c | 26 ++++++++++++++++++--------
 sound/hda/hdac_regmap.c | 10 ++++++----
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 4caf1fde8a4f..288c7fa509d8 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -164,15 +164,15 @@ static inline int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid,
 }
 
 #ifdef CONFIG_PM
-void snd_hdac_power_up(struct hdac_device *codec);
-void snd_hdac_power_down(struct hdac_device *codec);
-void snd_hdac_power_up_pm(struct hdac_device *codec);
-void snd_hdac_power_down_pm(struct hdac_device *codec);
+int snd_hdac_power_up(struct hdac_device *codec);
+int snd_hdac_power_down(struct hdac_device *codec);
+int snd_hdac_power_up_pm(struct hdac_device *codec);
+int snd_hdac_power_down_pm(struct hdac_device *codec);
 #else
-static inline void snd_hdac_power_up(struct hdac_device *codec) {}
-static inline void snd_hdac_power_down(struct hdac_device *codec) {}
-static inline void snd_hdac_power_up_pm(struct hdac_device *codec) {}
-static inline void snd_hdac_power_down_pm(struct hdac_device *codec) {}
+static inline int snd_hdac_power_up(struct hdac_device *codec) { return 0; }
+static inline int snd_hdac_power_down(struct hdac_device *codec) { return 0; }
+static inline int snd_hdac_power_up_pm(struct hdac_device *codec) { return 0; }
+static inline int snd_hdac_power_down_pm(struct hdac_device *codec) { return 0; }
 #endif
 
 /*
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index cdee7103f649..df7039ebe1fa 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -501,23 +501,27 @@ EXPORT_SYMBOL_GPL(snd_hdac_get_connections);
  * This function calls the runtime PM helper to power up the given codec.
  * Unlike snd_hdac_power_up_pm(), you should call this only for the code
  * path that isn't included in PM path.  Otherwise it gets stuck.
+ *
+ * Returns zero if successful, or a negative error code.
  */
-void snd_hdac_power_up(struct hdac_device *codec)
+int snd_hdac_power_up(struct hdac_device *codec)
 {
-	pm_runtime_get_sync(&codec->dev);
+	return pm_runtime_get_sync(&codec->dev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_up);
 
 /**
  * snd_hdac_power_down - power down the codec
  * @codec: the codec object
+ *
+ * Returns zero if successful, or a negative error code.
  */
-void snd_hdac_power_down(struct hdac_device *codec)
+int snd_hdac_power_down(struct hdac_device *codec)
 {
 	struct device *dev = &codec->dev;
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	return pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_down);
 
@@ -529,11 +533,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_down);
  * which may be called by PM suspend/resume again.  OTOH, if a power-up
  * call must wake up the sleeper (e.g. in a kctl callback), use
  * snd_hdac_power_up() instead.
+ *
+ * Returns zero if successful, or a negative error code.
  */
-void snd_hdac_power_up_pm(struct hdac_device *codec)
+int snd_hdac_power_up_pm(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm))
-		snd_hdac_power_up(codec);
+		return snd_hdac_power_up(codec);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 
@@ -543,11 +550,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
  *
  * Like snd_hdac_power_up_pm(), this function is used in a recursive
  * code path like init code which may be called by PM suspend/resume again.
+ *
+ * Returns zero if successful, or a negative error code.
  */
-void snd_hdac_power_down_pm(struct hdac_device *codec)
+int snd_hdac_power_down_pm(struct hdac_device *codec)
 {
 	if (atomic_dec_if_positive(&codec->in_pm) < 0)
-		snd_hdac_power_down(codec);
+		return snd_hdac_power_down(codec);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 1eabcdf69457..b0ed870ffb88 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -410,8 +410,9 @@ int snd_hdac_regmap_write_raw(struct hdac_device *codec, unsigned int reg,
 
 	err = reg_raw_write(codec, reg, val);
 	if (err == -EAGAIN) {
-		snd_hdac_power_up_pm(codec);
-		err = reg_raw_write(codec, reg, val);
+		err = snd_hdac_power_up_pm(codec);
+		if (!err)
+			err = reg_raw_write(codec, reg, val);
 		snd_hdac_power_down_pm(codec);
 	}
 	return err;
@@ -442,8 +443,9 @@ int snd_hdac_regmap_read_raw(struct hdac_device *codec, unsigned int reg,
 
 	err = reg_raw_read(codec, reg, val);
 	if (err == -EAGAIN) {
-		snd_hdac_power_up_pm(codec);
-		err = reg_raw_read(codec, reg, val);
+		err = snd_hdac_power_up_pm(codec);
+		if (!err)
+			err = reg_raw_read(codec, reg, val);
 		snd_hdac_power_down_pm(codec);
 	}
 	return err;
-- 
2.4.5
