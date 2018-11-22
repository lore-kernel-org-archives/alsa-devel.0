From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 10/10] ASoC: audio-graph-card: tidyup define
	position
Date: Thu, 22 Nov 2018 00:57:40 +0000
Message-ID: <87muq2lyxy.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410128.outbound.protection.outlook.com [40.107.141.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D3E26770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:57:44 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <AB94C95628F2C84DACC2091A844F09A2@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit f986907c9225 ("ASoC: audio-graph-card: add widgets and routing for
external amplifier support") added new function
asoc_graph_card_outdrv_event(), but the inserted position breaks
define area. This patch tidyup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 101c7da..1b158cc 100644
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
2.7.4
