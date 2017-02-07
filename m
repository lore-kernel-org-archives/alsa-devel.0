From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: sun4i-i2s: remove some dead code
Date: Tue, 7 Feb 2017 16:19:34 +0300
Message-ID: <20170207131934.GD28207@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 0776F266FD0
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:20:09 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

"i2s->rst" is either NULL or a valid pointer.  We won't probe
successfully if it's an error pointer.  That means these checks can be
removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3635bbc72cbc..d79be3e4361b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -723,13 +723,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!IS_ERR(i2s->rst)) {
-		ret = reset_control_deassert(i2s->rst);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to deassert the reset control\n");
-			return -EINVAL;
-		}
+	ret = reset_control_deassert(i2s->rst);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to deassert the reset control\n");
+		return -EINVAL;
 	}
 
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
@@ -766,8 +764,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR(i2s->rst))
-		reset_control_assert(i2s->rst);
+	reset_control_assert(i2s->rst);
 
 	return ret;
 }
@@ -782,8 +779,7 @@ static int sun4i_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 
-	if (!IS_ERR(i2s->rst))
-		reset_control_assert(i2s->rst);
+	reset_control_assert(i2s->rst);
 
 	return 0;
 }
