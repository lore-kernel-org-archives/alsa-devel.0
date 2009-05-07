From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 3/4] pxa2xx-i2s: Cleaner use of the FIFOs
Date: Fri, 08 May 2009 01:53:55 +0200
Message-ID: <4A037493.5080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id EFA931038E7
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 01:53:41 +0200 (CEST)
Received: by mail-ew0-f175.google.com with SMTP id 23so1677294ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 16:53:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.miao@marvell.com>, Russell King <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org


The FIFO logic and the registers are reset at stream startup with
SACR0_RST => the sibling function might suffer and the FIFOs might
unpleasantly fill up whence the calls to pxa_i2s_wait all over the place.
This gets rid of it.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 0e53d07..755e2d1 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -106,25 +106,12 @@ static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
 	if (IS_ERR(clk_i2s))
 		return PTR_ERR(clk_i2s);
 
-	if (!cpu_dai->active) {
-		SACR0 |= SACR0_RST;
+	if (!cpu_dai->active)
 		SACR0 = 0;
-	}
 
 	return 0;
 }
 
-/* wait for I2S controller to be ready */
-static int pxa_i2s_wait(void)
-{
-	int i;
-
-	/* flush the Rx FIFO */
-	for(i = 0; i < 16; i++)
-		SADR;
-	return 0;
-}
-
 static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -169,7 +156,6 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	BUG_ON(IS_ERR(clk_i2s));
 	clk_enable(clk_i2s);
-	pxa_i2s_wait();
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_out;
@@ -256,7 +242,6 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
 		SACR0 &= ~SACR0_ENB;
-		pxa_i2s_wait();
 		clk_disable(clk_i2s);
 	}
 }
@@ -275,7 +260,6 @@ static int pxa2xx_i2s_suspend(struct snd_soc_dai *dai)
 
 	/* deactivate link */
 	SACR0 &= ~SACR0_ENB;
-	pxa_i2s_wait();
 	return 0;
 }
 
@@ -284,8 +268,6 @@ static int pxa2xx_i2s_resume(struct snd_soc_dai *dai)
 	if (!dai->active)
 		return 0;
 
-	pxa_i2s_wait();
-
 	SACR0 = pxa_i2s.sacr0 &= ~SACR0_ENB;
 	SACR1 = pxa_i2s.sacr1;
 	SAIMR = pxa_i2s.saimr;
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
