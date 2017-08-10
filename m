From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: rsnd: Delete an error message for a
 failed memory allocation in three functions
Date: Thu, 10 Aug 2017 17:25:48 +0200
Message-ID: <181b6355-b6b6-eeae-d85b-9fb465d96b85@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id F31C62665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 17:26:33 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Fengguang Wu <fengguang.wu@intel.com>, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 17:13:19 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/sh/rcar/adg.c  | 4 +---
 sound/soc/sh/rcar/core.c | 4 +---
 sound/soc/sh/rcar/gen.c  | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 5b5389e5b92b..938baff86ef2 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -586,10 +586,8 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	int ret;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
-	if (!adg) {
-		dev_err(dev, "ADG allocate failed\n");
+	if (!adg)
 		return -ENOMEM;
-	}
 
 	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
 		      NULL, NULL, 0, 0);
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index c34562388cfa..9e331a474a21 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1402,10 +1402,8 @@ static int rsnd_probe(struct platform_device *pdev)
 	 *	init priv data
 	 */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "priv allocate failed\n");
+	if (!priv)
 		return -ENODEV;
-	}
 
 	priv->pdev	= pdev;
 	priv->flags	= (unsigned long)of_device_get_match_data(dev);
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index ee00e3516911..f04c4100043a 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -406,10 +406,8 @@ int rsnd_gen_probe(struct rsnd_priv *priv)
 	int ret;
 
 	gen = devm_kzalloc(dev, sizeof(*gen), GFP_KERNEL);
-	if (!gen) {
-		dev_err(dev, "GEN allocate failed\n");
+	if (!gen)
 		return -ENOMEM;
-	}
 
 	priv->gen = gen;
 
-- 
2.14.0
