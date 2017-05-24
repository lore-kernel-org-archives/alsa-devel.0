From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 11/11] ALSA: pcm: add new configuration for
	PCM proxy drivers
Date: Wed, 24 May 2017 09:52:55 +0900
Message-ID: <20170524005255.31223-12-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3888C2671B4
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:05 +0200 (CEST)
In-Reply-To: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, ALSA PCM core got support for 'proxy' drivers.
However, in current plave, such drivers are quite minor. They're not
used so often. It's good for users to switch enabling/disabling the
feature, to reduce memory footprint.

This commit adds a new configuration; CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT.
Existent proxy drivers get dependency on the configuration.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/usb/gadget/Kconfig |  3 +--
 include/sound/pcm.h        |  2 ++
 sound/core/Kconfig         | 15 +++++++++++-
 sound/core/pcm_lib.c       | 59 +++++++++++++++++++++++++++++-----------------
 sound/core/pcm_native.c    | 14 ++++++-----
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c164d6b788c3..735b5cfa35ef 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -365,10 +365,9 @@ config USB_CONFIGFS_F_FS
 config USB_CONFIGFS_F_UAC1
 	bool "Audio Class 1.0"
 	depends on USB_CONFIGFS
-	depends on SND
 	select USB_LIBCOMPOSITE
-	select SND_PCM
 	select USB_F_UAC1
+	select SND_PCM_PROXY_DRIVER_SUPPORT
 	help
 	  This Audio function implements 1 AudioControl interface,
 	  1 AudioStreaming Interface each for USB-OUT and USB-IN.
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ffd21fe0b284..08d5ac117138 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -387,7 +387,9 @@ struct snd_pcm_runtime {
 	/* -- mmap -- */
 	struct snd_pcm_mmap_status *status;
 	struct snd_pcm_mmap_control *control;
+#if IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT)
 	int client_space;	/* Where the client puts PCM frames. Usually, 1 means user space. */
+#endif
 
 	/* -- locking / scheduling -- */
 	snd_pcm_uframes_t twake; 	/* do transfer (!poll) wakeup if non-zero */
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 9749f9e8b45c..f9660db5759e 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -58,6 +58,19 @@ config SND_SEQ_DUMMY
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-seq-dummy.
 
+config SND_PCM_PROXY_DRIVER_SUPPORT
+	bool "PCM Proxy driver support"
+	default n
+	depends on SND_PCM
+	help
+	  This feature is for PCM proxy driver support, which drives the
+	  other PCM drivers in kernel space. In a view of userspace
+	  applications, the driver gives non-ALSA interfaces to drive PCM
+	  hardwares. This config adds infrastructure for such drivers, to
+	  handle PCM frames in kernel space.
+	  The proxy drivers have a limitation of available ALSA drivers,
+	  which can delegate data transmission to stuffs in ALSA PCM core.
+
 config SND_OSSEMUL
 	select SOUND_OSS_CORE
 	bool
@@ -77,7 +90,7 @@ config SND_MIXER_OSS
 config SND_PCM_OSS
 	tristate "OSS PCM (digital audio) API"
 	select SND_OSSEMUL
-	select SND_PCM
+	select SND_PCM_PROXY_DRIVER_SUPPORT
 	help
 	  To enable OSS digital audio (PCM) emulation (/dev/dsp*), say Y
 	  here and read <file:Documentation/sound/alsa/OSS-Emulation.txt>.
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7700be3bb0c8..2d9d1b3b6fe0 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,7 +42,7 @@
 #define trace_hw_ptr_error(substream, reason)
 #endif
 
-static int writei_from_space0(struct snd_pcm_substream *substream,
+static int __maybe_unused writei_from_space0(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
 {
@@ -77,7 +77,7 @@ static int writei_from_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int writen_from_space0(struct snd_pcm_substream *substream,
+static int __maybe_unused writen_from_space0(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
 {
@@ -138,7 +138,7 @@ static int writen_from_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int readi_to_space0(struct snd_pcm_substream *substream,
+static int __maybe_unused readi_to_space0(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
 {
@@ -169,7 +169,7 @@ static int readi_to_space1(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int readn_to_space0(struct snd_pcm_substream *substream,
+static int __maybe_unused readn_to_space0(struct snd_pcm_substream *substream,
 				unsigned int hwoff, unsigned long data,
 				unsigned int off, snd_pcm_uframes_t count)
 {
@@ -287,19 +287,23 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
 		return;
 
 	if (substream->ops->copy_frames) {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			return;
-		copy_frames = substream->ops->copy_frames;
+		else
+			copy_frames = substream->ops->copy_frames;
 	} else {
 		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (runtime->client_space == 0)
+			if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+			    runtime->client_space == 0)
 				copy_frames = writei_from_space0;
 			else
 				copy_frames = writei_from_space1;
 		} else {
-			if (rnutime->client-space == 0)
-				copy_frames = writen_from_space0;
+			if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+			    runtime->client_space == 0)
+				copy_frames = writen_from_space1;
 			else
 				copy_frames = writen_from_space1;
 		}
@@ -2304,11 +2308,14 @@ snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (substream->ops->copy_frames) {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			return -ENXIO;
-		copy_frames = substream->ops->copy_frames;
+		else
+			copy_frames = substream->ops->copy_frames;
 	} else {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			copy_frames = writei_from_space0;
 		else
 			copy_frames = writei_from_space1;
@@ -2338,12 +2345,14 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (substream->ops->copy_frames) {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			return -ENXIO;
 		else
 			copy_frames = substream->ops->copy_frames;
 	} else {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			copy_frames = writen_from_space0;
 		else
 			copy_frames = writen_from_space1;
@@ -2481,11 +2490,14 @@ snd_pcm_sframes_t snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (substream->ops->copy_frames) {
-		if (runtime->client_space == 0)
-			return -ENXIO;
-		copy_frames = substream->ops->copy_frames;
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
+				return -ENXIO;
+		else
+			copy_frames = substream->ops->copy_frames;
 	} else {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			copy_frames = readi_to_space0;
 		else
 			copy_frames = readi_to_space1;
@@ -2517,11 +2529,14 @@ snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (substream->ops->copy_frames) {
-		if (runtime->client_space == 0)
-			return -ENXIO;
-		copy_frames = substream->ops->copy_frames;
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
+				return -ENXIO;
+		else
+			copy_frames = substream->ops->copy_frames;
 	} else {
-		if (runtime->client_space == 0)
+		if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT) &&
+		    runtime->client_space == 0)
 			copy_frames = readn_to_space0;
 		else
 			copy_frames = readn_to_space1;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3428583ac0d7..c6f310c17657 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -600,12 +600,14 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		pm_qos_add_request(&substream->latency_pm_qos_req,
 				   PM_QOS_CPU_DMA_LATENCY, usecs);
 
-	/*
-	 * Usual client puts PCM frames on user space, on the other
-	 * hand PCM proxy drivers puts on kernel space. This is a
-	 * switch handlers for PCM frames in different spaces.
-	 */
-	runtime->client_space = 1;
+	if (IS_ENABLED(CONFIG_SND_PCM_PROXY_DRIVER_SUPPORT)) {
+		/*
+		 * Usual client puts PCM frames on user space, on the other
+		 * hand PCM proxy drivers puts on kernel space. This is a
+		 * switch handlers for PCM frames in different spaces.
+		 */
+		runtime->client_space = 1;
+	}
 
 	return 0;
  _error:
-- 
2.11.0
