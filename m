From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix another race in runtime PM
	refcounting
Date: Mon, 13 Apr 2015 13:22:37 +0200
Message-ID: <1428924157-6288-2-git-send-email-tiwai@suse.de>
References: <1428924157-6288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE28261AD0
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 13:22:41 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8B0AEAD6D
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 11:22:41 +0000 (UTC)
In-Reply-To: <1428924157-6288-1-git-send-email-tiwai@suse.de>
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

Although some races in runtime PM refcount was fixed by the commit
[664c715573c2: ALSA: hda - Work around races of power up/down with
runtime PM], there is still a race in the following case:

CPU0:                   CPU1 :
runtime suspend:
  codec->in_pm = 1
                        snd_hdac_power_up_pm():
                          pm_runtime_get_sync() skipped
suspend finished:
  codec->in_pm = 0
                        snd_hdac_power_down_pm():
                          pm_runtime_put_*() is called!

For avoiding this situation, increment in_pm flag atomically when it's
non-zero, and decrement accordingly, to ensure that in_pm is set
consistently for the whole concurrent operations.

Also, since atomic_inc_not_zero() and atomic_dec_if_positive() are
lengthy inline functions, move snd_hdac_power_up_pm() and _down_pm()
to sound/hda/hdac_device.c as no inline functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h | 32 ++++----------------------------
 sound/hda/hdac_device.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 30446f17c6a6..2a8aa9dfb83d 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -139,39 +139,15 @@ static inline int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid,
 #ifdef CONFIG_PM
 void snd_hdac_power_up(struct hdac_device *codec);
 void snd_hdac_power_down(struct hdac_device *codec);
+void snd_hdac_power_up_pm(struct hdac_device *codec);
+void snd_hdac_power_down_pm(struct hdac_device *codec);
 #else
 static inline void snd_hdac_power_up(struct hdac_device *codec) {}
 static inline void snd_hdac_power_down(struct hdac_device *codec) {}
+static inline void snd_hdac_power_up_pm(struct hdac_device *codec) {}
+static inline void snd_hdac_power_down_pm(struct hdac_device *codec) {}
 #endif
 
-/**
- * snd_hdac_power_up_pm - power up the codec
- * @codec: the codec object
- *
- * This function can be called in a recursive code path like init code
- * which may be called by PM suspend/resume again.  OTOH, if a power-up
- * call must wake up the sleeper (e.g. in a kctl callback), use
- * snd_hdac_power_up() instead.
- */
-static inline void snd_hdac_power_up_pm(struct hdac_device *codec)
-{
-	if (!atomic_read(&codec->in_pm))
-		snd_hdac_power_up(codec);
-}
-
-/**
- * snd_hdac_power_down_pm - power down the codec
- * @codec: the codec object
- *
- * Like snd_hdac_power_up_pm(), this function is used in a recursive
- * code path like init code which may be called by PM suspend/resume again.
- */
-static inline void snd_hdac_power_down_pm(struct hdac_device *codec)
-{
-	if (!atomic_read(&codec->in_pm))
-		snd_hdac_power_down(codec);
-}
-
 /*
  * HD-audio codec base driver
  */
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 92604bbcee5f..f75bf5622687 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -519,6 +519,36 @@ void snd_hdac_power_down(struct hdac_device *codec)
 	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_down);
+
+/**
+ * snd_hdac_power_up_pm - power up the codec
+ * @codec: the codec object
+ *
+ * This function can be called in a recursive code path like init code
+ * which may be called by PM suspend/resume again.  OTOH, if a power-up
+ * call must wake up the sleeper (e.g. in a kctl callback), use
+ * snd_hdac_power_up() instead.
+ */
+void snd_hdac_power_up_pm(struct hdac_device *codec)
+{
+	if (!atomic_inc_not_zero(&codec->in_pm))
+		snd_hdac_power_up(codec);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
+
+/**
+ * snd_hdac_power_down_pm - power down the codec
+ * @codec: the codec object
+ *
+ * Like snd_hdac_power_up_pm(), this function is used in a recursive
+ * code path like init code which may be called by PM suspend/resume again.
+ */
+void snd_hdac_power_down_pm(struct hdac_device *codec)
+{
+	if (atomic_dec_if_positive(&codec->in_pm) < 0)
+		snd_hdac_power_down(codec);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
 
 /* codec vendor labels */
-- 
2.3.5
