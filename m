From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 1/4 v2] pxa2xx-i2s: Proper hw initialization
Date: Wed, 13 May 2009 22:16:37 +0200
Message-ID: <4A0B2AA5.9000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 755BB24341
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 22:16:41 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1093528ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 13:16:41 -0700 (PDT)
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

Make sure we are in a know good state at end of probe :
Reset FIFO logic and registers, and make sure REC and RPL functions
along with FIFO service are disabled (SACR0_RST enables REC and RPL).

Resetting loses current settings so remove reset from stream startup.
Now reset occurs only at probe.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 2f4b6e4..59cc4f5 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -106,10 +106,8 @@ static int pxa2xx_i2s_startup(struct snd_pcm_substream
*substream,
 	if (IS_ERR(clk_i2s))
 		return PTR_ERR(clk_i2s);

-	if (!cpu_dai->active) {
-		SACR0 |= SACR0_RST;
+	if (!cpu_dai->active)
 		SACR0 = 0;
-	}

 	return 0;
 }
@@ -346,6 +344,19 @@ static int pxa2xx_i2s_probe(struct platform_device *dev)
 	if (ret != 0)
 		clk_put(clk_i2s);

+	/*
+	 * PXA Developer's Manual:
+	 * If SACR0[ENB] is toggled in the middle of a normal operation,
+	 * the SACR0[RST] bit must also be set and cleared to reset all
+	 * I2S controller registers.
+	 */
+	SACR0 = SACR0_RST;
+	SACR0 = 0;
+	/* Make sure RPL and REC are disabled */
+	SACR1 = SACR1_DRPL | SACR1_DREC;
+	/* Along with FIFO servicing */
+	SAIMR &= ~(SAIMR_RFS | SAIMR_TFS);
+
 	return ret;
 }

-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
