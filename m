From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: constify snd_soc_dai_ops
	structures" to the asoc tree
Date: Mon,  5 Nov 2018 11:58:34 +0000 (GMT)
Message-ID: <20181105115834.1EC751124D98@debutante.sirena.org.uk>
References: <1540647284-26728-4-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B4002678DD
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:58:34 +0100 (CET)
In-Reply-To: <1540647284-26728-4-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: constify snd_soc_dai_ops structures

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

>From 704a9fc20b87f2929732cab0a1a04f28d4093085 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 27 Oct 2018 15:34:44 +0200
Subject: [PATCH] ASoC: codecs: constify snd_soc_dai_ops structures

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c   | 2 +-
 sound/soc/codecs/ak5558.c   | 2 +-
 sound/soc/codecs/hdac_hda.c | 2 +-
 sound/soc/codecs/tas6424.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 299ada4dfaa0..70d4c89bd6fc 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -456,7 +456,7 @@ static int ak4458_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops ak4458_dai_ops = {
+static const struct snd_soc_dai_ops ak4458_dai_ops = {
 	.startup        = ak4458_startup,
 	.hw_params	= ak4458_hw_params,
 	.set_fmt	= ak4458_set_dai_fmt,
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 448bb90c9c8e..60f1f12c81ea 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -246,7 +246,7 @@ static int ak5558_startup(struct snd_pcm_substream *substream,
 					  &ak5558_rate_constraints);
 }
 
-static struct snd_soc_dai_ops ak5558_dai_ops = {
+static const struct snd_soc_dai_ops ak5558_dai_ops = {
 	.startup        = ak5558_startup,
 	.hw_params	= ak5558_hw_params,
 
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 2aaa83028e55..ffecdaaa8cf2 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -46,7 +46,7 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 						 struct snd_soc_dai *dai);
 
-static struct snd_soc_dai_ops hdac_hda_dai_ops = {
+static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.startup = hdac_hda_dai_open,
 	.shutdown = hdac_hda_dai_close,
 	.prepare = hdac_hda_dai_prepare,
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 36aebdb8f55c..aaba39295079 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -378,7 +378,7 @@ static struct snd_soc_component_driver soc_codec_dev_tas6424 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
 	.hw_params	= tas6424_hw_params,
 	.set_fmt	= tas6424_set_dai_fmt,
 	.set_tdm_slot	= tas6424_set_dai_tdm_slot,
-- 
2.19.0.rc2
