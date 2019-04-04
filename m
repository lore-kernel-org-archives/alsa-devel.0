From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Add Playback PowerTune
	Controls" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:40 +0700 (+07)
Message-ID: <20190404135840.55E2A441D3B@finisterre.ee.mobilebroadband>
References: <20190404040155.29246-2-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3028CF89732
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 15:58:45 +0200 (CEST)
In-Reply-To: <20190404040155.29246-2-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: team@nwdigitalradio.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Add Playback PowerTune Controls

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d3e6e374566e1154820a9a3dc82f7eef646fcf95 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Wed, 3 Apr 2019 21:01:55 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Add Playback PowerTune Controls

PowerTune controls the power level of the chip.  On playback this
indirectly controls things like the gain of the various output
amplifiers.  This can allow for the decrease of output levels
from the codec.  This adds controls for those power levels to
the driver.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 9 +++++++++
 sound/soc/codecs/tlv320aic32x4.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 77df2cbdf5f4..6edee05ff9f0 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -248,9 +248,18 @@ static const char * const lo_cm_text[] = {
 
 static SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
 
+static const char * const ptm_text[] = {
+	"P3", "P2", "P1",
+};
+
+static SOC_ENUM_SINGLE_DECL(l_ptm_enum, AIC32X4_LPLAYBACK, 2, ptm_text);
+static SOC_ENUM_SINGLE_DECL(r_ptm_enum, AIC32X4_RPLAYBACK, 2, ptm_text);
+
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
 			AIC32X4_RDACVOL, 0, -0x7f, 0x30, 7, 0, tlv_pcm),
+	SOC_ENUM("DAC Left Playback PowerTune Switch", l_ptm_enum),
+	SOC_ENUM("DAC Right Playback PowerTune Switch", r_ptm_enum),
 	SOC_DOUBLE_R_S_TLV("HP Driver Gain Volume", AIC32X4_HPLGAIN,
 			AIC32X4_HPRGAIN, 0, -0x6, 0x1d, 5, 0,
 			tlv_driver_gain),
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 88205bc97198..40734211bc0e 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -78,6 +78,8 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 
 #define AIC32X4_PWRCFG		AIC32X4_REG(1, 1)
 #define AIC32X4_LDOCTL		AIC32X4_REG(1, 2)
+#define AIC32X4_LPLAYBACK	AIC32X4_REG(1, 3)
+#define AIC32X4_RPLAYBACK	AIC32X4_REG(1, 4)
 #define AIC32X4_OUTPWRCTL	AIC32X4_REG(1, 9)
 #define AIC32X4_CMMODE		AIC32X4_REG(1, 10)
 #define AIC32X4_HPLROUTE	AIC32X4_REG(1, 12)
-- 
2.20.1
