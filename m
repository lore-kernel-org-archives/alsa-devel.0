From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 1/2] ASoC: S3C: Fix PCM RX FIFO settings
Date: Fri, 10 Sep 2010 17:20:00 +0900
Message-ID: <1284106800-13520-1-git-send-email-sw.youn@samsung.com>
References: <AANLkTimWZ-eSr4boXbyxbunDcm3Da1vEAZvP65Up63uE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 6230410390E
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 10:37:23 +0200 (CEST)
In-Reply-To: <AANLkTimWZ-eSr4boXbyxbunDcm3Da1vEAZvP65Up63uE@mail.gmail.com>
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

When PCM capture, sound recorded abnormally because of RX FIFO
threshold settings are missing. So, This patch modify PCM RX FIFO
setting codes same as TX.
And for DMA, if PCM RXFIFO_DIPSTICK is not '0', it doesn't effect
to DMA request, because DMA refer RX_FIFO_EMPTY flag as the DMA
request.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/s3c-pcm.c |    3 +++
 sound/soc/s3c24xx/s3c-pcm.h |    3 ++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 43dcc6b..deaa3f2 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -107,11 +107,14 @@ static void s3c_pcm_snd_rxctrl(struct s3c_pcm_info *pcm, int on)
 
 	ctl = readl(regs + S3C_PCM_CTL);
 	clkctl = readl(regs + S3C_PCM_CLKCTL);
+	ctl &= ~(S3C_PCM_CTL_RXDIPSTICK_MASK
+			 << S3C_PCM_CTL_RXDIPSTICK_SHIFT);
 
 	if (on) {
 		ctl |= S3C_PCM_CTL_RXDMA_EN;
 		ctl |= S3C_PCM_CTL_RXFIFO_EN;
 		ctl |= S3C_PCM_CTL_ENABLE;
+		ctl |= (0x20<<S3C_PCM_CTL_RXDIPSTICK_SHIFT);
 		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
 	} else {
 		ctl &= ~S3C_PCM_CTL_RXDMA_EN;
diff --git a/sound/soc/s3c24xx/s3c-pcm.h b/sound/soc/s3c24xx/s3c-pcm.h
index 3e9bfc9..b85eaf2 100644
--- a/sound/soc/s3c24xx/s3c-pcm.h
+++ b/sound/soc/s3c24xx/s3c-pcm.h
@@ -22,7 +22,8 @@
 /* PCM_CTL Bit-Fields */
 #define S3C_PCM_CTL_TXDIPSTICK_MASK		(0x3f)
 #define S3C_PCM_CTL_TXDIPSTICK_SHIFT	(13)
-#define S3C_PCM_CTL_RXDIPSTICK_MSK		(0x3f<<7)
+#define S3C_PCM_CTL_RXDIPSTICK_MASK		(0x3f)
+#define S3C_PCM_CTL_RXDIPSTICK_SHIFT	(7)
 #define S3C_PCM_CTL_TXDMA_EN		(0x1<<6)
 #define S3C_PCM_CTL_RXDMA_EN		(0x1<<5)
 #define S3C_PCM_CTL_TXMSB_AFTER_FSYNC	(0x1<<4)
-- 
1.6.2.5
