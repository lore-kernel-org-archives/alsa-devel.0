From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/11] soc - pxa2xx-ac97 - Use __func__ not
	__FUNCTION__
Date: Wed, 23 Apr 2008 13:07:58 +0100
Message-ID: <1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6452244CD
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:07 +0200 (CEST)
In-Reply-To: <1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 95ae509..3f56fb1 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -81,7 +81,7 @@ static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97,
 	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_SDONE, 1);
 	if (!((GSR | gsr_bits) & GSR_SDONE)) {
 		printk(KERN_ERR "%s: read error (ac97_reg=%x GSR=%#lx)\n",
-				__FUNCTION__, reg, GSR | gsr_bits);
+				__func__, reg, GSR | gsr_bits);
 		val = -1;
 		goto out;
 	}
@@ -121,7 +121,7 @@ static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	wait_event_timeout(gsr_wq, (GSR | gsr_bits) & GSR_CDONE, 1);
 	if (!((GSR | gsr_bits) & GSR_CDONE))
 		printk(KERN_ERR "%s: write error (ac97_reg=%x GSR=%#lx)\n",
-				__FUNCTION__, reg, GSR | gsr_bits);
+				__func__, reg, GSR | gsr_bits);
 
 	mutex_unlock(&car_mutex);
 }
@@ -153,7 +153,7 @@ static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
 		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-				 __FUNCTION__, gsr_bits);
+				 __func__, gsr_bits);
 
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
@@ -197,7 +197,7 @@ static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 
 	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)))
 		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __FUNCTION__, gsr_bits);
+				 __func__, gsr_bits);
 
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 	GCR |= GCR_SDONE_IE|GCR_CDONE_IE;
-- 
1.5.5.1
