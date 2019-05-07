From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: kbl_da7219_max98927: add
	dai_trigger function" to the asoc tree
Date: Tue,  7 May 2019 03:32:47 +0100 (BST)
Message-ID: <20190507023247.D3690440034@finisterre.sirena.org.uk>
References: <1556851697-301-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0217BF8972A
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 04:33:00 +0200 (CEST)
In-Reply-To: <1556851697-301-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, "Harshapriya.n" <harshapriya.n@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, mac.chiang@intel.com, Mark Brown <broonie@kernel.org>, chintan.m.patel@intel.com, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: kbl_da7219_max98927: add dai_trigger function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 53fdea9604fa1560bdbf418bbca564dbbebef211 Mon Sep 17 00:00:00 2001
From: Mac Chiang <mac.chiang@intel.com>
Date: Fri, 3 May 2019 10:48:17 +0800
Subject: [PATCH] ASoC: Intel: boards: kbl_da7219_max98927: add dai_trigger
 function

amplifier feedback is not modeled as being dependent on any active
output. Even when there is no playback happening, parts of the graph,
specifically the IV sense->speaker protection->output remains active
and this prevents the DSP from entering low-power states.

This patch suggest a machine driver level approach where the speaker
pins are enabled/disabled dynamically depending on stream start/stop
events. DPAM graph representations show the feedback loop is indeed
disabled and low-power states can be reached.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
Signed-off-by: Harshapriya.n <harshapriya.n@intel.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 73 +++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index f72a7bf028d7..1efe7fdad2cb 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -219,8 +219,60 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int kabylake_ssp0_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int j, ret;
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+		const char *name = codec_dai->component->name;
+		struct snd_soc_component *component = codec_dai->component;
+		struct snd_soc_dapm_context *dapm =
+				snd_soc_component_get_dapm(component);
+		char pin_name[20];
+
+		if (strcmp(name, MAX98927_DEV0_NAME) &&
+			strcmp(name, MAX98927_DEV1_NAME) &&
+			strcmp(name, MAX98373_DEV0_NAME) &&
+			strcmp(name, MAX98373_DEV1_NAME))
+			continue;
+
+		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
+			codec_dai->component->name_prefix);
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_RESUME:
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
+			if (ret) {
+				dev_err(rtd->dev, "failed to enable %s: %d\n",
+				pin_name, ret);
+				return ret;
+			}
+			snd_soc_dapm_sync(dapm);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
+			if (ret) {
+				dev_err(rtd->dev, "failed to disable %s: %d\n",
+				pin_name, ret);
+				return ret;
+			}
+			snd_soc_dapm_sync(dapm);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_ops kabylake_ssp0_ops = {
 	.hw_params = kabylake_ssp0_hw_params,
+	.trigger = kabylake_ssp0_trigger,
 };
 
 static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -950,6 +1002,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
 	struct kbl_hdmi_pcm *pcm;
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 	struct snd_soc_component *component = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
@@ -976,9 +1029,25 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 	if (!component)
 		return -EINVAL;
 
-	return hdac_hdmi_jack_port_init(component, &card->dapm);
 
-	return 0;
+	err = hdac_hdmi_jack_port_init(component, &card->dapm);
+
+	if (err < 0)
+		return err;
+
+	err = snd_soc_dapm_disable_pin(dapm, "Left Spk");
+	if (err) {
+		dev_err(card->dev, "failed to disable Left Spk: %d\n", err);
+		return err;
+	}
+
+	err = snd_soc_dapm_disable_pin(dapm, "Right Spk");
+	if (err) {
+		dev_err(card->dev, "failed to disable Right Spk: %d\n", err);
+		return err;
+	}
+
+	return snd_soc_dapm_sync(dapm);
 }
 
 /* kabylake audio machine driver for SPT + DA7219 */
-- 
2.20.1
