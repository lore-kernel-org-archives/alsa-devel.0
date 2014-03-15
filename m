From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 1/4] ASoC: simple-card: Simplify code
Date: Sat, 15 Mar 2014 11:32:42 +0100
Message-ID: <c74668c9277d538b105ab93affe7d33a64342ee9.1394883134.git.moinejf@free.fr>
References: <cover.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5D4265095
 for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2014 12:41:55 +0100 (CET)
In-Reply-To: <cover.1394883134.git.moinejf@free.fr>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The global DAI format is used only in the function
asoc_simple_card_parse_of(). So, move it from the private data
to the stack.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index dcf37fb..ca7e63e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -20,7 +20,6 @@
 
 struct simple_card_data {
 	struct snd_soc_card snd_card;
-	unsigned int daifmt;
 	struct asoc_simple_dai cpu_dai;
 	struct asoc_simple_dai codec_dai;
 	struct snd_soc_dai_link snd_link;
@@ -154,13 +153,14 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	struct snd_soc_dai_link *dai_link = priv->snd_card.dai_link;
 	struct device_node *np;
 	char *name;
+	unsigned int daifmt;
 	int ret;
 
 	/* parsing the card name from DT */
 	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
-	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
+	daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* off-codec widgets */
@@ -183,7 +183,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np) {
-		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
+		ret = asoc_simple_card_sub_parse_of(np, daifmt,
 						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
 						  &dai_link->cpu_dai_name);
@@ -196,7 +196,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np) {
-		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
+		ret = asoc_simple_card_sub_parse_of(np, daifmt,
 						  &priv->codec_dai,
 						  &dai_link->codec_of_node,
 						  &dai_link->codec_dai_name);
@@ -223,7 +223,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	dai_link->platform_of_node = dai_link->cpu_of_node;
 
 	dev_dbg(dev, "card-name : %s\n", name);
-	dev_dbg(dev, "platform : %04x\n", priv->daifmt);
+	dev_dbg(dev, "platform : %04x\n", daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
 		dai_link->cpu_dai_name,
 		priv->cpu_dai.fmt,
-- 
1.9.0
