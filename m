From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/14] ALSA: pcm: Build OSS writev/readv
	helpers conditionally
Date: Thu, 25 May 2017 21:17:35 +0200
Message-ID: <20170525191735.13787-15-tiwai@suse.de>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB672267395
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:41 +0200 (CEST)
In-Reply-To: <20170525191735.13787-1-tiwai@suse.de>
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

The snd_pcm_oss_writev3() and snd_pcm_oss_readv3() are used only in
io.c with CONFIG_SND_PCM_OSS_PLUGINS=y.  Add an ifdef to reduce the
build of these functions.

Along with it, since they are called always for in-kernel copy, reduce
the argument and call snd_pcm_kernel_writev() and *_readv() directly
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/io.c         |  4 ++--
 sound/core/oss/pcm_oss.c    | 12 ++++++------
 sound/core/oss/pcm_plugin.h |  6 ++----
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/core/oss/io.c b/sound/core/oss/io.c
index 6faa1d719206..d870b2d93135 100644
--- a/sound/core/oss/io.c
+++ b/sound/core/oss/io.c
@@ -26,9 +26,9 @@
 #include "pcm_plugin.h"
 
 #define pcm_write(plug,buf,count) snd_pcm_oss_write3(plug,buf,count,1)
-#define pcm_writev(plug,vec,count) snd_pcm_oss_writev3(plug,vec,count,1)
+#define pcm_writev(plug,vec,count) snd_pcm_oss_writev3(plug,vec,count)
 #define pcm_read(plug,buf,count) snd_pcm_oss_read3(plug,buf,count,1)
-#define pcm_readv(plug,vec,count) snd_pcm_oss_readv3(plug,vec,count,1)
+#define pcm_readv(plug,vec,count) snd_pcm_oss_readv3(plug,vec,count)
 
 /*
  *  Basic io plugin
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 2d6a825cfe88..5e1009d959a8 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1232,7 +1232,8 @@ snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream, char *p
 	return ret;
 }
 
-snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void **bufs, snd_pcm_uframes_t frames, int in_kernel)
+#ifdef CONFIG_SND_PCM_OSS_PLUGINS
+snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void **bufs, snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
@@ -1249,8 +1250,7 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void
 			if (ret < 0)
 				break;
 		}
-		ret = __snd_pcm_lib_xfer(substream, bufs, false, frames,
-					 in_kernel);
+		ret = snd_pcm_kernel_writev(substream, bufs, frames);
 		if (ret != -EPIPE && ret != -ESTRPIPE)
 			break;
 
@@ -1262,7 +1262,7 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void
 	return ret;
 }
 	
-snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream, void **bufs, snd_pcm_uframes_t frames, int in_kernel)
+snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream, void **bufs, snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
@@ -1283,13 +1283,13 @@ snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream, void *
 			if (ret < 0)
 				break;
 		}
-		ret = __snd_pcm_lib_xfer(substream, bufs, false, frames,
-					 in_kernel);
+		ret = snd_pcm_kernel_readv(substream, bufs, frames);
 		if (ret != -EPIPE && ret != -ESTRPIPE)
 			break;
 	}
 	return ret;
 }
+#endif /* CONFIG_SND_PCM_OSS_PLUGINS */
 
 static ssize_t snd_pcm_oss_write2(struct snd_pcm_substream *substream, const char *buf, size_t bytes, int in_kernel)
 {
diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index 73c068abaca5..c9cd29d86efd 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -162,11 +162,9 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream,
 snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream,
 				    char *ptr, snd_pcm_uframes_t size, int in_kernel);
 snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream,
-				      void **bufs, snd_pcm_uframes_t frames,
-				      int in_kernel);
+				      void **bufs, snd_pcm_uframes_t frames);
 snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
-				     void **bufs, snd_pcm_uframes_t frames,
-				     int in_kernel);
+				     void **bufs, snd_pcm_uframes_t frames);
 
 #else
 
-- 
2.13.0
