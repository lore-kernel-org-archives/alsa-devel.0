From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: rename controls to match DAPM
	controls" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:07 +0900
Message-ID: <E1d4oQR-00040x-M3@finisterre>
References: <1493262937-22813-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E72102664EB
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 14:58:13 +0200 (CEST)
In-Reply-To: <1493262937-22813-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: rename controls to match DAPM controls

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

>From 25535f7e0b418fe8b2251008cfcb05d272c2e8e0 Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 27 Apr 2017 11:15:37 +0800
Subject: [PATCH] ASoC: nau8824: rename controls to match DAPM controls

Rename the name of kcontrols to match up the DAPM
widget controls.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 18552ed43924..cd358be027dd 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -362,27 +362,27 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 	SOC_ENUM("ADC Decimation Rate", nau8824_adc_decimation_enum),
 	SOC_ENUM("DAC Oversampling Rate", nau8824_dac_oversampl_enum),
 
-	SOC_SINGLE_TLV("Speaker Right from DACR Volume",
+	SOC_SINGLE_TLV("Speaker Right DACR Volume",
 		NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Left from DACL Volume",
+	SOC_SINGLE_TLV("Speaker Left DACL Volume",
 		NAU8824_REG_CLASSD_GAIN_2, 0, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Left from DACR Volume",
+	SOC_SINGLE_TLV("Speaker Left DACR Volume",
 		NAU8824_REG_CLASSD_GAIN_1, 0, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Right from DACL Volume",
+	SOC_SINGLE_TLV("Speaker Right DACL Volume",
 		NAU8824_REG_CLASSD_GAIN_2, 8, 0x1f, 0, spk_vol_tlv),
 
-	SOC_SINGLE_TLV("Headphone Right from DACR Volume",
+	SOC_SINGLE_TLV("Headphone Right DACR Volume",
 		NAU8824_REG_ATT_PORT0, 8, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Left from DACL Volume",
+	SOC_SINGLE_TLV("Headphone Left DACL Volume",
 		NAU8824_REG_ATT_PORT0, 0, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Right from DACL Volume",
+	SOC_SINGLE_TLV("Headphone Right DACL Volume",
 		NAU8824_REG_ATT_PORT1, 8, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Left from DACR Volume",
+	SOC_SINGLE_TLV("Headphone Left DACR Volume",
 		NAU8824_REG_ATT_PORT1, 0, 0x1f, 0, hp_vol_tlv),
 
-	SOC_SINGLE_TLV("Mic1 Volume", NAU8824_REG_FEPGA_II,
+	SOC_SINGLE_TLV("MIC1 Volume", NAU8824_REG_FEPGA_II,
 		NAU8824_FEPGA_GAINL_SFT, 0x12, 0, mic_vol_tlv),
-	SOC_SINGLE_TLV("Mic2 Volume", NAU8824_REG_FEPGA_II,
+	SOC_SINGLE_TLV("MIC2 Volume", NAU8824_REG_FEPGA_II,
 		NAU8824_FEPGA_GAINR_SFT, 0x12, 0, mic_vol_tlv),
 
 	SOC_SINGLE_TLV("DMIC1 Volume", NAU8824_REG_ADC_CH0_DGAIN_CTRL,
-- 
2.11.0
