From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] soc - neo1973_wm8753 - Fix module unload
Date: Tue, 22 Apr 2008 14:14:38 +0100
Message-ID: <1208870079-5325-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E6CC245B5
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 15:14:41 +0200 (CEST)
In-Reply-To: <1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Niemeyer <reddog@mastersword.de>
List-Id: alsa-devel@alsa-project.org

From: Tim Niemeyer <reddog@mastersword.de>

Signed-off-by: Tim Niemeyer <reddog@mastersword.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 6ee115c..962cc20 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -659,6 +659,7 @@ static int __init neo1973_init(void)
 
 static void __exit neo1973_exit(void)
 {
+	i2c_del_driver(&lm4857_i2c_driver);
 	platform_device_unregister(neo1973_snd_device);
 }
 
-- 
1.5.5
