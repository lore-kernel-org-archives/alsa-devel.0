From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK,
	LRCLK rates setting
Date: Fri,  6 Aug 2010 09:36:39 +0900
Message-ID: <1281054999-18243-1-git-send-email-sw.youn@samsung.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F15D243F7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:49:33 +0200 (CEST)
In-Reply-To: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch fix to support BCLK and LRCLK rates setting as
wm8580 Master mode. After apply this patch, LRCLK and BCLK
signal appears correctly from wm8580 in some freq., 8kHz
and 11.025kHz, on SMDK board.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 39bb701..f3dbdfb 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -124,11 +124,11 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_BCLK, bfs);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_BCLK_RATE, bfs);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, rfs);
+	ret = snd_soc_dai_set_clkdiv(codec_dai,	WM8580_LRCLK_RATE, rfs);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.2.5
