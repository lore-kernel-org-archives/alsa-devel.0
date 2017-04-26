From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ASoC: simple-scu-card: Use devm_kcalloc()
 in asoc_simple_card_probe()
Date: Wed, 26 Apr 2017 15:06:58 +0200
Message-ID: <5ccce752-8b67-ca22-0883-3a3628458fb6@users.sourceforge.net>
References: <8b5e37d1-17c5-4551-801f-ca7939d5efd7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D18266FEC
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 15:07:09 +0200 (CEST)
In-Reply-To: <8b5e37d1-17c5-4551-801f-ca7939d5efd7@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 14:40:40 +0200

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "devm_kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/generic/simple-scu-card.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index dcbcab230d1b..530a7aa387c5 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -270,9 +270,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	num = of_get_child_count(np);
-
-	dai_props = devm_kzalloc(dev, sizeof(*dai_props) * num, GFP_KERNEL);
-	dai_link  = devm_kzalloc(dev, sizeof(*dai_link)  * num, GFP_KERNEL);
+	dai_props = devm_kcalloc(dev, num, sizeof(*dai_props), GFP_KERNEL);
+	dai_link  = devm_kcalloc(dev, num, sizeof(*dai_link), GFP_KERNEL);
 	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
-- 
2.12.2
