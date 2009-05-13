From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 2/4 v2] pxa2xx-i2s: Handle SACR1_DRPL and
	SACR1_DREC separately
Date: Wed, 13 May 2009 22:16:46 +0200
Message-ID: <4A0B2AAE.2000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id A9F272482F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 22:16:49 +0200 (CEST)
Received: by mail-ew0-f175.google.com with SMTP id 23so1093528ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 13:16:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

- hw_params enables both RPL and REC functions each time : Enable the
	appropriate function in pxa2xx_i2s_trigger.
- pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC function is
	off : Turn it off only when both functions are off.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 59cc4f5..a461c8d 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -176,9 +176,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream
*substream,

 	/* is port used by another stream */
 	if (!(SACR0 & SACR0_ENB)) {
-
 		SACR0 = 0;
-		SACR1 = 0;
 		if (pxa_i2s.master)
 			SACR0 |= SACR0_BCKD;

@@ -224,6 +222,10 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream
*substream, int cmd,

 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			SACR1 &= ~SACR1_DRPL;
+		else
+			SACR1 &= ~SACR1_DREC;
 		SACR0 |= SACR0_ENB;
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -250,7 +252,7 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream
*substream,
 		SAIMR &= ~SAIMR_RFS;
 	}

-	if (SACR1 & (SACR1_DREC | SACR1_DRPL)) {
+	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
 		SACR0 &= ~SACR0_ENB;
 		pxa_i2s_wait();
 		clk_disable(clk_i2s);
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
