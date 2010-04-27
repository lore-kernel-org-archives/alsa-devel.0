From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 08/11] ASoC: S3C: I2Sv2: New field for
	controller feature
Date: Tue, 27 Apr 2010 15:56:56 +0900
Message-ID: <1272351416-3914-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 91F062482B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:00:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

In order to make s3c-i2s-v2.c manage controllers with minor
quirks and variation in features, we define a per-block flag
that indicates the availability/lack of a particular feature
to the s3c-i2s-v2.c

While adding support for new SoCs' I2S, check for the blocks
of older SoCs that have similar feature and set the flag for
that feature.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index 39a6db6..766f43a 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -29,10 +29,16 @@
 #define S3C_I2SV2_CLKSRC_AUDIOBUS	1
 #define S3C_I2SV2_CLKSRC_CDCLK		2
 
+/* Set this flag for I2S controllers that have the bit IISMOD[12]
+ * bridge/break RCLK signal and external Xi2sCDCLK pin.
+ */
+#define S3C_FEATURE_CDCLKCON	(1 << 0)
+
 /**
  * struct s3c_i2sv2_info - S3C I2S-V2 information
  * @dev: The parent device passed to use from the probe.
  * @regs: The pointer to the device registe block.
+ * @feature: Set of bit-flags indicating features of the controller.
  * @master: True if the I2S core is the I2S bit clock master.
  * @dma_playback: DMA information for playback channel.
  * @dma_capture: DMA information for capture channel.
@@ -47,6 +53,8 @@ struct s3c_i2sv2_info {
 	struct device	*dev;
 	void __iomem	*regs;
 
+	u32		feature;
+
 	struct clk	*iis_pclk;
 	struct clk	*iis_cclk;
 
-- 
1.6.2.5
