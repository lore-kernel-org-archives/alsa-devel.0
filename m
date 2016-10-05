From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 07/14] ASoC: Add sun8i audio card
Date: Wed, 5 Oct 2016 12:03:03 +0200
Message-ID: <20161005120303.93eb05294d189e04461bb314@free.fr>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
	<cover.1475569400.git.mylene.josserand@free-electrons.com>
	<33d641ff43f0c0349cdfa2cdbbfdcdde66205596.1475571575.git.mylene.josserand@free-electrons.com>
	<CAEKpxBkUbCGJdToReQx7P+5i92doUdNeMvA5fiDACGcniY=nJg@mail.gmail.com>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBXM72O7QKGQEJSMHRAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAEKpxBkUbCGJdToReQx7P+5i92doUdNeMvA5fiDACGcniY=nJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Oct 2016 08:04:26 +0200
Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > +static int sun8i_probe(struct platform_device *pdev)
> > +{
> > +       struct snd_soc_dai_link *link =3D &sun8i_dai_link;
> > +       struct device_node *np =3D pdev->dev.of_node;
> > +       int ret;
> > +
> > +       /* register the soc card */
> > +       sun8i_card.dev =3D &pdev->dev;
> > +
> > +       /* Retrieve the audio-codec from DT */
> > +       link->codec_of_node =3D of_parse_phandle(np, "allwinner,audio-c=
odec", 0);
> > +       if (!link->codec_of_node) {
> > +               dev_err(&pdev->dev, "Missing audio codec\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Retrieve DAI from DT */
> > +       link->cpu_of_node =3D of_parse_phandle(np, "allwinner,i2s-contr=
oller", 0);
> Now that I've spent some time trying to add my changes for the H3
> ontop of your code,  I think this file should be more generic and rely
> on the dtsi more. It's pretty A33 specific but with little effort it
> can be worked to cover all of the sun8i type drivers. I would change
> "allwinner,i2s-controller" to "allwinner,audio-dai" for starters and
> then maybe pull in some info for the dai-link from the dtsi.
> CK
	[snip]

In fact, there should be no audio card driver as proposed here:
with such a simple layout
	CPU DAI (sun4i-a10-i2s) -> CODEC DAI (sun8i-a33-codec)
the 'simple-card' does the job.

BTW, I have a I2S/PCM/TDM driver for the H3 and A83T.
But, as it works with HDMI and contains echanges with the DRM driver,
it cannot go yet to the mainline...

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
