From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 5/5] ASoC: Blackfin I2S: fix resuming when
	device hasn't been used
Date: Wed, 16 Sep 2009 20:25:12 -0400
Message-ID: <1253147112-5801-5-git-send-email-vapier@gentoo.org>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BA0141038F0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 02:25:17 +0200 (CEST)
In-Reply-To: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

If the sound system hasn't been utilized yet and we suspend, then we
attempt to save/restore using state that doesn't exist.  So use a global
handle instead to reconfigure properly.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 19539c6..1e9d161 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -237,36 +237,31 @@ static void bf5xx_i2s_remove(struct platform_device *pdev,
 #ifdef CONFIG_PM
 static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 {
-	struct sport_device *sport =
-		(struct sport_device *)dai->private_data;
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
-	if (!dai->active)
-		return 0;
+
 	if (dai->capture.active)
-		sport_rx_stop(sport);
+		sport_rx_stop(sport_handle);
 	if (dai->playback.active)
-		sport_tx_stop(sport);
+		sport_tx_stop(sport_handle);
 	return 0;
 }
 
 static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 {
 	int ret;
-	struct sport_device *sport =
-		(struct sport_device *)dai->private_data;
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
-	if (!dai->active)
-		return 0;
 
-	ret = sport_config_rx(sport, RFSR | RCKFE, RSFSE|0x1f, 0, 0);
+	ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
+				      bf5xx_i2s.rcr2, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	ret = sport_config_tx(sport, TFSR | TCKFE, TSFSE|0x1f, 0, 0);
+	ret = sport_config_tx(sport_handle, bf5xx_i2s.tcr1,
+				      bf5xx_i2s.tcr2, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
-- 
1.6.5.rc1
