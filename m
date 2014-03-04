From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: da732x: Replace hw_read usage with
	snd_soc_read()
Date: Tue,  4 Mar 2014 15:59:53 +0800
Message-ID: <1393919993-7326-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B0EFA265723
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:07:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Pre-merge code was using direct hw_read() calls as an out of framework
way of doing volatile register I/O when not using regmap. This has never
functioned correctly in mainline due to the regmap conversion, the
hw_read() implementation still does caching. In order to facilitate
removal of the subsystem level I/O code convert to use snd_soc_read(),
there should be no functional impact.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/da732x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 4d1c302..14acb3a 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1297,9 +1297,9 @@ static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
 	msleep(DA732X_WAIT_FOR_STABILIZATION);
 
 	/* Check DAC offset sign */
-	sign[DA732X_HPL_DAC] = (codec->hw_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
+	sign[DA732X_HPL_DAC] = snd_soc_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
 				DA732X_HP_DAC_OFF_CNTL_COMPO);
-	sign[DA732X_HPR_DAC] = (codec->hw_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
+	sign[DA732X_HPR_DAC] = snd_soc_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
 				DA732X_HP_DAC_OFF_CNTL_COMPO);
 
 	/* Binary search DAC offset values (both channels at once) */
@@ -1316,10 +1316,10 @@ static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
 
 		msleep(DA732X_WAIT_FOR_STABILIZATION);
 
-		if ((codec->hw_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
+		if ((snd_soc_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
 		     DA732X_HP_DAC_OFF_CNTL_COMPO) ^ sign[DA732X_HPL_DAC])
 			offset[DA732X_HPL_DAC] &= ~step;
-		if ((codec->hw_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
+		if ((snd_soc_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
 		     DA732X_HP_DAC_OFF_CNTL_COMPO) ^ sign[DA732X_HPR_DAC])
 			offset[DA732X_HPR_DAC] &= ~step;
 
@@ -1360,9 +1360,9 @@ static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
 	msleep(DA732X_WAIT_FOR_STABILIZATION);
 
 	/* Check output offset sign */
-	sign[DA732X_HPL_AMP] = codec->hw_read(codec, DA732X_REG_HPL) &
+	sign[DA732X_HPL_AMP] = snd_soc_read(codec, DA732X_REG_HPL) &
 			       DA732X_HP_OUT_COMPO;
-	sign[DA732X_HPR_AMP] = codec->hw_read(codec, DA732X_REG_HPR) &
+	sign[DA732X_HPR_AMP] = snd_soc_read(codec, DA732X_REG_HPR) &
 			       DA732X_HP_OUT_COMPO;
 
 	snd_soc_write(codec, DA732X_REG_HPL, DA732X_HP_OUT_COMP |
@@ -1383,10 +1383,10 @@ static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
 
 		msleep(DA732X_WAIT_FOR_STABILIZATION);
 
-		if ((codec->hw_read(codec, DA732X_REG_HPL) &
+		if ((snd_soc_read(codec, DA732X_REG_HPL) &
 		     DA732X_HP_OUT_COMPO) ^ sign[DA732X_HPL_AMP])
 			offset[DA732X_HPL_AMP] &= ~step;
-		if ((codec->hw_read(codec, DA732X_REG_HPR) &
+		if ((snd_soc_read(codec, DA732X_REG_HPR) &
 		     DA732X_HP_OUT_COMPO) ^ sign[DA732X_HPR_AMP])
 			offset[DA732X_HPR_AMP] &= ~step;
 
-- 
1.9.0
