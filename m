From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: snd_soc_component_driver has
	non_legacy_dai_naming" to the asoc tree
Date: Mon, 23 Oct 2017 10:43:05 +0100 (BST)
Message-ID: <20171023094305.5A92F440058@finisterre.ee.mobilebroadband>
References: <87o9qvm1j8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD2A266FCC
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 11:43:06 +0200 (CEST)
In-Reply-To: <87o9qvm1j8.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: snd_soc_component_driver has non_legacy_dai_naming

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

>From 69941bab7c7aeaa7bf7e84397e294c17f0b7c6df Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Oct 2017 01:38:51 +0000
Subject: [PATCH] ASoC: snd_soc_component_driver has non_legacy_dai_naming

Codec will be replaced into Component, then Codec side
doesn't use legacy_dai_naming on snd_soc_register_dais().

This patch adds new non_legacy_dai_naming flag on Component driver
and use converted its value for snd_soc_register_dais().

When Codec is replaced into Component, Codec driver needs
to have non_legacy_dai_naming = 1 flags.
Existing CPU side of course doesn't have this flag, thus CPU calls
it as true.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 1 +
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 747d080a0853..6c808527a4f6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -838,6 +838,7 @@ struct snd_soc_component_driver {
 	unsigned int suspend_bias_off:1;
 	unsigned int pmdown_time:1; /* care pmdown_time at stop */
 	unsigned int endianness:1;
+	unsigned int non_legacy_dai_naming:1;
 };
 
 struct snd_soc_component {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 61c3d3649914..533c822ca6e6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3462,7 +3462,8 @@ int snd_soc_add_component(struct device *dev,
 		}
 	}
 
-	ret = snd_soc_register_dais(component, dai_drv, num_dai, true);
+	ret = snd_soc_register_dais(component, dai_drv, num_dai,
+				    !component_driver->non_legacy_dai_naming);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to register DAIs: %d\n", ret);
 		goto err_cleanup;
-- 
2.14.1
