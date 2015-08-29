From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sti_uniperif: Ensure component is
 unregistered when unload module
Date: Sat, 29 Aug 2015 23:06:32 +0800
Message-ID: <1440860792.28601.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 12036260671
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 17:06:38 +0200 (CEST)
Received: by padhm10 with SMTP id hm10so36198305pad.3
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 08:06:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use devm_snd_soc_register_component to ensure component is unregistered
when unload the module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/sti/sti_uniperif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index dffabf3..39bcefe 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -224,9 +224,9 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-	ret = snd_soc_register_component(&pdev->dev,
-					 &sti_uniperiph_dai_component,
-					 priv->dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &sti_uniperiph_dai_component,
+					      priv->dai, 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.1.0
