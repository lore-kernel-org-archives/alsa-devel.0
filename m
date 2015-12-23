From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Add support for 1.6V micbias
	level" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:16 +0000
Message-ID: <E1aBX2O-0008M0-FG@debutante>
References: <7413a3e6c9996d2ae4c17ea60b220ad1d4012a9f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD33E266576
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:22 +0100 (CET)
In-Reply-To: <7413a3e6c9996d2ae4c17ea60b220ad1d4012a9f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Add support for 1.6V micbias level

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0aed64c1766d354c819a13a57d8673adaf2266eb Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:55 +0000
Subject: [PATCH] ASoC: da7219: Add support for 1.6V micbias level

HW can provide 1.6V micbias level as well the existing levels
already provided in the driver. This patch adds support for 1.6V
to the DT binding.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 2 +-
 include/sound/da7219.h                             | 3 ++-
 sound/soc/codecs/da7219.c                          | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index 062a2a08250e..cf61681826b6 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -29,7 +29,7 @@ Optional properties:
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
 
 - dlg,micbias-lvl : Voltage (mV) for Mic Bias
-	[<1800>, <2000>, <2200>, <2400>, <2600>]
+	[<1600>, <1800>, <2000>, <2200>, <2400>, <2600>]
 - dlg,mic-amp-in-sel : Mic input source type
 	["diff", "se_p", "se_n"]
 
diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 307198b469bc..02876acdc840 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -16,7 +16,8 @@
 
 /* Mic Bias */
 enum da7219_micbias_voltage {
-	DA7219_MICBIAS_1_8V = 1,
+	DA7219_MICBIAS_1_6V = 0,
+	DA7219_MICBIAS_1_8V,
 	DA7219_MICBIAS_2_0V,
 	DA7219_MICBIAS_2_2V,
 	DA7219_MICBIAS_2_4V,
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 2630c503e3df..371768092e17 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1410,6 +1410,8 @@ static enum da7219_micbias_voltage
 	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
+	case 1600:
+		return DA7219_MICBIAS_1_6V;
 	case 1800:
 		return DA7219_MICBIAS_1_8V;
 	case 2000:
@@ -1571,6 +1573,7 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
+		case DA7219_MICBIAS_1_6V:
 		case DA7219_MICBIAS_1_8V:
 		case DA7219_MICBIAS_2_0V:
 		case DA7219_MICBIAS_2_2V:
-- 
2.6.2
