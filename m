From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Wed, 12 Aug 2015 15:39:00 +0800
Message-ID: <20150812073859.GB21786@shlinux2>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 8835726043E
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 10:49:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150812064053.GA2807@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 11:40:54PM -0700, Nicolin Chen wrote:
> On Wed, Aug 12, 2015 at 12:45:10PM +0800, Zidan Wang wrote:
> 
> > > > +		/*
> > > > +		 * for imx6ul we should set SAI2_MCLK_DIR to enable
> > > > +		 * codec MCLK
> > > > +		 */
> > > > +		if (of_device_is_compatible(np, "fsl,imx6ul-evk-wm8960"))
> > > > +			regmap_update_bits(priv->gpr, 4, 1 << 20, 1 << 20);
> 
> > > What's this SAI2_MCLK_DIR? Can you provide the description of it?
> > SAI2_MCLK_DIR: SD1_CLK data direction control when sai2.MCLK is selected (ALT2)
> > 0 SD1_CLK output driver is disabled when configured for ALT2
> > 1 SD1_CLK output driver is enabled when configured for ALT2
> 
> > We are using SAI2 now, so we should enable SAI2_MCLK_DIR. If we want to
> > use SAI1 and SAI3, we should also enable SAI1_MCLK_DIR and SAI3_MCLK_DIR.
> > I don't consider SAI1 and SAI3 case, should i add it like below:
> 
> Yes. Just think about a general interface/configuration that can
> satisfy all the MCLK cases you can imagine.
> 
> Since it's a clock dealing with SAI, I think it would be better to
> put the configuration inside:
> 
> 494         } else if (strstr(cpu_np->name, "sai")) {
> 495                 priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
> 496                 priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
> 497         }
> 
> And I still don't understand the meaning of this MCLK at all.
> Does it indicate SAI's MCLK or an MCLK for external CODEC chips?
> Will it be possible that a user needs this MCLK bit to be unset?
For imx6ul-evk, MCLK for wm8960 CODEC chips and SAI's MCLK is the same pin.
So it should always be set for SAI.
> 
> Can you share the document to me privately so I can give you a
> suggestion in detail?
> 
> > > > -	priv->dai_link[0].codec_dai_name = codec_dev->name;
> > > > +	if (strstr(codec_dev->name, "wm8960"))
> > > > +		priv->dai_link[0].codec_dai_name = "wm8960-hifi";
> > > > +	else
> > > > +		priv->dai_link[0].codec_dai_name = codec_dev->name;
> 
> > > What happens to the codec_dev->name over here so that you need to
> > > specify the name?
> > In wm8960 codec driver, codec dai name is "wm8960-hifi".
> > Using codec_dev->name will cauce register card failed.
> 
> When we meet a problem, the first response should be to find out
> the route cause instead of fixing it with a work around directly.
> If the codec_dev->name caused a card registration failure, you
> need to find out why. There must be something wrong with its codec
> driver or this sound card driver.
> 
The root cause is that the codec dai name is not always be codec_dev->name. It will cause the sound card can't find such codec dai. You can refer to function snd_soc_find_dai().
For wm8962 the codec dai name and codec_dev->name are "wm8962". But some other codec like wm8960, it may have different codec dai name.

> Nicolin
