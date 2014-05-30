From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aci3x: Fix custom
	snd_soc_dapm_put_volsw_aic3x() function
Date: Fri, 30 May 2014 16:47:41 +0300
Message-ID: <1401457661-2994-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1A0261AAB
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 15:47:50 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

For some unknown reason the parameters for snd_soc_test_bits() were in wrong
order:
It was:
snd_soc_test_bits(codec, val, mask, reg); /* WRONG!!! */
while it should be:
snd_soc_test_bits(codec, reg, mask, val);

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

so the failures I was seeing was indeed caused by something one never expects:
wrong parameter order for snd_soc_test_bits() in the tlv320aic3x driver, so
regmap failed time to time when we asked it to read a register out of the valid
range, since the value was sent as register number :o

Regards,
Peter

 sound/soc/codecs/tlv320aic3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d7349bc89ad3..e12fafbb1e09 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -169,7 +169,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	mask <<= shift;
 	val <<= shift;
 
-	change = snd_soc_test_bits(codec, val, mask, reg);
+	change = snd_soc_test_bits(codec, reg, mask, val);
 	if (change) {
 		update.kcontrol = kcontrol;
 		update.reg = reg;
-- 
1.9.3
