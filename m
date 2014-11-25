From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v5 4/4] ASoC: simple-card: Remove useless check
Date: Tue, 25 Nov 2014 13:33:17 +0100
Message-ID: <f093539970f62dbf319a7f7fee6360e05c32a1de.1416918909.git.moinejf@free.fr>
References: <cover.1416918909.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1416918909.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The CPU and CODEC names are checked when getting the DAI names.
There is no need to check them once more.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 61f9500..c1ba78b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -319,11 +319,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
-		ret = -EINVAL;
-		goto dai_link_of_err;
-	}
-
 	/* Simple Card assumes platform == cpu */
 	dai_link->platform_of_node = dai_link->cpu_of_node;
 
-- 
2.1.3
