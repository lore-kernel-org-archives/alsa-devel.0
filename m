From: jassi brar <jassisinghbrar@gmail.com>
Subject: [PATCH] S3C64XX I2S: Return correct codec clock
Date: Fri, 18 Sep 2009 15:22:27 +0900
Message-ID: <1253254947-21639-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 026BD243A0
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 08:26:15 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi <jassi.brar@samsung.com>, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

From: Jassi <jassi.brar@samsung.com>

Instead of always returnig pointer to the 'audio-bus' clock,
check which clock is used to generate internal clocks and
then return it's pointer.

Signed-off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 62a7fce..66f4ded 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -133,8 +133,12 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 {
 	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
 
-	return i2s->iis_cclk;
+	if (iismod & S3C64XX_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
 }
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
 
-- 
1.6.2.5
