From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove
	snd_soc_component_add_unlocked()" to the asoc tree
Date: Wed,  9 May 2018 10:42:11 +0100 (BST)
Message-ID: <20180509094211.3D92244007A@finisterre.ee.mobilebroadband>
References: <878t8urg1e.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 92EF526775E
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:03 +0200 (CEST)
In-Reply-To: <878t8urg1e.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: remove snd_soc_component_add_unlocked()

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

>From 359c71eeacbdd93d7870035af9a830140798fc67 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:22:11 +0000
Subject: [PATCH] ASoC: soc-core: remove snd_soc_component_add_unlocked()

There is no user to call snd_soc_component_add_unlocked() anymore.
Let's merge snd_soc_component_add_unlocked() and
snd_soc_component_add().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f22ef347eead..2d3abb3f1231 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2958,8 +2958,10 @@ EXPORT_SYMBOL_GPL(snd_soc_component_exit_regmap);
 
 #endif
 
-static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
+static void snd_soc_component_add(struct snd_soc_component *component)
 {
+	mutex_lock(&client_mutex);
+
 	if (!component->driver->write && !component->driver->read) {
 		if (!component->regmap)
 			component->regmap = dev_get_regmap(component->dev, NULL);
@@ -2969,12 +2971,7 @@ static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
 
 	list_add(&component->list, &component_list);
 	INIT_LIST_HEAD(&component->dobj_list);
-}
 
-static void snd_soc_component_add(struct snd_soc_component *component)
-{
-	mutex_lock(&client_mutex);
-	snd_soc_component_add_unlocked(component);
 	mutex_unlock(&client_mutex);
 }
 
-- 
2.17.0
