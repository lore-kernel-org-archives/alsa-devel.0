From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: tidyup define
	position" to the asoc tree
Date: Fri, 23 Nov 2018 14:11:23 +0000 (GMT)
Message-ID: <20181123141123.AF452440078@finisterre.ee.mobilebroadband>
References: <87muq2lyxy.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3BE267A80
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:11:25 +0100 (CET)
In-Reply-To: <87muq2lyxy.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: tidyup define position

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

>From 64ef0817b9679b525f86773e929777be96f5c728 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:57:40 +0000
Subject: [PATCH] ASoC: audio-graph-card: tidyup define position

commit f986907c9225 ("ASoC: audio-graph-card: add widgets and routing for
external amplifier support") added new function
asoc_graph_card_outdrv_event(), but the inserted position breaks
define area. This patch tidyup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 101c7da2df7c..1b158cc2df88 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -36,6 +36,11 @@ struct graph_card_data {
 	struct gpio_desc *pa_gpio;
 };
 
+#define graph_priv_to_card(priv) (&(priv)->snd_card)
+#define graph_priv_to_props(priv, i) ((priv)->dai_props + (i))
+#define graph_priv_to_dev(priv) (graph_priv_to_card(priv)->dev)
+#define graph_priv_to_link(priv, i) (graph_priv_to_card(priv)->dai_link + (i))
+
 static int asoc_graph_card_outdrv_event(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *kcontrol,
 					int event)
@@ -63,11 +68,6 @@ static const struct snd_soc_dapm_widget asoc_graph_card_dapm_widgets[] = {
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
-#define graph_priv_to_card(priv) (&(priv)->snd_card)
-#define graph_priv_to_props(priv, i) ((priv)->dai_props + (i))
-#define graph_priv_to_dev(priv) (graph_priv_to_card(priv)->dev)
-#define graph_priv_to_link(priv, i) (graph_priv_to_card(priv)->dai_link + (i))
-
 static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-- 
2.19.1
