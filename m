From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for
 A31 playback through headphone output
Date: Sun, 6 Nov 2016 19:57:15 +0100
Message-ID: <20161106185715.tlvcakzqay2lamd5@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
 <20161103173602.zchyciwj66zdibc7@lukather>
 <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hupmdhuzwb6qkxbg"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBDH27XAAKGQEWZJT4NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--hupmdhuzwb6qkxbg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Nov 04, 2016 at 09:08:11AM +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 4, 2016 at 1:36 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi,
> >
> > On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
> >> +/* headphone controls */
> >> +static const char * const sun6i_codec_hp_src_enum_text[] = {
> >> +     "DAC", "Mixer",
> >> +};
> >> +
> >> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
> >> +                         sun6i_codec_hp_src_enum_text);
> >> +
> >> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
> >> +     SOC_DAPM_ENUM("Headphone Source Playback Route",
> >> +                   sun6i_codec_hp_src_enum),
> >> +};
> >
> > What is that route exactly? A muxer?
> 
> Yup. The following is part of the widgets list later in the code:
> 
> +       /* Headphone output path */
> +       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> +                        SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),

Oh, right.

You can add my Acked-by on this one and the other patches too.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--hupmdhuzwb6qkxbg--
