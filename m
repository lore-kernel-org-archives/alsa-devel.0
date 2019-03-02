From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_asrc: add constraint for the
 asrc of older version
Date: Sat, 2 Mar 2019 05:47:51 +0000
Message-ID: <VI1PR0402MB33929DC859FF2D481877B8C5E3770@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
 <20190301182743.GA6305@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEF9CF8961D
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 06:47:53 +0100 (CET)
In-Reply-To: <20190301182743.GA6305@Asurada-Nvidia.nvidia.com>
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

Hi

> On Fri, Mar 01, 2019 at 08:37:08AM +0000, S.j. Wang wrote:
> > There is constraint for the channel number setting on the
> 
> nit: "a constraint"
> 
> > asrc of older version (e.g. imx35), the channel number should be even,
> > odd number isn't valid.
> 
> > +static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> > +
> > +	/* channel_bits = 3 means older version on imx35*/
> 
> Space between '5' and '*'. And better to make it clear:
> 
> 	/* Odd channel number is not valid for older ASRC (channel_bits==3)
> */
> 
> > +	if (asrc_priv->channel_bits == 3)
> > +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +
> SNDRV_PCM_HW_PARAM_CHANNELS, 2);
> 
> For your next version,
> 
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Ok, thanks, will send v3.

> 
> Cheers
