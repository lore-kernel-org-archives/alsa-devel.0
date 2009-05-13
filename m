From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 4/4 v2] pxa2xx-i2s: Fix suspend/resume
Date: Wed, 13 May 2009 22:16:59 +0200
Message-ID: <4A0B2ABB.5040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 47498103947
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 22:17:03 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so224142eyw.56
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 13:17:02 -0700 (PDT)
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

pxa2xx_i2s_resume is :
 - unconditionnaly setting SACR0_ENB
 - unsetting SACR0_ENB in saved SACR0 pxa_i2s.sacr0
fix these.

In pxa2xx_i2s_{resume,suspend}, save/restore registers even
when !dai->active.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index a423637..efe499e 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -262,9 +262,6 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream
*substream,
 #ifdef CONFIG_PM
 static int pxa2xx_i2s_suspend(struct snd_soc_dai *dai)
 {
-	if (!dai->active)
-		return 0;
-
 	/* store registers */
 	pxa_i2s.sacr0 = SACR0;
 	pxa_i2s.sacr1 = SACR1;
@@ -279,16 +276,14 @@ static int pxa2xx_i2s_suspend(struct snd_soc_dai *dai)

 static int pxa2xx_i2s_resume(struct snd_soc_dai *dai)
 {
-	if (!dai->active)
-		return 0;
-
 	pxa_i2s_wait();

-	SACR0 = pxa_i2s.sacr0 &= ~SACR0_ENB;
+	SACR0 = pxa_i2s.sacr0 & ~SACR0_ENB;
 	SACR1 = pxa_i2s.sacr1;
 	SAIMR = pxa_i2s.saimr;
 	SADIV = pxa_i2s.sadiv;
-	SACR0 |= SACR0_ENB;
+
+	SACR0 = pxa_i2s.sacr0;

 	return 0;
 }
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
