From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 3/7] ASoC: generic: make snd_soc_ops const
Date: Wed, 16 Aug 2017 22:29:26 +0530
Message-ID: <1502902770-3758-4-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, heiko@sntech.de, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/generic/audio-graph-card.c     | 2 +-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index de2550c..2f7c8cf 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -95,7 +95,7 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
-static struct snd_soc_ops asoc_graph_card_ops = {
+static const struct snd_soc_ops asoc_graph_card_ops = {
 	.startup = asoc_graph_card_startup,
 	.shutdown = asoc_graph_card_shutdown,
 };
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 758ac06..06b6fcf 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -56,7 +56,7 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(dai_props);
 }
 
-static struct snd_soc_ops asoc_graph_card_ops = {
+static const struct snd_soc_ops asoc_graph_card_ops = {
 	.startup = asoc_graph_card_startup,
 	.shutdown = asoc_graph_card_shutdown,
 };
-- 
1.9.1
