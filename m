From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: hda - Add a common helper to give
	the codec modalias string
Date: Fri, 16 Oct 2015 18:20:55 +0200
Message-ID: <1445012458-3337-4-git-send-email-tiwai@suse.de>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BAEE266715
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:21:07 +0200 (CEST)
In-Reply-To: <1445012458-3337-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja Kp <jeeja.kp@intel.com>, Subhransu S Prusty <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch provide a new common helper function,
snd_hdac_codec_modalias(), to give the codec modalias name string.
This function will be used by multiple places in the later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h |  1 +
 sound/hda/hdac_device.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index ddca48eb02e0..e2b712c90d3f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -109,6 +109,7 @@ void snd_hdac_device_exit(struct hdac_device *dev);
 int snd_hdac_device_register(struct hdac_device *codec);
 void snd_hdac_device_unregister(struct hdac_device *codec);
 int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name);
+int snd_hdac_codec_modalias(struct hdac_device *hdac, char *buf, size_t size);
 
 int snd_hdac_refresh_widgets(struct hdac_device *codec);
 int snd_hdac_refresh_widget_sysfs(struct hdac_device *codec);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 4b06b26cee06..bbdb25f5bbb9 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -186,6 +186,21 @@ int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name)
 EXPORT_SYMBOL_GPL(snd_hdac_device_set_chip_name);
 
 /**
+ * snd_hdac_codec_modalias - give the module alias name
+ * @codec: HDAC device
+ * @buf: string buffer to store
+ * @size: string buffer size
+ *
+ * Returns the size of string, like snprintf(), or a negative error code.
+ */
+int snd_hdac_codec_modalias(struct hdac_device *codec, char *buf, size_t size)
+{
+	return snprintf(buf, size, "hdaudio:v%08Xr%08Xa%02X\n",
+			codec->vendor_id, codec->revision_id, codec->type);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_codec_modalias);
+
+/**
  * snd_hdac_make_cmd - compose a 32bit command word to be sent to the
  *	HD-audio controller
  * @codec: the codec object
-- 
2.6.1
