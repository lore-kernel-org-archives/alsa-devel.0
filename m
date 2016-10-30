From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Sun, 30 Oct 2016 07:16:26 +0100
Message-ID: <20161030071626.8d67fd9febfd355620a58c4d@free.fr>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
	<3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
	<20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
	<20161004165553.GS5228@lukather>
	<20161023183107.5b75b6aad62853378713299f@free.fr>
	<20161027175154.v4kuhyvm3r5n6tdo@lukather>
	<CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
Reply-To: moinejf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBSNA23AAKGQELVH5UYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TasMV2rI37PzA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, 30 Oct 2016 10:06:20 +0800
Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:

> >> Yes, I know that the burst size is always a power of 2.
> >> The best way to check it would be to change the {src,dts}_maxburst to =
a
> >> bitmap of the possible bursts as 0x0d for 1,4 and 8 bytes. But this
> >> asks for a lot of changes...
> >
> > To be honest, I'm not really a big fan of those tree wide changes
> > without any way to maintain compatibility. It ends up in a single,
> > huge patch if we want to maintain bisectability that just isn't
> > reviewable.
>=20
> Looking at the dmaengine API, I believe we got it wrong.
>=20
> max_burst in dma_slave_config denotes the largest amount of data
> a single transfer should be, as described in dmaengine.h:
>=20
>  * @src_maxburst: the maximum number of words (note: words, as in
>  * units of the src_addr_width member, not bytes) that can be sent
>  * in one burst to the device. Typically something like half the
>  * FIFO depth on I/O peripherals so you don't overflow it. This
>  * may or may not be applicable on memory sources.
>  * @dst_maxburst: same as src_maxburst but for destination target
>  * mutatis mutandis.
>=20
> The DMA engine driver should be free to select whatever burst size
> that doesn't exceed this. So for max_burst =3D 4, the driver can select
> burst =3D 4 for controllers that do support it, or burst =3D 1 for those
> that don't, and do more bursts.
>=20
> This also means we can increase max_burst for the audio codec, as
> the FIFO is 64 samples deep for stereo, or 128 samples for mono.
>=20
>=20
> If we agree on the above I can send some patches for this.

That's fine to me, but this does not solve the main problem which is
how/where are defined the possible bursts of a SoC.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
