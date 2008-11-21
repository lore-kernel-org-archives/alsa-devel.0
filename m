From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/10] ASoC: Improve error reporting for AC97
	reset failures
Date: Fri, 21 Nov 2008 14:48:33 +0000
Message-ID: <1227278913-25313-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 553BA244E0
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:36 +0100 (CET)
In-Reply-To: <1227278913-25313-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Print something a bit more verbose to help make errors a little more
obvious.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ad1980.c |    2 +-
 sound/soc/codecs/wm9712.c |    2 +-
 sound/soc/codecs/wm9713.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 410fed9..1a3ea05 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -238,7 +238,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 
 	ret = ad1980_reset(codec, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "AC97 link error\n");
+		printk(KERN_ERR "Failed to reset AD1980: AC97 link error\n");
 		goto reset_err;
 	}
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 81c38e7..6e3e0f3 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -690,7 +690,7 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 
 	ret = wm9712_reset(codec, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "AC97 link error\n");
+		printk(KERN_ERR "Failed to reset WM9712: AC97 link error\n");
 		goto reset_err;
 	}
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index a0cc5ac..7be811a 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1243,7 +1243,7 @@ static int wm9713_soc_probe(struct platform_device *pdev)
 	wm9713_reset(codec, 0);
 	ret = wm9713_reset(codec, 1);
 	if (ret < 0) {
-		printk(KERN_ERR "AC97 link error\n");
+		printk(KERN_ERR "Failed to reset WM9713: AC97 link error\n");
 		goto reset_err;
 	}
 
-- 
1.5.6.5
