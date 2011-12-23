From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v5 2/6] core: add support for compressed devices
Date: Fri, 23 Dec 2011 10:36:36 +0530
Message-ID: <1324616800-19749-3-git-send-email-vinod.koul@linux.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE0E103FAB
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 06:06:51 +0100 (CET)
In-Reply-To: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>

Use the minor numbers 2 and 3 for audio compressed offload devices.
Also add support for these devices in core

Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/core.h   |    1 +
 include/sound/minors.h |    4 +++-
 sound/core/sound.c     |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 3be5ab7..5ab255f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -62,6 +62,7 @@ typedef int __bitwise snd_device_type_t;
 #define	SNDRV_DEV_BUS		((__force snd_device_type_t) 0x1007)
 #define	SNDRV_DEV_CODEC		((__force snd_device_type_t) 0x1008)
 #define	SNDRV_DEV_JACK          ((__force snd_device_type_t) 0x1009)
+#define	SNDRV_DEV_COMPRESS	((__force snd_device_type_t) 0x100A)
 #define	SNDRV_DEV_LOWLEVEL	((__force snd_device_type_t) 0x2000)
 
 typedef int __bitwise snd_device_state_t;
diff --git a/include/sound/minors.h b/include/sound/minors.h
index 8f76420..5978f9a 100644
--- a/include/sound/minors.h
+++ b/include/sound/minors.h
@@ -35,7 +35,7 @@
 #define SNDRV_MINOR_TIMER		33	/* SNDRV_MINOR_GLOBAL + 1 * 32 */
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
-						/* 2 - 3 (reserved) */
+#define SNDRV_MINOR_COMPRESS		2	/* 2 - 3 */
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
@@ -49,6 +49,7 @@
 #define SNDRV_DEVICE_TYPE_PCM_CAPTURE	SNDRV_MINOR_PCM_CAPTURE
 #define SNDRV_DEVICE_TYPE_SEQUENCER	SNDRV_MINOR_SEQUENCER
 #define SNDRV_DEVICE_TYPE_TIMER		SNDRV_MINOR_TIMER
+#define SNDRV_DEVICE_TYPE_COMPRESS	SNDRV_MINOR_COMPRESS
 
 #else /* CONFIG_SND_DYNAMIC_MINORS */
 
@@ -60,6 +61,7 @@ enum {
 	SNDRV_DEVICE_TYPE_RAWMIDI,
 	SNDRV_DEVICE_TYPE_PCM_PLAYBACK,
 	SNDRV_DEVICE_TYPE_PCM_CAPTURE,
+	SNDRV_DEVICE_TYPE_COMPRESS,
 };
 
 #endif /* CONFIG_SND_DYNAMIC_MINORS */
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 828af35..28f3559 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -229,6 +229,7 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
 	case SNDRV_DEVICE_TYPE_RAWMIDI:
 	case SNDRV_DEVICE_TYPE_PCM_PLAYBACK:
 	case SNDRV_DEVICE_TYPE_PCM_CAPTURE:
+	case SNDRV_DEVICE_TYPE_COMPRESS:
 		if (snd_BUG_ON(!card))
 			return -EINVAL;
 		minor = SNDRV_MINOR(card->number, type + dev);
-- 
1.7.0.4
