From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx-tdm: constify snd_soc_dai_ops
	structure" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:05 +0100
Message-ID: <E1dX8W9-0004f5-VG@debutante>
References: <20170713053052.GA13749@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6802673D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:05:33 +0200 (CEST)
In-Reply-To: <20170713053052.GA13749@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx-tdm: constify snd_soc_dai_ops structure

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

>From 171dd51655b11331928dd39ff0e51a516e41424d Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 00:30:52 -0500
Subject: [PATCH] ASoC: zx-tdm: constify snd_soc_dai_ops structure

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index bd632cc503b3..dc955272f58b 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -309,7 +309,7 @@ static void zx_tdm_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(zx_tdm->dai_wclk);
 }
 
-static struct snd_soc_dai_ops zx_tdm_dai_ops = {
+static const struct snd_soc_dai_ops zx_tdm_dai_ops = {
 	.trigger	= zx_tdm_trigger,
 	.hw_params	= zx_tdm_hw_params,
 	.set_fmt	= zx_tdm_set_fmt,
-- 
2.13.2
