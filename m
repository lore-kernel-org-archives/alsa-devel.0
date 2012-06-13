From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH] ASoC: Ux500: Correct license strings
Date: Wed, 13 Jun 2012 10:09:51 +0200
Message-ID: <1339574991-20316-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 5634824446
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 10:10:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

GPLv2 -> GPL v2

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/codecs/ab8500-codec.c |    2 +-
 sound/soc/ux500/ux500_msp_dai.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c |    2 +-
 sound/soc/ux500/ux500_pcm.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index dba246a..dd419c8 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2510,4 +2510,4 @@ static struct platform_driver ab8500_codec_platform_driver = {
 };
 module_platform_driver(ab8500_codec_platform_driver);
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 93c6c40..62ac028 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -840,4 +840,4 @@ static struct platform_driver msp_i2s_driver = {
 };
 module_platform_driver(msp_i2s_driver);
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 496dec1..ee14d2d 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -739,4 +739,4 @@ void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
 	devm_kfree(&pdev->dev, msp);
 }
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 66b080e..97d8e4d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -315,4 +315,4 @@ static struct platform_driver ux500_pcm_driver = {
 };
 module_platform_driver(ux500_pcm_driver);
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
1.7.8.3
