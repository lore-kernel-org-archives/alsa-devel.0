From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC/pxa-ssp.c: keep up with pxa api changes
Date: Mon, 27 Oct 2008 15:43:11 -0200
Message-ID: <1225129391.6519.48.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KfU2CrX0qRe8biCSzMyQ"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 37F1D24349
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 18:43:19 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 9so858470qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:43:18 -0700 (PDT)
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


--=-KfU2CrX0qRe8biCSzMyQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-KfU2CrX0qRe8biCSzMyQ
Content-Disposition: attachment; filename=asoc-pxa-ssp-keep-up-with-pxa-api-changes.patch
Content-Type: text/x-patch; name=asoc-pxa-ssp-keep-up-with-pxa-api-changes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

ASoC/pxa-ssp.c: keep up with pxa api changes

Update the code to the pxa api changes on linus tree.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6232be7..9ceddb0 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -25,12 +25,13 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
 
-#include <asm/hardware.h>
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/regs-ssp.h>
-#include <asm/arch/audio.h>
-#include <asm/arch/ssp.h>
+#include <mach/hardware.h>
+#include <mach/pxa-regs.h>
+#include <mach/regs-ssp.h>
+#include <mach/audio.h>
+#include <mach/ssp.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa-ssp.h"
@@ -55,7 +56,7 @@ struct ssp_priv {
 static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_out = {
 	.name			= "SSP1 PCM Mono out",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRTXSSDR,
+	.drcmr			= &DRCMR(14),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -63,7 +64,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_in = {
 	.name			= "SSP1 PCM Mono in",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRRXSSDR,
+	.drcmr			= &DRCMR(13),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -71,7 +72,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_out = {
 	.name			= "SSP1 PCM Stereo out",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRTXSSDR,
+	.drcmr			= &DRCMR(14),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -79,7 +80,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_in = {
 	.name			= "SSP1 PCM Stereo in",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRRXSSDR,
+	.drcmr			= &DRCMR(13),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -87,7 +88,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_out = {
 	.name			= "SSP2 PCM Mono out",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS2DR,
+	.drcmr			= &DRCMR(16),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -95,7 +96,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_in = {
 	.name			= "SSP2 PCM Mono in",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS2DR,
+	.drcmr			= &DRCMR(15),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -103,7 +104,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_out = {
 	.name			= "SSP2 PCM Stereo out",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS2DR,
+	.drcmr			= &DRCMR(16),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -111,7 +112,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_in = {
 	.name			= "SSP2 PCM Stereo in",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS2DR,
+	.drcmr			= &DRCMR(15),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -119,7 +120,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_out = {
 	.name			= "SSP3 PCM Mono out",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -127,7 +128,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_in = {
 	.name			= "SSP3 PCM Mono in",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -135,7 +136,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_out = {
 	.name			= "SSP3 PCM Stereo out",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -143,7 +144,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_in = {
 	.name			= "SSP3 PCM Stereo in",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -151,7 +152,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_out = {
 	.name			= "SSP4 PCM Mono out",
 	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -159,7 +160,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_in = {
 	.name			= "SSP4 PCM Mono in",
 	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -167,7 +168,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_in = {
 static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_out = {
 	.name			= "SSP4 PCM Stereo out",
 	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -175,7 +176,7 @@ static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_out = {
 static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_in = {
 	.name			= "SSP4 PCM Stereo in",
 	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };

--=-KfU2CrX0qRe8biCSzMyQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-KfU2CrX0qRe8biCSzMyQ--
