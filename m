From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Sat, 26 Jun 2010 18:52:26 +0100
Message-ID: <1277574746.3110.35.camel@odin>
References: <1277407467.3100.579.camel@odin>
	<4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
	<661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
	<4C23EC65.9080601@bluewatersys.com> <4C2435DC.5080509@bluewatersys.com>
	<1277455066.3123.10.camel@odin>  <4C252FEF.5060302@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id EF797243AE
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 19:52:34 +0200 (CEST)
Received: by wyf23 with SMTP id 23so663862wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 10:52:34 -0700 (PDT)
In-Reply-To: <4C252FEF.5060302@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, jassisinghbrar <jassisinghbrar@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Cliff Cai <cliff.cai@analog.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-06-26 at 10:38 +1200, Ryan Mallon wrote:
> Liam Girdwood wrote:
> > On Fri, 2010-06-25 at 16:51 +1200, Ryan Mallon wrote:

> >> I don't understand why the tlv320 codec is not being registered. Any ideas?
> >>
> > 
> > Since we now support N codecs, some codecs will now require an ID field
> > to distinguish them from others. e.g. a board with two WM8750 codecs
> > would have codecs at I2C addresses 0x1a and 0x1b, hence will require
> > each codec to be identified on the DAI link.
> > 
> > Can you try this patch below. From the output it looks like your
> > tlv320aic23 is at I2C address 26. 
> > 
> > 
> > diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
> > index aeb822d..72b7913 100644
> > --- a/sound/soc/ep93xx/snappercl15.c
> > +++ b/sound/soc/ep93xx/snappercl15.c
> > @@ -94,6 +94,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
> >         .cpu_dai_drv    = &ep93xx_i2s_dai,
> >         .codec_dai_drv  = &tlv320aic23_dai,
> >         .codec_drv      = &soc_codec_dev_tlv320aic23,
> > +       .codec_id       = 26,
> >         .platform_drv   = &ep93xx_soc_platform,
> >         .init           = snappercl15_tlv320aic23_init,
> >         .ops            = &snappercl15_ops,
> > 
> 
> Ah, that makes sense. I will try the patch on Monday. One thing to note
> is that in arch/arm/mach-ep93xx/snappercl15.c there is  already:
> 
> static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
>         {
>                 /* Audio codec */
>                 I2C_BOARD_INFO("tlv320aic23", 0x1a),
>         },
> };
> 
> Is there a clean way to avoid hard-coding the i2c address of the tlv320
> codec twice? Can I pass -1 to find any available codec? 

Yes, -1 should find any available codec. 

> If not, can you
> change the patch to 0x1a rather than 26, since i2c addresses tend to be
> written in hex.

I've changed to hex and pushed. My preference here is that we keep the
hard coded value atm, as planned changes later on will depend on it. The
future intention for dai_link is to remove the *_drv pointers and just
have the dai_link created from unique IDs. e.g. we will eventually have
something like :-

struct snd_soc_dai_link snappercl15_dai = {
	.cpu_dai_id    = SND_SOC_CPU_DAI(EP93XX, I2S, 0),
	.codec_dai_id  = SND_SOC_CODEC_DAI(TLV320AIC23, 0),
	.codec_id      = SND_SOC_I2C_CODEC(TLV320AIC23, 0, 0x1a),
	.platform_id   = SND_SOC_PLATFORM(EP93XX, 0),
	.init           = snappercl15_tlv320aic23_init,
	.ops            = &snappercl15_ops,
};

Note: this format has not been decided on yet.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
