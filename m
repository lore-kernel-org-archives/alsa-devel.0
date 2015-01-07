From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_dma: Do not use 'full_name'
 node reference
Date: Wed, 7 Jan 2015 15:47:55 -0200
Message-ID: <CAOMZO5Cuq0ejHGOqE0W=-=qU-P_=qruKqzHxcVGkFpmEhydC8Q@mail.gmail.com>
References: <1420651312-21671-1-git-send-email-festevam@gmail.com>
 <1420651312-21671-2-git-send-email-festevam@gmail.com>
 <54AD6C55.7030600@metafoo.de> <54AD6C92.7060007@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 60CE926053B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:47:56 +0100 (CET)
Received: by mail-la0-f54.google.com with SMTP id pv20so4857528lab.13
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 09:47:56 -0800 (PST)
In-Reply-To: <54AD6C92.7060007@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 7, 2015 at 3:27 PM, Timur Tabi <timur@tabi.org> wrote:
> Lars-Peter Clausen wrote:
>>>
>>>
>>> -    dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
>>> +    dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>>
>>
>> This should probably be part of patch 1.
>
>
> I think you're right.

Thanks, so I can do it on a single patch then:

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 93d7e56..72e7979 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -63,7 +63,6 @@ struct dma_object {
     struct ccsr_dma_channel __iomem *channel;
     unsigned int irq;
     bool assigned;
-    char path[1];
 };

 /*
@@ -897,20 +896,18 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)

     ret = of_address_to_resource(ssi_np, 0, &res);
     if (ret) {
-        dev_err(&pdev->dev, "could not determine resources for %s\n",
-            ssi_np->full_name);
+        dev_err(&pdev->dev, "could not determine resources: %d\n", ret);
         of_node_put(ssi_np);
         return ret;
     }

-    dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+    dma = kzalloc(sizeof(*dma), GFP_KERNEL);
     if (!dma) {
         dev_err(&pdev->dev, "could not allocate dma object\n");
         of_node_put(ssi_np);
         return -ENOMEM;
     }

-    strcpy(dma->path, np->full_name);
     dma->dai.ops = &fsl_dma_ops;
     dma->dai.pcm_new = fsl_dma_new;
     dma->dai.pcm_free = fsl_dma_free_dma_buffers;
