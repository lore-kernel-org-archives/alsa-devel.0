From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: ux500: add MODULE_LICENSE tag
Date: Wed, 10 Jan 2018 17:34:45 +0100
Message-ID: <20180110163503.603206-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC05266A74
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 17:35:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, Donglin Peng <dolinux.peng@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ux500/mop500.c    | 4 ++++
 sound/soc/ux500/ux500_pcm.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 070a6880980e..c60a57797640 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -163,3 +163,7 @@ static struct platform_driver snd_soc_mop500_driver = {
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index f12c01dddc8d..d35ba7700f46 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -165,3 +165,8 @@ int ux500_pcm_unregister_platform(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
