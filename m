From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove duplicate definition of
	dapm_widgets/num_dapm_widgets" to the asoc tree
Date: Sun, 27 Aug 2017 14:37:49 +0100 (BST)
Message-ID: <20170827133749.33DE54400E7@finisterre.ee.mobilebroadband>
References: <87378gsdha.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5C34266EBF
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:37:49 +0200 (CEST)
In-Reply-To: <87378gsdha.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: remove duplicate definition of dapm_widgets/num_dapm_widgets

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

>From 688d0ebf49a97aa6959aebec5d177a8b821f27d1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 25 Aug 2017 00:29:20 +0000
Subject: [PATCH] ASoC: remove duplicate definition of
 dapm_widgets/num_dapm_widgets

snd_soc_component and snd_soc_component_driver both have
dapm_widgets/num_dapm_widgets, but these are duplicated.
Let's remove duplicated definition.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 2 --
 sound/soc/soc-core.c | 9 ++++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e4b4746032ba..3e0070ed6883 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -862,8 +862,6 @@ struct snd_soc_component {
 	/* Don't use these, use snd_soc_component_get_dapm() */
 	struct snd_soc_dapm_context dapm;
 
-	const struct snd_soc_dapm_widget *dapm_widgets;
-	unsigned int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	unsigned int num_dapm_routes;
 	struct snd_soc_codec *codec;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1317706f8e69..3a3236dc996d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1451,9 +1451,10 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 	soc_init_component_debugfs(component);
 
-	if (component->dapm_widgets) {
-		ret = snd_soc_dapm_new_controls(dapm, component->dapm_widgets,
-			component->num_dapm_widgets);
+	if (component->driver->dapm_widgets) {
+		ret = snd_soc_dapm_new_controls(dapm,
+					component->driver->dapm_widgets,
+					component->driver->num_dapm_widgets);
 
 		if (ret != 0) {
 			dev_err(component->dev,
@@ -3185,8 +3186,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	if (driver->stream_event)
 		dapm->stream_event = snd_soc_component_stream_event;
 
-	component->dapm_widgets = driver->dapm_widgets;
-	component->num_dapm_widgets = driver->num_dapm_widgets;
 	component->dapm_routes = driver->dapm_routes;
 	component->num_dapm_routes = driver->num_dapm_routes;
 
-- 
2.13.2
