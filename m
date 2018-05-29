From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: symmetry constraint on FE
	substream" to the asoc tree
Date: Tue, 29 May 2018 15:59:35 +0100
Message-ID: <E1fNg63-000678-HT@debutante>
References: <1526980408-1935-3-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42248267712
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 16:59:46 +0200 (CEST)
In-Reply-To: <1526980408-1935-3-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: symmetry constraint on FE substream

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

>From 99bcedbdebc57fe5d02fb470b7265f2208c2cf96 Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Mon, 28 May 2018 10:18:19 +0800
Subject: [PATCH] ASoC: dpcm: symmetry constraint on FE substream

We should set BE symmetric constraint on FE substream.

in case one BE is used by two FE1/FE2,
the first BE runtime will use FE1's substream->runtime.
hence the FE1's will be constrained by BE symmetry property.

Though, second FE2 call dpcm_apply_symmetry,
the be_substream->runtime == FE1's substream->runtime.
The FE2's substream->runtime will not be constrained
by BE's symmetry property.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2d846b3dd70c..0e2b2c6c60bd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1779,14 +1779,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 
 		/* Symmetry only applies if we've got an active stream. */
 		if (rtd->cpu_dai->active) {
-			err = soc_pcm_apply_symmetry(be_substream, rtd->cpu_dai);
+			err = soc_pcm_apply_symmetry(fe_substream,
+						     rtd->cpu_dai);
 			if (err < 0)
 				return err;
 		}
 
 		for (i = 0; i < rtd->num_codecs; i++) {
 			if (rtd->codec_dais[i]->active) {
-				err = soc_pcm_apply_symmetry(be_substream,
+				err = soc_pcm_apply_symmetry(fe_substream,
 							     rtd->codec_dais[i]);
 				if (err < 0)
 					return err;
-- 
2.17.0
