From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: constify snd_soc_dai_ops
	structures" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:18 +0100
Message-ID: <E1dX8XK-00054d-Ua@debutante>
References: <20170713062606.GA27121@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F6B72673CF
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:43 +0200 (CEST)
In-Reply-To: <20170713062606.GA27121@embeddedgus>
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

   ASoC: Intel: Atom: constify snd_soc_dai_ops structures

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

>From c115a3178b1dfacd57b643934bb6bbbd1a9557f0 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 01:26:06 -0500
Subject: [PATCH] ASoC: Intel: Atom: constify snd_soc_dai_ops structures

These structures are only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index b082b31023d5..49c7b88b5bdc 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -471,7 +471,7 @@ static void sst_disable_ssp(struct snd_pcm_substream *substream,
 	}
 }
 
-static struct snd_soc_dai_ops sst_media_dai_ops = {
+static const struct snd_soc_dai_ops sst_media_dai_ops = {
 	.startup = sst_media_open,
 	.shutdown = sst_media_close,
 	.prepare = sst_media_prepare,
@@ -480,11 +480,11 @@ static struct snd_soc_dai_ops sst_media_dai_ops = {
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_compr_dai_ops = {
+static const struct snd_soc_dai_ops sst_compr_dai_ops = {
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_be_dai_ops = {
+static const struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
 	.hw_params = sst_be_hw_params,
 	.set_fmt = sst_set_format,
-- 
2.13.2
