From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Do not reload dsp-fw if
	samplerate has not changed" to the asoc tree
Date: Mon, 16 Apr 2018 12:59:25 +0100
Message-ID: <E1f82n7-0008V0-8G@debutante>
References: <20180409131336.21990-2-robert.rosengren@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D20CB2673C7
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 13:59:29 +0200 (CEST)
In-Reply-To: <20180409131336.21990-2-robert.rosengren@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Smith <dannys@axis.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Robert Rosengren <robert.rosengren@axis.com>, Robert Rosengren <robertr@axis.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau17x1: Do not reload dsp-fw if samplerate has not changed

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

>From 728815e3feec751769b3a9fe406fbc529de7cdc0 Mon Sep 17 00:00:00 2001
From: Danny Smith <dannys@axis.com>
Date: Mon, 9 Apr 2018 15:13:36 +0200
Subject: [PATCH] ASoC: adau17x1: Do not reload dsp-fw if samplerate has not
 changed

Reloading fw causes an audiable popping sound, we can avoid this
by not reloading if the samplerate is the same as before.

Signed-off-by: Danny Smith <dannys@axis.com>
Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 12bf24c26818..ae41edd1c406 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -843,6 +843,15 @@ int adau17x1_setup_firmware(struct snd_soc_component *component,
 	struct adau *adau = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
+	/* Check if sample rate is the same as before. If it is there is no
+	 * point in performing the below steps as the call to
+	 * sigmadsp_setup(...) will return directly when it finds the sample
+	 * rate to be the same as before. By checking this we can prevent an
+	 * audiable popping noise which occours when toggling DSP_RUN.
+	 */
+	if (adau->sigmadsp->current_samplerate == rate)
+		return 0;
+
 	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
-- 
2.17.0
