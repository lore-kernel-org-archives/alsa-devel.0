From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: simple-card: Fix property name for
	simple-audio-card, format
Date: Fri, 7 Mar 2014 14:18:31 +0200
Message-ID: <1394194711-32009-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 47ED6265465
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 13:18:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The "format" part of the property name is missing from the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7cabcc5c8703..064b404ed252 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -165,7 +165,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
-	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
+	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,format") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* off-codec widgets */
-- 
1.9.0
