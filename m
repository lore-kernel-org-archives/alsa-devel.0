From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] ASoC: s3c-i2s-v2.c fix for
	s3c_i2sv2_iis_calc_rate
Date: Thu, 16 Apr 2009 10:32:23 +0100
Message-ID: <1239874343-7280-5-git-send-email-ben-linux@fluff.org>
References: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-2-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-3-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-4-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 9548610394A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:36:10 +0200 (CEST)
In-Reply-To: <1239874343-7280-4-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

The definition of s3c_i2sv2_iis_calc_rate was never
renamed from s3c2412_iis_calc_rate, so rename this
to allow the build to work.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b983ad7..689ffcd 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -473,9 +473,9 @@ static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 /* default table of all avaialable root fs divisors */
 static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
 
-int s3c2412_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
-			  unsigned int *fstab,
-			  unsigned int rate, struct clk *clk)
+int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
+			    unsigned int *fstab,
+			    unsigned int rate, struct clk *clk)
 {
 	unsigned long clkrate = clk_get_rate(clk);
 	unsigned int div;
@@ -531,7 +531,7 @@ int s3c2412_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(s3c2412_iis_calc_rate);
+EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
 
 int s3c_i2sv2_probe(struct platform_device *pdev,
 		    struct snd_soc_dai *dai,
-- 
1.5.6.5
