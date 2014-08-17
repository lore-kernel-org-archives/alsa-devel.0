From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: rcar: Use && instead of & for
	boolean expressions
Date: Sun, 17 Aug 2014 16:18:19 +0200
Message-ID: <1408285102-24538-4-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id D99632650EE
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:28 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Sparse spits out the following warning:
	sound/soc/sh/rcar/gen.c:250:21: warning: dubious: x & !y

It does this because sometimes mixing boolean and bit-wise logic has not the
intended result. In this case we are fine, but replacing the bit-wise '&' with
the boolean '&&' silences the sparse warning. The generated code for both cases
is the same.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/rcar/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 3fdf3be..f95e7ab 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -247,7 +247,7 @@ rsnd_gen2_dma_addr(struct rsnd_priv *priv,
 	};
 
 	/* it shouldn't happen */
-	if (use_dvc & !use_src)
+	if (use_dvc && !use_src)
 		dev_err(dev, "DVC is selected without SRC\n");
 
 	/* use SSIU or SSI ? */
-- 
1.8.0
