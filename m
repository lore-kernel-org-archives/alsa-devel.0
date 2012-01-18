From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/2] ASoC: tlv320aic32x4: always enable
	analouge block
Date: Wed, 18 Jan 2012 11:48:59 +0100
Message-ID: <1326883739-8148-2-git-send-email-w.sang@pengutronix.de>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B679D103AA5
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:49:11 +0100 (CET)
In-Reply-To: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Javier Martin <javier.martin@vista-silicon.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Register LDOCTLEN must always be initialized to clear the analog power
control bit, otherwise the analog block will stay deactivated.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 3806cb6..372b0b8 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -641,9 +641,11 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE) {
 		snd_soc_write(codec, AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE);
 	}
-	if (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) {
-		snd_soc_write(codec, AIC32X4_LDOCTL, AIC32X4_LDOCTLEN);
-	}
+
+	tmp_reg = (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) ?
+			AIC32X4_LDOCTLEN : 0;
+	snd_soc_write(codec, AIC32X4_LDOCTL, tmp_reg);
+
 	tmp_reg = snd_soc_read(codec, AIC32X4_CMMODE);
 	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36) {
 		tmp_reg |= AIC32X4_LDOIN_18_36;
-- 
1.7.8.3
