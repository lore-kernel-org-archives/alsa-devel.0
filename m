From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Fix the compile warning.
Date: Mon, 18 Aug 2014 15:00:15 +0800
Message-ID: <1408345215-30783-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 829BA26577E
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 09:04:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/generic/simple-card.c: In function simple_card_dai_link_of:
sound/soc/generic/simple-card.c:198:10: warning: passing argument 3 of
asoc_simple_card_sub_parse_of from incompatible pointer type [enabled by default]
          &dai_link->cpu_dai_name);
          ^
sound/soc/generic/simple-card.c:112:1: note: expected const struct device_node **
but argument is of type struct device_node **
 asoc_simple_card_sub_parse_of(struct device_node *np,
 ^
sound/soc/generic/simple-card.c:229:10: warning: passing argument 3 of
asoc_simple_card_sub_parse_of from incompatible pointer type [enabled by default]
          &dai_link->codec_dai_name);
          ^
sound/soc/generic/simple-card.c:112:1: note: expected const struct device_node **
but argument is of type struct device_node **
 asoc_simple_card_sub_parse_of(struct device_node *np,
 ^

Since the asoc_simple_card_sub_parse_of() is used in simple-card module only,
and the third argument is just used to get the node ponters address, so there is
no need it must to be 'const' type.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 159e517f..21b0ea2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -111,7 +111,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
-			      const struct device_node **p_node,
+			      struct device_node **p_node,
 			      const char **name)
 {
 	struct device_node *node;
-- 
1.8.5
