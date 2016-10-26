From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: add missing return in messages
	strings" to the asoc tree
Date: Wed, 26 Oct 2016 11:45:57 +0100
Message-ID: <E1bzLiX-0005Kj-7x@debutante>
References: <1477320177-30130-7-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A59B2266FBB
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:04 +0200 (CEST)
In-Reply-To: <1477320177-30130-7-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: add missing return in messages strings

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

>From 92591efabc013fa791f96df881aafcc104ba759d Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:56 +0200
Subject: [PATCH] ASoC: sti-sas: add missing return in messages strings

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 1488f4fb1c5e..21d087be2e93 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -124,7 +124,7 @@ static int  sti_sas_init_sas_registers(struct snd_soc_codec *codec,
 		ret = snd_soc_update_bits(codec, STIH407_AUDIO_GLUE_CTRL,
 					  SPDIF_BIPHASE_IDLE_MASK, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to update SPDIF registers");
+		dev_err(codec->dev, "Failed to update SPDIF registers\n");
 		return ret;
 	}
 
@@ -144,7 +144,7 @@ static int  sti_sas_init_sas_registers(struct snd_soc_codec *codec,
 					  STIH407_DAC_SOFTMUTE_MASK);
 
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to update DAC registers");
+		dev_err(codec->dev, "Failed to update DAC registers\n");
 		return ret;
 	}
 
@@ -292,13 +292,13 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case STI_SAS_DAI_SPDIF_OUT:
 		if ((drvdata->spdif.mclk / runtime->rate) != 128) {
-			dev_err(codec->dev, "unexpected mclk-fs ratio");
+			dev_err(codec->dev, "unexpected mclk-fs ratio\n");
 			return -EINVAL;
 		}
 		break;
 	case STI_SAS_DAI_ANALOG_OUT:
 		if ((drvdata->dac.mclk / runtime->rate) != 256) {
-			dev_err(codec->dev, "unexpected mclk-fs ratio");
+			dev_err(codec->dev, "unexpected mclk-fs ratio\n");
 			return -EINVAL;
 		}
 		break;
@@ -423,7 +423,7 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 	/* Populate data structure depending on compatibility */
 	of_id = of_match_node(sti_sas_dev_match, pnode);
 	if (!of_id->data) {
-		dev_err(&pdev->dev, "data associated to device is missing");
+		dev_err(&pdev->dev, "data associated to device is missing\n");
 		return -EINVAL;
 	}
 
-- 
2.8.1
