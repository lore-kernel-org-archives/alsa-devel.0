From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v4 2/4] ASoC: simple-card: Remove useless function argument
Date: Sun, 9 Nov 2014 10:12:51 +0100
Message-ID: <ca3a9442e3f26e33ded73cc510f1fae56a275bb5.1415605717.git.moinejf@free.fr>
References: <cover.1415605716.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1415605716.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The device node pointer 'cpu' is not used in the function
asoc_simple_card_parse_daifmt().

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3e3fec4..ece22d5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -232,7 +232,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 
 static int asoc_simple_card_parse_daifmt(struct device_node *node,
 					 struct simple_card_data *priv,
-					 struct device_node *cpu,
 					 struct device_node *codec,
 					 char *prefix, int idx)
 {
@@ -309,7 +308,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	}
 
 	ret = asoc_simple_card_parse_daifmt(node, priv,
-					    cpu, codec, prefix, idx);
+					    codec, prefix, idx);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-- 
2.1.3
