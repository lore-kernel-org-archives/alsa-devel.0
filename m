From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin TDM: use external frame syncs
Date: Wed, 12 Jan 2011 02:59:55 -0500
Message-ID: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id EC44324399
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 08:52:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

We don't want to use internal frame syncs otherwise we sometimes
get out of sync, so don't enable them when setting up the SPORT.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-tdm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index b2cf239..5515ac9 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -235,13 +235,13 @@ static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 		ret = -EBUSY;
 	}
 
-	ret = sport_config_rx(sport, IRFS, 0x1F, 0, 0);
+	ret = sport_config_rx(sport, 0, 0x1F, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
 	}
 
-	ret = sport_config_tx(sport, ITFS, 0x1F, 0, 0);
+	ret = sport_config_tx(sport, 0, 0x1F, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
@@ -303,14 +303,14 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		goto sport_config_err;
 	}
 
-	ret = sport_config_rx(sport_handle, IRFS, 0x1F, 0, 0);
+	ret = sport_config_rx(sport_handle, 0, 0x1F, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
 		goto sport_config_err;
 	}
 
-	ret = sport_config_tx(sport_handle, ITFS, 0x1F, 0, 0);
+	ret = sport_config_tx(sport_handle, 0, 0x1F, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
-- 
1.7.4.rc1
