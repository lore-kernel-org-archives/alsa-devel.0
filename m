From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/3] sound/soc/au1x: keep pointer to resource
	so it can be freed
Date: Tue, 18 Oct 2011 05:45:55 +0200
Message-ID: <1318909555-12933-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DEC424358
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 04:48:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Axel Lin <axel.lin@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Add a new variable for storing resources accessed subsequent to the one
accessed using request_mem_region, so the one accessed using
request_mem_region can be released if needed.

This code is also missing some calls to iounmap.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression E, E1;
identifier f;
statement S1,S2,S3;
@@

if (E == NULL)
{
  ... when != if (E == NULL || ...) S1 else S2
      when != E = E1
*E->f
  ... when any
  return ...;
}
else S3
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/au1x/ac97c.c |   22 ++++++++++++----------
 sound/soc/au1x/i2sc.c  |   22 ++++++++++++----------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 13802ff..0188643 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -226,7 +226,7 @@ static struct snd_soc_dai_driver au1xac97c_dai_driver = {
 static int __devinit au1xac97c_drvprobe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *r;
+	struct resource *r, *r1;
 	struct au1xpsc_audio_data *ctx;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -249,15 +249,15 @@ static int __devinit au1xac97c_drvprobe(struct platform_device *pdev)
 	if (!ctx->mmio)
 		goto out1;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		goto out1;
-	ctx->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r->start;
+	r1 = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r1)
+		goto out2;
+	ctx->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r1->start;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		goto out1;
-	ctx->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r->start;
+	r1 = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r1)
+		goto out2;
+	ctx->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r1->start;
 
 	/* switch it on */
 	WR(ctx, AC97_ENABLE, EN_D | EN_CE);
@@ -270,11 +270,13 @@ static int __devinit au1xac97c_drvprobe(struct platform_device *pdev)
 
 	ret = snd_soc_register_dai(&pdev->dev, &au1xac97c_dai_driver);
 	if (ret)
-		goto out1;
+		goto out2;
 
 	ac97c_workdata = ctx;
 	return 0;
 
+out2:
+	iounmap(ctx->mmio);
 out1:
 	release_mem_region(r->start, resource_size(r));
 out0:
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 19e0d2a..3725c77 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -228,7 +228,7 @@ static struct snd_soc_dai_driver au1xi2s_dai_driver = {
 static int __devinit au1xi2s_drvprobe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *r;
+	struct resource *r, *r1;
 	struct au1xpsc_audio_data *ctx;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -249,24 +249,26 @@ static int __devinit au1xi2s_drvprobe(struct platform_device *pdev)
 	if (!ctx->mmio)
 		goto out1;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		goto out1;
-	ctx->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r->start;
+	r1 = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r1)
+		goto out2;
+	ctx->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r1->start;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		goto out1;
-	ctx->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r->start;
+	r1 = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r1)
+		goto out2;
+	ctx->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r1->start;
 
 	platform_set_drvdata(pdev, ctx);
 
 	ret = snd_soc_register_dai(&pdev->dev, &au1xi2s_dai_driver);
 	if (ret)
-		goto out1;
+		goto out2;
 
 	return 0;
 
+out2:
+	iounmap(ctx->mmio);
 out1:
 	release_mem_region(r->start, resource_size(r));
 out0:
