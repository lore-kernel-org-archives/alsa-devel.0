From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_get_dapm()" to
	the asoc tree
Date: Sun, 27 Aug 2017 14:38:19 +0100 (BST)
Message-ID: <20170827133819.51C0D4400E7@finisterre.ee.mobilebroadband>
References: <87ziaoqx7n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EEE4266F1C
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:38:20 +0200 (CEST)
In-Reply-To: <87ziaoqx7n.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use snd_soc_component_get_dapm()

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

>From 88c27465dc7e3f11c43de295f623c44f593a0912 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 25 Aug 2017 01:06:04 +0000
Subject: [PATCH] ASoC: use snd_soc_component_get_dapm()

Now we have snd_soc_component_get_dapm(),
and as soc.h say below, let's use it.

/* Don't use these, use snd_soc_component_get_dapm() */
struct snd_soc_dapm_context dapm;

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 74c17068bb11..92e09cb7fda4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3220,7 +3220,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->pcm_new = component->driver->pcm_new;
 	component->pcm_free = component->driver->pcm_free;
 
-	dapm = &component->dapm;
+	dapm = snd_soc_component_get_dapm(component);
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
-- 
2.13.2
