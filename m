From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: skip missing substream while applying symmetry" to the asoc tree
Date: Tue,  2 Apr 2019 06:46:38 +0100 (BST)
Message-ID: <20190402054638.9F576442467@finisterre.ee.mobilebroadband>
References: <20190401130354.24202-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401130354.24202-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: skip missing substream while applying symmetry

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

>From 6246f283d5e02ac757bd8d9bacde8fdc54c4582d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 1 Apr 2019 15:03:54 +0200
Subject: [PATCH] ASoC: dpcm: skip missing substream while applying symmetry

If for any reason, the backend does not have the requested substream
(like capture on a playback only backend), the BE will be skipped in
dpcm_be_dai_startup().

However, dpcm_apply_symmetry() does not skip those BE and will
dereference the be_substream (NULL) pointer anyway.

Like in dpcm_be_dai_startup(), just skip those BE.

Fixes: 906c7d690c3b ("ASoC: dpcm: Apply symmetry for DPCM")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7fe5321000e8..2d5d5cac4ba6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1911,10 +1911,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
-		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		struct snd_soc_pcm_runtime *rtd;
 		struct snd_soc_dai *codec_dai;
 		int i;
 
+		/* A backend may not have the requested substream */
+		if (!be_substream)
+			continue;
+
+		rtd = be_substream->private_data;
 		if (rtd->dai_link->be_hw_params_fixup)
 			continue;
 
-- 
2.20.1
