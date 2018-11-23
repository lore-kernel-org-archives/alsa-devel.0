From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: tidyup typo
	SND_AUDIO_GRAPH_CARD" to the asoc tree
Date: Fri, 23 Nov 2018 14:11:35 +0000 (GMT)
Message-ID: <20181123141135.C755F440078@finisterre.ee.mobilebroadband>
References: <87o9ailyyf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C992A267A90
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:11:37 +0100 (CET)
In-Reply-To: <87o9ailyyf.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: tidyup typo SND_AUDIO_GRAPH_CARD

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

>From c3830f1a00f0c7b224aa64e99adbdc14e86d78d5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:57:23 +0000
Subject: [PATCH] ASoC: audio-graph-card: tidyup typo SND_AUDIO_GRAPH_CARD

1 "simple" is enough on Kconfig help

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index c954be0a0f96..fa5aff9c1041 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -20,7 +20,7 @@ config SND_AUDIO_GRAPH_CARD
 	depends on OF
 	select SND_SIMPLE_CARD_UTILS
 	help
-	  This option enables generic simple simple sound card support
+	  This option enables generic simple sound card support
 	  with OF-graph DT bindings.
 
 config SND_AUDIO_GRAPH_SCU_CARD
-- 
2.19.1
