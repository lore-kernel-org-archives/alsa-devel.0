From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: pcm186x: Fix energysense SLEEP
	bit" to the asoc tree
Date: Tue, 19 Feb 2019 17:17:46 +0000 (GMT)
Message-ID: <20190219171746.97E5B11284DE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA6AF80792
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: pcm186x: Fix energysense SLEEP bit

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

>From 05bd7fcdd06b19a10f069af1bea3ad9abac038d7 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 19 Feb 2019 16:29:28 +0000
Subject: [PATCH] ASoC: codecs: pcm186x: Fix energysense SLEEP bit

The ADCs are sleeping when the SLEEP bit is set and running when it's
cleared, so the bit should be inverted.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/pcm186x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index c36a391fec8a..c5fcc632f670 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
 };
 
 static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
@@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
-	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
+	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
 };
 
 static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
-- 
2.20.1
