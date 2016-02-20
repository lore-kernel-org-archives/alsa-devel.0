From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cht_bsw_rt5645: Enable jack detection"
	to the asoc tree
Date: Sun, 21 Feb 2016 02:13:55 +0900
Message-ID: <E1aXB6R-0008D0-E4@finisterre>
References: <1455658039-4783-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F85A2606D3
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:14:05 +0100 (CET)
In-Reply-To: <1455658039-4783-1-git-send-email-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cht_bsw_rt5645: Enable jack detection

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

>From 2303b32f54289267adb75437cdeba50be92221f5 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Tue, 16 Feb 2016 22:27:19 +0100
Subject: [PATCH] ASoC: cht_bsw_rt5645: Enable jack detection

Add missing DAPM pins and enable jack detection on those pins for
Cherrytrail and Braswell.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index e6cf800..c7af271 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -147,6 +147,17 @@ static const struct snd_kcontrol_new cht_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
+static struct snd_soc_jack_pin cht_bsw_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -202,9 +213,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	else
 		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
+	ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    jack_type, &ctx->jack,
-				    NULL, 0);
+				    cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
 		return ret;
-- 
2.7.0
