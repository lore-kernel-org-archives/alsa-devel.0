From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove snd_soc_platform_trigger()" to
	the asoc tree
Date: Mon, 09 Jan 2017 20:01:21 +0000
Message-ID: <E1cQg89-0006qh-TU@debutante>
References: <8760mg74ma.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C016D266F0A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:33 +0100 (CET)
In-Reply-To: <8760mg74ma.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove snd_soc_platform_trigger()

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

>From 322962384da9739a5000f58e5f69c7832c448e0d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Dec 2016 07:37:37 +0000
Subject: [PATCH] ASoC: remove snd_soc_platform_trigger()

No one is using snd_soc_platform_trigger().
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 3 ---
 sound/soc/soc-pcm.c | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b37b21a3471f..5db4a90b1a02 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -507,9 +507,6 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *parms);
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
 
-int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
-		int cmd, struct snd_soc_platform *platform);
-
 int soc_dai_hw_params(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params,
 		      struct snd_soc_dai *dai);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 51927dc93c41..ff31bf5e646a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2871,15 +2871,6 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
 
-int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
-		int cmd, struct snd_soc_platform *platform)
-{
-	if (platform->driver->ops && platform->driver->ops->trigger)
-		return platform->driver->ops->trigger(substream, cmd);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_platform_trigger);
-
 #ifdef CONFIG_DEBUG_FS
 static const char *dpcm_state_string(enum snd_soc_dpcm_state state)
 {
-- 
2.11.0
