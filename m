From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 2/2] ASoC: S3C: Fix PCM TXFIFO_DIPSTICK value
Date: Fri, 10 Sep 2010 17:20:45 +0900
Message-ID: <1284106845-13552-1-git-send-email-sw.youn@samsung.com>
References: <AANLkTimWZ-eSr4boXbyxbunDcm3Da1vEAZvP65Up63uE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 63F1B103937
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 10:37:24 +0200 (CEST)
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

This patch modify FIFO_DIPSTICK value of PCM TX FIFO to be a optimal one.
Privious value (0x20) did not support 'Almost_full' of PCM FIFO for the DMA
request.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/s3c-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index c5ca902..df6948f 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -78,7 +78,7 @@ static void s3c_pcm_snd_txctrl(struct s3c_pcm_info *pcm, int on)
 		ctl |= S3C_PCM_CTL_TXDMA_EN;
 		ctl |= S3C_PCM_CTL_TXFIFO_EN;
 		ctl |= S3C_PCM_CTL_ENABLE;
-		ctl |= (0x20<<S3C_PCM_CTL_TXDIPSTICK_SHIFT);
+		ctl |= (0x4<<S3C_PCM_CTL_TXDIPSTICK_SHIFT);
 		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
 	} else {
 		ctl &= ~S3C_PCM_CTL_TXDMA_EN;
-- 
1.6.2.5
