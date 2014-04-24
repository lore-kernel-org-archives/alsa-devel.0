From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 1/3] ASoC: simple-card: Drop node->name checking
Date: Thu, 24 Apr 2014 19:13:58 +0800
Message-ID: <ef6f96d375c8771c93469168790e0098610bd250.1398337861.git.Guangyu.Chen@freescale.com>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 by alsa0.perex.cz (Postfix) with ESMTP id A1593265200
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:12:23 +0200 (CEST)
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

The current simple-card driver limits the DT node name to "sound".
Any of other names is forbidden while actually we should allow DT
to pass other node names.

And if this function is being called, the node must already have
the compatible "simple-audio-card" in DTB. So there should be no
need to check the name here.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/generic/simple-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3f2e580..383a4a1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -156,8 +156,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 	char *prefix = "";
 	int ret;
 
-	if (!strcmp("sound", node->name))
-		prefix = "simple-audio-card,";
+	prefix = "simple-audio-card,";
 
 	daifmt = snd_soc_of_parse_daifmt(node, prefix,
 					 &bitclkmaster, &framemaster);
-- 
1.8.4
