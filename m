From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC/pxa-ssp.c: fix build on pxa2xx
Date: Mon, 27 Oct 2008 15:43:17 -0200
Message-ID: <1225129397.6519.49.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pciZXai2KYCX4nfdgnR0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 12A8C24349
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 18:43:23 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 9so858470qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:43:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--=-pciZXai2KYCX4nfdgnR0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-pciZXai2KYCX4nfdgnR0
Content-Disposition: attachment; filename=asoc-pxa-ssp-fix-build-on-pxa2xx.patch
Content-Type: text/x-patch; name=asoc-pxa-ssp-fix-build-on-pxa2xx.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

ASoC/pxa-ssp.c: fix build on pxa2xx

SSACDD and SSACD_SCDX8 dont exist on pxa2xx.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 9ceddb0..a9fa75b 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -360,16 +360,25 @@ static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_AUDIO_DIV_SCDB:
 		val = ssp_read_reg(ssp, SSACD);
-		val &= ~(SSACD_SCDB | SSACD_SCDX8);
+		val &= ~SSACD_SCDB;
+#if defined(CONFIG_PXA3xx)
+		if (cpu_is_pxa3xx())
+			val &= ~SSACD_SCDX8;
+#endif
 		switch (div) {
 		case PXA_SSP_CLK_SCDB_1:
 			val |= SSACD_SCDB;
 			break;
 		case PXA_SSP_CLK_SCDB_4:
 			break;
+#if defined(CONFIG_PXA3xx)
 		case PXA_SSP_CLK_SCDB_8:
-			val |= SSACD_SCDX8;
+			if (cpu_is_pxa3xx())
+				val |= SSACD_SCDX8;
+			else
+				return -EINVAL;
 			break;
+#endif
 		default:
 			return -EINVAL;
 		}
@@ -395,7 +404,10 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->dev.ssp;
 	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
 
-	ssp_write_reg(ssp, SSACDD, 0);
+#if defined(CONFIG_PXA3xx)
+	if (cpu_is_pxa3xx())
+		ssp_write_reg(ssp, SSACDD, 0);
+#endif
 
 	switch (freq_out) {
 	case 5622000:

--=-pciZXai2KYCX4nfdgnR0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-pciZXai2KYCX4nfdgnR0--
