From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 3/4] sound/soc/mxs/mxs-saif.c: add missing kfree
Date: Sat, 20 Aug 2011 17:18:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108201718200.30651@ask.diku.dk>
References: <1313820761-12042-3-git-send-email-julia@diku.dk>
 <20110820134439.GA2266@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110820134439.GA2266@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Liam Girdwood <lrg@ti.com>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Dong Aisheng <b29396@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Move the test on pdev->id before the kzalloc to avoid requiring kfree when
the test fails.  This fix was suggested by Wolfram Sang.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
expression E1!=0,E2,E3,E4;
statement S;
iterator I;
@@

(
if (...) { ... when != kfree(x)
               when != x = E3
               when != E3 = x
*  return ...;
 }
... when != x = E2
    when != I(...,x,...) S
if (...) { ... when != x = E4
 kfree(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 0b3adae..e9a90e4 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -519,12 +519,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	struct mxs_saif *saif;
 	int ret = 0;
 
+	if (pdev->id >= ARRAY_SIZE(mxs_saif))
+		return -EINVAL;
 	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
-
-	if (pdev->id >= ARRAY_SIZE(mxs_saif))
-		return -EINVAL;
 	mxs_saif[pdev->id] = saif;
 
 	saif->clk = clk_get(&pdev->dev, NULL);
