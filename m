From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_max98090: remove useless
	code, align with ChromeOS driver" to the asoc tree
Date: Mon, 09 Oct 2017 11:44:29 +0100
Message-ID: <E1e1VXx-0001hE-LN@debutante>
References: <20171005040427.26612-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E87DA266B38
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 12:44:39 +0200 (CEST)
In-Reply-To: <20171005040427.26612-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, broonie@kernel.org, Thierry Escande <thierry.escande@collabora.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_max98090: remove useless code, align with ChromeOS driver

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

>From 0087f2013188d8b332cee2f74fd3c6754a49f620 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 4 Oct 2017 23:04:27 -0500
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090: remove useless code, align
 with ChromeOS driver

Remove dead code which was missed in previous changes. This is not
visible with git diff but there is a test+return on the same condition
just above.

Also reuse local variable instead of fetching the jack information twice.

Tested on Acer R11 (cyan)

Fixes: 3bbda5a38601 ('ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization')
Cc: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 6519604b9577..a23eba7bb056 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -219,10 +219,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-
-	if (ctx->ts3a227e_present)
-		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
-
 	ret = snd_soc_jack_add_gpiods(runtime->card->dev->parent, jack,
 				      ARRAY_SIZE(hs_jack_gpios),
 				      hs_jack_gpios);
@@ -323,7 +319,7 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
 		return ret;
 	}
 
-	return ts3a227e_enable_jack_detect(component, &ctx->jack);
+	return ts3a227e_enable_jack_detect(component, jack);
 }
 
 static const struct snd_soc_ops cht_aif1_ops = {
-- 
2.14.1
