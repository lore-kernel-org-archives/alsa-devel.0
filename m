From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Wed, 31 Jul 2019 14:29:53 +0200
Message-ID: <20190731122953.2u3iabd6gkn7jv7k@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <CAP03XepJVPge5sz4WcmK8pp2jHAPJdGb6v6A3R0DzSf5O6qj-g@mail.gmail.com>
 <CAEKpxBmxAQKgDhvjpczAWwNtNhYRs07wjMSnr8nqHk1XxMT=nw@mail.gmail.com>
 <2092329.vleAuWJ0xl@jernej-laptop>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBRETQ3VAKGQE5LN2HDA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <2092329.vleAuWJ0xl@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Christopher Obbard <chris-ljUBoSVpJTpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 07:57:10PM +0200, Jernej =C5=A0krabec wrote:
> Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a):
> > On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris-ljUBoSVpJTpWk0Htik3J/w@public.gmane.org> wr=
ote:
> > > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> > > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard <maxime.ripard@bootlin.c=
om>
> wrote:
> > > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wr=
ote:
> > > > > > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > >
> > > > > > The i2s block supports multi-lane i2s output however this
> > > > > > functionality
> > > > > > is only possible in earlier SoCs where the pins are exposed and=
 for
> > > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > >
> > > > > > To enable this functionality, an optional property has been add=
ed to
> > > > > > the bindings.
> > > > > >
> > > > > > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > >
> > > > > I'd like to have Mark's input on this, but I'm really worried abo=
ut
> > > > > the interaction with the proper TDM support.
> > > > >
> > > > > Our fundamental issue is that the controller can have up to 8
> > > > > channels, but either on 4 lines (instead of 1), or 8 channels on =
1
> > > > > (like proper TDM) (or any combination between the two, but that s=
hould
> > > > > be pretty rare).
> > > >
> > > > I understand...maybe the TDM needs to be extended to support this t=
o
> > > > consider channel mapping and multiple transfer lines. I was thinkin=
g
> > > > about the later when someone was requesting support on IIRC a while
> > > > ago, I thought masking might of been a solution. These can wait as =
the
> > > > only consumer at the moment is LibreELEC and we can patch it there.
> > >
> > > Hi Marcus,
> > >
> > > FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> > > transfer lines which are called serializers.
> > > Maybe this can help with inspiration?
> > > see
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/s
> > > ound/soc/ti/davinci-mcasp.c sample DTS:
> > >
> > > &mcasp0 {
> > >
> > >     #sound-dai-cells =3D <0>;
> > >     status =3D "okay";
> > >     pinctrl-names =3D "default";
> > >     pinctrl-0 =3D <&mcasp0_pins>;
> > >
> > >     op-mode =3D <0>;
> > >     tdm-slots =3D <8>;
> > >     serial-dir =3D <
> > >
> > >         2 0 1 0
> > >         0 0 0 0
> > >         0 0 0 0
> > >         0 0 0 0
> > >     >
> > >     >;
> > >
> > >     tx-num-evt =3D <1>;
> > >     rx-num-evt =3D <1>;
> > >
> > > };
> > >
> > > Cheers!
> >
> > Thanks, this looks good.
>
> I would really like to see this issue resolved, because HDMI audio suppor=
t in
> mainline Linux for those SoCs is long overdue.
>
> However, there is a possibility to still add HDMI audio suport (stereo on=
ly)
> even if this issue is not completely solved. If we agree that configurati=
on of
> channels would be solved with additional property as Christopher suggeste=
d,
> support for >2 channels can be left for a later time when support for tha=
t
> property would be implemented. Currently, stereo HDMI audio support can b=
e
> added with a few patches.
>
> I think all I2S cores are really the same, no matter if internally connec=
ted
> to HDMI controller or routed to pins, so it would make sense to use same
> compatible for all of them. It's just that those I2S cores which are rout=
ed to
> pins can use only one lane and >2 channels can be used only in TDM mode o=
f
> operation, if I understand this correctly.
>
> New property would have to be optional, so it's omission would result in =
same
> channel configuration as it is already present, to preserve compatibility=
 with
> old device trees. And this mode is already sufficient for stereo HDMI aud=
io
> support.

Yeah, it looks like a good plan.

> Side note: HDMI audio with current sun4i-i2s driver has a delay (about a
> second), supposedly because DW HDMI controller automatically generates CT=
S
> value based on I2S clock (auto CTS value generation is enabled per Design=
Ware
> recomendation for DW HDMI I2S interface).

Is that a constant delay during the audio playback, or only at startup?

> I2S driver from BSP Linux solves that by having I2S clock output
> enabled all the time. Should this be flagged with some additional
> property in DT?

I'd say that if the codec has that requirement, then it should be
between the codec and the DAI, the DT doesn't really have anything to
do with this.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20190731122953.2u3iabd6gkn7jv7k%40flea.
