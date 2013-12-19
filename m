From: Levente Kurusa <levex@linux.com>
Subject: [PATCH 22/38] sound: ac97: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:33 +0100
Message-ID: <1387465429-3568-23-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Ondrej Zary <linux@rainbow-software.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 sound/pci/ac97/ac97_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index bf578ba2..55186f8 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1964,6 +1964,7 @@ static int snd_ac97_dev_register(struct snd_device *device)
 		     snd_ac97_get_short_name(ac97));
 	if ((err = device_register(&ac97->dev)) < 0) {
 		snd_printk(KERN_ERR "Can't register ac97 bus\n");
+		put_device(&ac97->dev);
 		ac97->dev.bus = NULL;
 		return err;
 	}
-- 
1.8.3.1
