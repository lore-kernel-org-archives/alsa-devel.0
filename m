From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 2/3] ASoC: simple-card: Simplify error msg in
	simple_card_dai_link_of()
Date: Thu, 24 Apr 2014 19:13:59 +0800
Message-ID: <64f9e48d758f3d3dd7bc806cef54df8aad8ac280.1398337861.git.Guangyu.Chen@freescale.com>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CA89265251
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:12:27 +0200 (CEST)
In-Reply-To: <cover.1398337861.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

It would look better to use prop instead.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/generic/simple-card.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 383a4a1..c091557 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -166,8 +166,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
 		ret = -EINVAL;
-		dev_err(dev, "%s: Can't find simple-audio-card,cpu DT node\n",
-			__func__);
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
 	}
 
@@ -198,8 +197,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
 		ret = -EINVAL;
-		dev_err(dev, "%s: Can't find simple-audio-card,codec DT node\n",
-			__func__);
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
 	}
 
-- 
1.8.4
