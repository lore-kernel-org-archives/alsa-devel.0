From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: rcar ctu: Staticise local symbols
Date: Mon, 27 Jul 2015 10:56:25 +0200
Message-ID: <1437987388-9706-4-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF1F52607F7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:38 +0200 (CEST)
In-Reply-To: <1437987388-9706-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

rsnd_of_parse_ctu() is not used outside this file so it can be static.
Fixes the following sparse warning:

	sound/soc/sh/rcar/ctu.c:72:6: warning: symbol 'rsnd_of_parse_ctu' was
		not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/rcar/ctu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 05edd20..05498bb 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -69,7 +69,7 @@ struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
 	return &((struct rsnd_ctu *)(priv->ctu) + id)->mod;
 }
 
-void rsnd_of_parse_ctu(struct platform_device *pdev,
+static void rsnd_of_parse_ctu(struct platform_device *pdev,
 		       const struct rsnd_of_data *of_data,
 		       struct rsnd_priv *priv)
 {
-- 
2.1.4
