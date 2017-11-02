From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: rsnd: Request/Release DMA channel
	each time
Date: Thu, 2 Nov 2017 11:09:31 +0300
Message-ID: <20171102080931.rnssxnil65qfznjr@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFAE267376
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 09:09:56 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Kuninori Morimoto,

The patch edce5c496c6a: "ASoC: rsnd: Request/Release DMA channel each
time" from Nov 14, 2016, leads to the following static checker
warning:

	sound/soc/sh/rcar/dma.c:214 rsnd_dmaen_nolock_start()
	warn: passing zero to 'PTR_ERR'

sound/soc/sh/rcar/dma.c
   192  static int rsnd_dmaen_nolock_start(struct rsnd_mod *mod,
   193                              struct rsnd_dai_stream *io,
   194                              struct rsnd_priv *priv)
   195  {
   196          struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
   197          struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
   198          struct device *dev = rsnd_priv_to_dev(priv);
   199  
   200          if (dmaen->chan) {
   201                  dev_err(dev, "it already has dma channel\n");
   202                  return -EIO;
   203          }
   204  
   205          /*
   206           * DMAEngine request uses mutex lock.
   207           * Thus, it shouldn't be called under spinlock.
   208           * Let's call it under nolock_start
   209           */
   210          dmaen->chan = rsnd_dmaen_request_channel(io,
   211                                                   dma->mod_from,
   212                                                   dma->mod_to);
   213          if (IS_ERR_OR_NULL(dmaen->chan)) {
   214                  int ret = PTR_ERR(dmaen->chan);
   215  
   216                  dmaen->chan = NULL;
   217                  dev_err(dev, "can't get dma channel\n");
   218                  return ret;

PTR_ERR(NULL) is success.  Normally when a function returns both NULL
and error pointers, it means that NULL is not a error.  For example,
you call get_some_resource_pointer() and it returns NULL because your
computer doesn't have one of those resources plugged in, but it returns
an error pointer if it's defective or you're out of memory or whatever.
In this case it really feels like NULL is returned on error so the right
fix is to make rsnd_dmaen_request_channel() never return NULL and never
be checked for NULL.

   219          }
   220  
   221          return 0;
   222  }

regards,
dan carpenter
