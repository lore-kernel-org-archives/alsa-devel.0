From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: fix the return value for SNDRV_COMPRESS_VERSION
Date: Mon, 29 Jul 2013 15:10:22 +0530
Message-ID: <1375090822-6502-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

the return value of SNDRV_COMPRESS_VERSION always return default -ENOTTY as the
return value was never updated for this call
assign return value from put_user()

Reported-by: Haynes <hgeorge@codeaurora.org>
CC: stable@vger.kernel.org
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 99db892..9896954 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -743,7 +743,7 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	mutex_lock(&stream->device->lock);
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
-		put_user(SNDRV_COMPRESS_VERSION,
+		retval = put_user(SNDRV_COMPRESS_VERSION,
 				(int __user *)arg) ? -EFAULT : 0;
 		break;
 	case _IOC_NR(SNDRV_COMPRESS_GET_CAPS):
-- 
1.7.0.4
