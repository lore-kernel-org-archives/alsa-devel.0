From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: Arrange DAI related parameter"
	to the asoc tree
Date: Wed, 20 Dec 2017 15:42:19 +0000
Message-ID: <E1eRgVf-00010f-UJ@debutante>
References: <87shc6xjne.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C30E92677EC
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 16:42:26 +0100 (CET)
In-Reply-To: <87shc6xjne.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc.h: Arrange DAI related parameter

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

>From 4855f6a6283fc8ea1f79c9f49c91940afef64ef6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:48:44 +0000
Subject: [PATCH] ASoC: soc.h: Arrange DAI related parameter

"dai_list" and "num_dai" on snd_soc_component are related
parameter. Let's arrange these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 871e1fabd701..be6b462e2c01 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -858,11 +858,10 @@ struct snd_soc_component {
 	struct list_head card_aux_list; /* for auxiliary bound components */
 	struct list_head card_list;
 
-	int num_dai;
-
 	const struct snd_soc_component_driver *driver;
 
 	struct list_head dai_list;
+	int num_dai;
 
 	int (*read)(struct snd_soc_component *, unsigned int, unsigned int *);
 	int (*write)(struct snd_soc_component *, unsigned int, unsigned int);
-- 
2.15.1
