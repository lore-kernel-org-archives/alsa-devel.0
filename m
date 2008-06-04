From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revised AT32 ASoC Patch
Date: Wed, 4 Jun 2008 12:32:34 +0100
Message-ID: <20080604113234.GA2166@sirena.org.uk>
References: <200806031103.10785.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 84189243BD
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 13:32:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806031103.10785.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 03, 2008 at 11:03:10AM -0500, Geoffrey Wossum wrote:
> Attached is a revised version of my patch to add AT32 to ASoC.  This cleans up 
This looks good, thanks - I will push it out along with the WM8510
driver.  There were a few checkpatch warnings remaining but I have fixed
these up myself (patch below).  I'll also remove the sound/driver.h
includes before pushing out.

One nit with the formatting of your e-mail:

> ---
> Geoffrey
> 
> Signed-off-by: Geoffrey Wossum <gwossum@acm.org>

You should place the Signed-off-by line in the body of the patch
description rather than after the ---.  Tools like git am will drop
any text after there from the commit message, loosing your signoff.

diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/at32/at32-pcm.c
index a05cb8f..ad84c89 100644
--- a/sound/soc/at32/at32-pcm.c
+++ b/sound/soc/at32/at32-pcm.c
@@ -108,7 +108,7 @@ static void at32_pcm_dma_irq(u32 ssc_sr, struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *rtd = substream->runtime;
 	struct at32_runtime_data *prtd = rtd->private_data;
 	struct at32_pcm_dma_params *params = prtd->params;
-	static int count = 0;
+	static int count;
 
 	count++;
 	if (ssc_sr & params->mask->ssc_endbuf) {
diff --git a/sound/soc/at32/at32-ssc.c b/sound/soc/at32/at32-ssc.c
index 61320c9..f984e76 100644
--- a/sound/soc/at32/at32-ssc.c
+++ b/sound/soc/at32/at32-ssc.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel-ssc.h>
 
@@ -30,8 +31,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <asm/io.h>
-
 #include "at32-pcm.h"
 #include "at32-ssc.h"
 
@@ -376,11 +375,10 @@ static int at32_ssc_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
 		 * transmit and receive, so if a value has already
 		 * been set, it must match this value
 		 */
-		if (ssc_p->cmr_div == 0) {
+		if (ssc_p->cmr_div == 0)
 			ssc_p->cmr_div = div;
-		} else if (div != ssc_p->cmr_div) {
+		else if (div != ssc_p->cmr_div)
 			return -EBUSY;
-		}
 		break;
 
 	case AT32_SSC_TCMR_PERIOD:
