From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Sun, 30 Oct 2016 10:06:20 +0800
Message-ID: <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr> <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr> <20161027175154.v4kuhyvm3r5n6tdo@lukather>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBONL2XAAKGQEAP3XHEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161027175154.v4kuhyvm3r5n6tdo@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-arm-kernel <linux->
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Oct 28, 2016 at 1:51 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sun, Oct 23, 2016 at 06:31:07PM +0200, Jean-Francois Moine wrote:
>> On Tue, 4 Oct 2016 18:55:54 +0200
>> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>>
>> > On Tue, Oct 04, 2016 at 12:40:11PM +0200, Jean-Francois Moine wrote:
>> > > On Tue,  4 Oct 2016 11:46:14 +0200
>> > > Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > >
>> > > > Add the case of a burst of 4 which is handled by the SoC.
>> > > >
>> > > > Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electr=
ons.com>
>> > > > ---
>> > > >  drivers/dma/sun6i-dma.c | 2 ++
>> > > >  1 file changed, 2 insertions(+)
>> > > >
>> > > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> > > > index 8346199..0485204 100644
>> > > > --- a/drivers/dma/sun6i-dma.c
>> > > > +++ b/drivers/dma/sun6i-dma.c
>> > > > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
>> > > >         switch (maxburst) {
>> > > >         case 1:
>> > > >                 return 0;
>> > > > +       case 4:
>> > > > +               return 1;
>> > > >         case 8:
>> > > >                 return 2;
>> > > >         default:
>> > > > --
>> > > > 2.9.3
>> > >
>> > > This patch has already been rejected by Maxime in the threads
>> > >   http://www.spinics.net/lists/dmaengine/msg08610.html
>> > > and
>> > >   http://www.spinics.net/lists/dmaengine/msg08719.html
>> > >
>> > > I hope you will find the way he wants for this maxburst to be added.
>> >
>> > I was talking about something along these lines (not tested):
>>
>> I wonder why you don't submit this yourself.
>
> I thought you were the one who cared. You asked for what I had in
> mind, here it is.
>
>> > -------8<---------
>> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> > index 83461994e418..573ac4608293 100644
>> > --- a/drivers/dma/sun6i-dma.c
>> > +++ b/drivers/dma/sun6i-dma.c
>> > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
>> >     switch (maxburst) {
>> >     case 1:
>> >             return 0;
>> > +   case 4:
>> > +           return 1;
>> >     case 8:
>> >             return 2;
>> >     default:
>> > @@ -1110,11 +1112,19 @@ static int sun6i_dma_probe(struct platform_dev=
ice *pdev)
>> >     sdc->slave.dst_addr_widths              =3D BIT(DMA_SLAVE_BUSWIDTH=
_1_BYTE) |
>> >                                               BIT(DMA_SLAVE_BUSWIDTH_2=
_BYTES) |
>> >                                               BIT(DMA_SLAVE_BUSWIDTH_4=
_BYTES);
>> > +   sdc->slave.dst_bursts                   =3D BIT(1) | BIT(8);
>> > +   sdc->slave.src_bursts                   =3D BIT(1) | BIT(8);
>> >     sdc->slave.directions                   =3D BIT(DMA_DEV_TO_MEM) |
>> >                                               BIT(DMA_MEM_TO_DEV);
>> >     sdc->slave.residue_granularity          =3D DMA_RESIDUE_GRANULARIT=
Y_BURST;
>> >     sdc->slave.dev =3D &pdev->dev;
>> >
>> > +   if (of_device_is_compatible(pdev->dev.of_node,
>> > +                               "allwinner,sun8i-h3-dma")) {
>> > +           sdc->slave.dst_bursts |=3D BIT(4);
>> > +           sdc->slave.src_bursts |=3D BIT(4);
>> > +   }
>> > +
>> >     sdc->pchans =3D devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels=
,
>> >                                sizeof(struct sun6i_pchan), GFP_KERNEL)=
;
>> >     if (!sdc->pchans)
>> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> > index cc535a478bae..f7bbec24bb58 100644
>> > --- a/include/linux/dmaengine.h
>> > +++ b/include/linux/dmaengine.h
>> > @@ -673,6 +673,8 @@ struct dma_filter {
>> >   *         each type of direction, the dma controller should fill (1 =
<<
>> >   *         <TYPE>) and same should be checked by controller as well
>> >   * @max_burst: max burst capability per-transfer
>> > + * @dst_bursts: bitfield of the available burst sizes for the destina=
tion
>> > + * @src_bursts: bitfield of the available burst sizes for the source
>>
>> You did not define dst_bursts nor src_bursts.
>>
>> >   * @residue_granularity: granularity of the transfer residue reported
>> >   * by tx_status
>> >   * @device_alloc_chan_resources: allocate resources and return the
>> > @@ -800,6 +802,14 @@ struct dma_device {
>> >  static inline int dmaengine_slave_config(struct dma_chan *chan,
>> >                                       struct dma_slave_config *config)
>> >  {
>> > +   if (config->src_maxburst && config->device->src_bursts &&
>> > +       !(BIT(config->src_maxburst) & config->device->src_bursts))
>>
>> The maxburst may be as big as 4Kibytes, then, I am not sure that this
>> code will work!
>>
>> > +           return -EINVAL;
>> > +
>> > +   if (config->dst_maxburst && config->device->dst_bursts &&
>> > +       !(BIT(config->dst_maxburst) & config->device->dst_bursts))
>> > +           return -EINVAL;
>> > +
>> >     if (chan->device->device_config)
>> >             return chan->device->device_config(chan, config);
>> > -------8<------------
>>
>> Yes, I know that the burst size is always a power of 2.
>> The best way to check it would be to change the {src,dts}_maxburst to a
>> bitmap of the possible bursts as 0x0d for 1,4 and 8 bytes. But this
>> asks for a lot of changes...
>
> To be honest, I'm not really a big fan of those tree wide changes
> without any way to maintain compatibility. It ends up in a single,
> huge patch if we want to maintain bisectability that just isn't
> reviewable.

Looking at the dmaengine API, I believe we got it wrong.

max_burst in dma_slave_config denotes the largest amount of data
a single transfer should be, as described in dmaengine.h:

 * @src_maxburst: the maximum number of words (note: words, as in
 * units of the src_addr_width member, not bytes) that can be sent
 * in one burst to the device. Typically something like half the
 * FIFO depth on I/O peripherals so you don't overflow it. This
 * may or may not be applicable on memory sources.
 * @dst_maxburst: same as src_maxburst but for destination target
 * mutatis mutandis.

The DMA engine driver should be free to select whatever burst size
that doesn't exceed this. So for max_burst =3D 4, the driver can select
burst =3D 4 for controllers that do support it, or burst =3D 1 for those
that don't, and do more bursts.

This also means we can increase max_burst for the audio codec, as
the FIFO is 64 samples deep for stereo, or 128 samples for mono.


If we agree on the above I can send some patches for this.


Regards
ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
