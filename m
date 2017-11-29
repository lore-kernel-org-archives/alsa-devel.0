From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add missing
	EXPORT_SYMBOL_GPL() for snd_soc_disconnect_sync" to the asoc tree
Date: Wed, 29 Nov 2017 10:57:49 +0000
Message-ID: <E1eK03p-00065g-Ra@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9652678B0
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:57:52 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add missing EXPORT_SYMBOL_GPL() for snd_soc_disconnect_sync

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

>From df532185e8720baff120f55eb46058d270445d56 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 29 Nov 2017 02:38:27 +0000
Subject: [PATCH] ASoC: soc-core: add missing EXPORT_SYMBOL_GPL() for
 snd_soc_disconnect_sync

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9047046c749c..345baa4f10c0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1401,6 +1401,7 @@ void snd_soc_disconnect_sync(struct device *dev)
 
 	snd_card_disconnect_sync(component->card->snd_card);
 }
+EXPORT_SYMBOL_GPL(snd_soc_disconnect_sync);
 
 /**
  * snd_soc_add_dai_link - Add a DAI link dynamically
-- 
2.15.0
