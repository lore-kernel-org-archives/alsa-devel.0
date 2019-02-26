From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix channel swap issue
 when stream starts
Date: Tue, 26 Feb 2019 02:54:45 +0000
Message-ID: <VI1PR0402MB339284333AB2589A4730770DE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
 <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8399FF80734
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 03:54:46 +0100 (CET)
In-Reply-To: <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org



> 
> On Tue, Feb 26, 2019 at 02:01:14AM +0000, S.j. Wang wrote:
> > > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > > > index
> > > > afe67c865330..23bd0ad4ac31 100644
> > > > --- a/sound/soc/fsl/fsl_esai.c
> > > > +++ b/sound/soc/fsl/fsl_esai.c
> > > > @@ -54,6 +54,8 @@ struct fsl_esai {
> > > >  	u32 fifo_depth;
> > > >  	u32 slot_width;
> > > >  	u32 slots;
> > > > +	u32 tx_mask;
> > > > +	u32 rx_mask;
> 
> > > >  	esai_priv->slot_width = slot_width;
> > > >  	esai_priv->slots = slots;
> > > > +	esai_priv->tx_mask    = tx_mask;
> > > > +	esai_priv->rx_mask    = rx_mask;
> > >
> > > The two masks only got values here. If a machine driver doesn't have
> > > a
> > > set_dai_tdm_slot() call, they will be remained as 0 and then will
> > > seemly clean those four registers.
> > >
> > Then I think we need to add default value for tx_mask and rx_mask,
> > that is In the probe function to add:
> > esai_priv->tx_mask    =  0xFFFFFFFF;
> > esai_priv->rx_mask    =  0xFFFFFFFF;
> 
> Yea:) Please include them in v3.
Ok.
