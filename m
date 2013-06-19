From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] ASoC: tlv320aix3x: Use SOC_SINGLE_EXT()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:33:53 +0200
Message-ID: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE172625FD
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:33:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Cc: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 1514bf8..e5b9268 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -128,10 +128,8 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 };
 
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw_aic3x, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
+	SOC_SINGLE_EXT(xname, reg, shift, mask, invert, \
+		snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw_aic3x)
 
 /*
  * All input lines are connected when !0xf and disconnected with 0xf bit field,
-- 
1.8.0
