From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v6 3/3] ASoC: simple-card: Remove useless check
Date: Thu, 1 Jan 2015 09:43:24 +0100
Message-ID: <e57c95c0e966055ddf2c65cddbec665fab7641c6.1420102454.git.moinejf@free.fr>
References: <cover.1420102454.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F0C2604BC
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 10:16:53 +0100 (CET)
In-Reply-To: <cover.1420102454.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The CPU and CODEC names are checked when getting the DAI names.
There is no need to check them once more.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a765869..c28d082 100644
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
2.1.4
