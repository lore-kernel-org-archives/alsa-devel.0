From: Levente Kurusa <levex@linux.com>
Subject: [PATCH 23/38] sound: soc: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:34 +0100
Message-ID: <1387465429-3568-24-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4e53d87..21caa09 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -536,6 +536,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
+		put_device(&codec->ac97->dev);
 		codec->ac97->dev.bus = NULL;
 		return err;
 	}
-- 
1.8.3.1
