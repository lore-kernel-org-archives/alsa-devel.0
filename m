From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: align pin names between
	byt-rt5640 drivers" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:34 +0000
Message-ID: <E1aAG2w-0004gd-Lz@debutante>
References: <1450406156-22246-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1DB92605FF
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:45 +0100 (CET)
In-Reply-To: <1450406156-22246-4-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: align pin names between byt-rt5640 drivers

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

>From e2be1da0164c0fbc345874581738d2d72f5f1e24 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:40 -0600
Subject: [PATCH] ASoC: Intel: boards: align pin names between byt-rt5640
 drivers

initial cleanup to use same pins

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 66d37b0e64d1..694061c4c649 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -32,22 +32,21 @@
 static const struct snd_soc_dapm_widget byt_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Int Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
 static const struct snd_soc_dapm_route byt_audio_map[] = {
-	{"IN2P", NULL, "Headset Mic"},
-	{"IN2N", NULL, "Headset Mic"},
 	{"Headset Mic", NULL, "MICBIAS1"},
-	{"IN1P", NULL, "MICBIAS1"},
-	{"LDO2", NULL, "Int Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Ext Spk", NULL, "SPOLP"},
-	{"Ext Spk", NULL, "SPOLN"},
-	{"Ext Spk", NULL, "SPORP"},
-	{"Ext Spk", NULL, "SPORN"},
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "Internal Mic"},
 
 	{"AIF1 Playback", NULL, "ssp2 Tx"},
 	{"ssp2 Tx", NULL, "codec_out0"},
@@ -60,8 +59,8 @@ static const struct snd_soc_dapm_route byt_audio_map[] = {
 static const struct snd_kcontrol_new byt_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Int Mic"),
-	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
 static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
-- 
2.6.2
