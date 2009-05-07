From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
	SACR1_DREC separately
Date: Fri, 08 May 2009 01:53:47 +0200
Message-ID: <4A03748B.1010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D3A21038C4
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 01:53:35 +0200 (CEST)
Received: by mail-ew0-f175.google.com with SMTP id 23so1677294ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 16:53:35 -0700 (PDT)
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


- hw_params enables both RPL and REC functions each time,
enable the appropriate function in pxa2xx_i2s_trigger.
- pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC
function is off, turn it off only when both functions are off.
- do not put the clk_i2s for no reason in pxa2xx_i2s_shutdown.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 52862dc..0e53d07 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -178,9 +178,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	/* is port used by another stream */
 	if (!(SACR0 & SACR0_ENB)) {
-
 		SACR0 = 0;
-		SACR1 = 0;
 		if (pxa_i2s.master)
 			SACR0 |= SACR0_BCKD;
 
@@ -226,6 +224,10 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			SACR1 &= ~SACR1_DRPL;
+		else
+			SACR1 &= ~SACR1_DREC;
 		SACR0 |= SACR0_ENB;
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -252,13 +254,11 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
 		SAIMR &= ~SAIMR_RFS;
 	}
 
-	if (SACR1 & (SACR1_DREC | SACR1_DRPL)) {
+	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
 		SACR0 &= ~SACR0_ENB;
 		pxa_i2s_wait();
 		clk_disable(clk_i2s);
 	}
-
-	clk_put(clk_i2s);
 }
 
 #ifdef CONFIG_PM
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
