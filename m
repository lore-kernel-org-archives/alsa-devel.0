From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: rename
	soc_post_component_init() to soc_rtd_init()" to the asoc tree
Date: Fri, 23 Aug 2019 11:46:14 +0100 (BST)
Message-ID: <20190823104614.2832CD02CD0@fitzroy.sirena.org.uk>
References: <87v9uo7lc3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0C24F80141
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 12:46:15 +0200 (CEST)
In-Reply-To: <87v9uo7lc3.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: rename soc_post_component_init() to soc_rtd_init()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 542694df7511977c3baa6ba855126a0cce883977 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 23 Aug 2019 09:58:32 +0900
Subject: [PATCH] ASoC: soc-core: rename soc_post_component_init() to
 soc_rtd_init()

It is easy to read code if it is cleanly using paired function/naming,
like start <-> stop, register <-> unregister, etc, etc.
But, current ALSA SoC code is very random, unbalance, not paired, etc.
It is easy to create bug at the such code, and it will be difficult to
debug.

>From function name point of view, "soc_post_component_init()" sounds
like "component initialize function".
But in reality it is rtd setup function.

This patch renames soc_post_component_init() to soc_rtd_init()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87v9uo7lc3.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0af83963289f..3c087b478398 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1340,13 +1340,12 @@ static int soc_probe_component(struct snd_soc_card *card,
 	return ret;
 }
 
-static void rtd_release(struct device *dev)
+static void soc_rtd_release(struct device *dev)
 {
 	kfree(dev);
 }
 
-static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
-	const char *name)
+static int soc_rtd_init(struct snd_soc_pcm_runtime *rtd, const char *name)
 {
 	int ret = 0;
 
@@ -1355,7 +1354,7 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	if (!rtd->dev)
 		return -ENOMEM;
 	rtd->dev->parent = rtd->card->dev;
-	rtd->dev->release = rtd_release;
+	rtd->dev->release = soc_rtd_release;
 	rtd->dev->groups = soc_dev_attr_groups;
 	dev_set_name(rtd->dev, "%s", name);
 	dev_set_drvdata(rtd->dev, rtd);
@@ -1483,7 +1482,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 			return ret;
 	}
 
-	ret = soc_post_component_init(rtd, dai_link->name);
+	ret = soc_rtd_init(rtd, dai_link->name);
 	if (ret)
 		return ret;
 
-- 
2.20.1
