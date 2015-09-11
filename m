From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ALSA: hdsp: fix memory leak
Date: Fri, 11 Sep 2015 19:10:38 +0530
Message-ID: <1441978838-18803-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

If the size of the firmware is less than expected size then we are
exiting with the error code but we missed releasing the firmware.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/rme9652/hdsp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 9bba275..2875b4f 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5112,6 +5112,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 		dev_err(hdsp->card->dev,
 			"too short firmware size %d (expected %d)\n",
 			   (int)fw->size, HDSP_FIRMWARE_SIZE);
+		release_firmware(fw);
 		return -EINVAL;
 	}
 
-- 
1.9.1
