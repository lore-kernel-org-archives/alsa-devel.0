From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 2/5] ASoC: S3C64XX: Add ADC source clock setting
Date: Fri,  6 Aug 2010 09:21:04 +0900
Message-ID: <1281054064-4730-1-git-send-email-sw.youn@samsung.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8793F243A7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:34:33 +0200 (CEST)
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

This patch adds ADC source clock setting to set wm8580 use ADC
source clock to ADC_MCLK.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 07e8e51..39bb701 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -113,6 +113,12 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/* Explicitly set WM8580-ADC to source from ADCMCLK */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_ADC_CLKSEL,
+					WM8580_CLKSRC_ADCMCLK);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
 					SMDK64XX_WM8580_FREQ, pll_out);
 	if (ret < 0)
-- 
1.6.2.5
