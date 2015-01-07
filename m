From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_dma: Do not use 'full_name'
 node reference
Date: Wed, 07 Jan 2015 11:54:07 -0600
Message-ID: <54AD72BF.20805@tabi.org>
References: <1420651312-21671-1-git-send-email-festevam@gmail.com>	<1420651312-21671-2-git-send-email-festevam@gmail.com>	<54AD6C55.7030600@metafoo.de>	<54AD6C92.7060007@tabi.org>
 <CAOMZO5Cuq0ejHGOqE0W=-=qU-P_=qruKqzHxcVGkFpmEhydC8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 4634026053B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:54:10 +0100 (CET)
In-Reply-To: <CAOMZO5Cuq0ejHGOqE0W=-=qU-P_=qruKqzHxcVGkFpmEhydC8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> -        dev_err(&pdev->dev, "could not determine resources for %s\n",
> -            ssi_np->full_name);
> +        dev_err(&pdev->dev, "could not determine resources: %d\n", ret);

I remember now why I did this, and I might need to NACK this patch. 
ssi_np->full_name is the name of the SSI node, but here, dev_err will 
print the name of the DMA node.  So the intent is to help the user 
determine which SSI node has a broken DMA node pointer.  This probably 
is useful only on PowerPC, which uses the old ssi->dma linkage.
