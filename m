From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix channel swap issue
 when stream starts
Date: Mon, 25 Feb 2019 18:33:00 -0800
Message-ID: <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
 <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7A1BF89664
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 03:33:07 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id q3so5455549pll.4
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 18:33:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 26, 2019 at 02:01:14AM +0000, S.j. Wang wrote:
> > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > > afe67c865330..23bd0ad4ac31 100644
> > > --- a/sound/soc/fsl/fsl_esai.c
> > > +++ b/sound/soc/fsl/fsl_esai.c
> > > @@ -54,6 +54,8 @@ struct fsl_esai {
> > >  	u32 fifo_depth;
> > >  	u32 slot_width;
> > >  	u32 slots;
> > > +	u32 tx_mask;
> > > +	u32 rx_mask;

> > >  	esai_priv->slot_width = slot_width;
> > >  	esai_priv->slots = slots;
> > > +	esai_priv->tx_mask    = tx_mask;
> > > +	esai_priv->rx_mask    = rx_mask;
> > 
> > The two masks only got values here. If a machine driver doesn't have a
> > set_dai_tdm_slot() call, they will be remained as 0 and then will seemly
> > clean those four registers.
> > 
> Then I think we need to add default value for tx_mask and rx_mask, that is
> In the probe function to add:
> esai_priv->tx_mask    =  0xFFFFFFFF;
> esai_priv->rx_mask    =  0xFFFFFFFF;

Yea:) Please include them in v3.
