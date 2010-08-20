From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
 of_device with platform_device
Date: Fri, 20 Aug 2010 13:46:54 +0100
Message-ID: <20100820124654.GA18845@rakim.wolfsonmicro.main>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
	<1E324AB3-D941-4FB8-896E-97227A0CBCE7@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3F44103826
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 14:46:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1E324AB3-D941-4FB8-896E-97227A0CBCE7@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 07:43:57AM -0500, Tabi Timur-B04825 wrote:
> I based it off the for-2.6.37 branch, so it has to apply as is.  Can
> you tell me where the conflict is?

This is the result of an attempt to apply with a 3 way merge:

diff --cc sound/soc/fsl/fsl_dma.c
index 5a6f56d,cb78698..0000000
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@@ -876,9 -892,10 +877,9 @@@ static int __devinit fsl_soc_dma_probe(
  				       const struct of_device_id *match)
   {
  	struct dma_object *dma;
- 	struct device_node *np = of_dev->dev.of_node;
+ 	struct device_node *np = pdev->dev.of_node;
  	struct device_node *ssi_np;
  	struct resource res;
 -	const uint32_t *iprop;
  	int ret;
  
  	/* Find the SSI node that points to us. */
@@@ -889,15 -906,17 +890,26 @@@
  	}
  
  	ret = of_address_to_resource(ssi_np, 0, &res);
 +	of_node_put(ssi_np);
  	if (ret) {
++<<<<<<< HEAD
 +		dev_err(&of_dev->dev, "could not determine device resources\n");
++=======
+ 		dev_err(&pdev->dev, "could not determine resources for %s\n",
+ 			ssi_np->full_name);
+ 		of_node_put(ssi_np);
++>>>>>>> asoc/multi-component: mpc8610: replace of_device with platform_device
  		return ret;
  	}
  
  	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
  	if (!dma) {
++<<<<<<< HEAD
 +		dev_err(&of_dev->dev, "could not allocate dma object\n");
++=======
+ 		dev_err(&pdev->dev, "could not allocate dma object\n");
+ 		of_node_put(ssi_np);
++>>>>>>> asoc/multi-component: mpc8610: replace of_device with platform_device
  		return -ENOMEM;
  	}
  
@@@ -910,9 -929,18 +922,22 @@@
  	dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
  	dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
  
++<<<<<<< HEAD
 +	ret = snd_soc_register_platform(&of_dev->dev, &dma->dai);
++=======
+ 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
+ 	if (iprop)
+ 		dma->ssi_fifo_depth = *iprop;
+ 	else
+                 /* Older 8610 DTs didn't have the fifo-depth property */
+ 		dma->ssi_fifo_depth = 8;
+ 
+ 	of_node_put(ssi_np);
+ 
+ 	ret = snd_soc_register_platform(&pdev->dev, &dma->dai);
++>>>>>>> asoc/multi-component: mpc8610: replace of_device with platform_device
  	if (ret) {
- 		dev_err(&of_dev->dev, "could not register platform\n");
+ 		dev_err(&pdev->dev, "could not register platform\n");
  		kfree(dma);
  		return ret;
  	}
