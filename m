From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 04/11] ASoC: S3C2412: I2S: Return correct
	source clock
Date: Tue, 27 Apr 2010 15:56:34 +0900
Message-ID: <1272351394-3789-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A1ED624833
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

Until now, s3c2412_get_iisclk would return NULL since iis_clk was never
initialized.
Return appropriate pointer as per the selection made for source clock.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c2412-i2s.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index cf0c154..ce2daac 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -94,7 +94,13 @@ static int s3c2412_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 
 struct clk *s3c2412_get_iisclk(void)
 {
-	return s3c2412_i2s.iis_clk;
+	struct s3c_i2sv2_info *i2s = &s3c2412_i2s;
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
 }
 EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
 
-- 
1.6.2.5
