From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO
	internal command
Date: Wed, 14 Jun 2017 19:30:03 +0900
Message-ID: <20170614103004.6205-2-o-takashi@sakamocchi.jp>
References: <20170614103004.6205-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 37B3D2671E6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 12:30:09 +0200 (CEST)
In-Reply-To: <20170614103004.6205-1-o-takashi@sakamocchi.jp>
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

Drivers can implement 'struct snd_pcm_ops.ioctl' to handle some requests
from ALSA PCM core. These requests are internal purpose in kernel land.
Usually common set of operations are used for it.

SNDRV_PCM_IOCTL1_INFO is one of the requests. According to code comment,
it has been obsoleted in the old days.

We can see old releases in ftp.alsa-project.org. The command was firstly
introduced in v0.5.0 release as SND_PCM_IOCTL1_INFO, to allow drivers to
fill data of 'struct snd_pcm_channel_info' type. In v0.9.0 release,
this was obsoleted by the other commands for ioctl(2) such as
SNDRV_PCM_IOCTL_CHANNEL_INFO.

This commit removes the long-abandoned command, bye.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h     | 2 +-
 sound/core/pcm_lib.c    | 2 --
 sound/core/pcm_native.c | 6 +-----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c24f85f12b71..48e3eecac86d 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -102,7 +102,7 @@ struct snd_pcm_ops {
 #endif
 
 #define SNDRV_PCM_IOCTL1_RESET		0
-#define SNDRV_PCM_IOCTL1_INFO		1
+/* 1 is absent slot. */
 #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
 #define SNDRV_PCM_IOCTL1_GSTATE		3
 #define SNDRV_PCM_IOCTL1_FIFO_SIZE	4
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 75308ddc54ca..631cd598ba6c 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1787,8 +1787,6 @@ int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg)
 {
 	switch (cmd) {
-	case SNDRV_PCM_IOCTL1_INFO:
-		return 0;
 	case SNDRV_PCM_IOCTL1_RESET:
 		return snd_pcm_lib_ioctl_reset(substream, arg);
 	case SNDRV_PCM_IOCTL1_CHANNEL_INFO:
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 05858c91c0ea..7e8f3656b695 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -212,11 +212,7 @@ int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 	info->subdevices_avail = pstr->substream_count - pstr->substream_opened;
 	strlcpy(info->subname, substream->name, sizeof(info->subname));
 	runtime = substream->runtime;
-	/* AB: FIXME!!! This is definitely nonsense */
-	if (runtime) {
-		info->sync = runtime->sync;
-		substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_INFO, info);
-	}
+
 	return 0;
 }
 
-- 
2.11.0
