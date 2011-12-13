From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v4 2/6] core: add support for compressed devices
Date: Tue, 13 Dec 2011 14:32:56 +0530
Message-ID: <1323766980-9350-3-git-send-email-vinod.koul@linux.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 12B4D103AFD
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 10:04:20 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>

Use the two minor numbers 2 and 3 for audio compressed offload devices.
Also add support for these devices in core

Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/core.h   |    1 +
 include/sound/minors.h |    7 ++++++-
 sound/core/sound.c     |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

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
index 8f76420..faaeb64 100644
--- a/include/sound/minors.h
+++ b/include/sound/minors.h
@@ -35,7 +35,8 @@
 #define SNDRV_MINOR_TIMER		33	/* SNDRV_MINOR_GLOBAL + 1 * 32 */
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
-						/* 2 - 3 (reserved) */
+#define SNDRV_MINOR_COMPR_PLAYBACK	2
+#define SNDRV_MINOR_COMPR_CAPTURE	3
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
@@ -49,6 +50,8 @@
 #define SNDRV_DEVICE_TYPE_PCM_CAPTURE	SNDRV_MINOR_PCM_CAPTURE
 #define SNDRV_DEVICE_TYPE_SEQUENCER	SNDRV_MINOR_SEQUENCER
 #define SNDRV_DEVICE_TYPE_TIMER		SNDRV_MINOR_TIMER
+#define SNDRV_DEVICE_TYPE_COMPR_PLAYBACK SNDRV_MINOR_COMPR_PLAYBACK
+#define SNDRV_DEVICE_TYPE_COMPR_CAPTURE	SNDRV_MINOR_COMPR_CAPTURE
 
 #else /* CONFIG_SND_DYNAMIC_MINORS */
 
@@ -60,6 +63,8 @@ enum {
 	SNDRV_DEVICE_TYPE_RAWMIDI,
 	SNDRV_DEVICE_TYPE_PCM_PLAYBACK,
 	SNDRV_DEVICE_TYPE_PCM_CAPTURE,
+	SNDRV_DEVICE_TYPE_COMPR_PLAYBACK,
+	SNDRV_DEVICE_TYPE_COMPR_CAPTURE,
 };
 
 #endif /* CONFIG_SND_DYNAMIC_MINORS */
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 828af35..2b680dd 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -233,6 +233,12 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
 			return -EINVAL;
 		minor = SNDRV_MINOR(card->number, type + dev);
 		break;
+	case SNDRV_DEVICE_TYPE_COMPR_PLAYBACK:
+	case SNDRV_DEVICE_TYPE_COMPR_CAPTURE:
+		if (snd_BUG_ON(!card))
+			return -EINVAL;
+		minor = SNDRV_MINOR(card->number, type);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.0.4
