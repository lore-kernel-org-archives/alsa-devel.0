From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] emu10k1: correctly handling failed thread creation
Date: Thu, 28 Jan 2016 18:51:37 -0500
Message-ID: <1454025097-13153-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, michael@gernoth.net, lambert.quentin@gmail.com, pzubaj@marticonet.sk, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since kthread_create can be failed, it needs to check 
whether error occurred and return error code.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 sound/pci/emu10k1/emu10k1_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 28e2f8b..b9eac15 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1141,6 +1141,12 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 		emu->emu1010.firmware_thread =
 			kthread_create(emu1010_firmware_thread, emu,
 				       "emu1010_firmware");
+		if (IS_ERR(emu->emu1010.firmware_thread)) {
+			dev_info(emu->card->dev,
+					"emu1010: Creating thread failed\n");
+			return PTR_ERR(emu->emu1010.firmware_thread);
+		}
+
 		wake_up_process(emu->emu1010.firmware_thread);
 	}
 
-- 
1.9.1
