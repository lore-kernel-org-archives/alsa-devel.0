From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/2] ASoC: Add support for the Allwinner A10 codec
Date: Tue, 22 Sep 2015 16:26:57 +0300
Message-ID: <1442928417.6509.12.camel@plaes.org>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBQVOQWYAKGQEEFHNJAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442064384-23379-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-09-12 at 15:26 +0200, Maxime Ripard wrote:
> Hi everyone,
>=20
> This patch set adds the support for what Allwinner calls the codec on
> their SoCs.
>=20
> This codec is actually a combination of a codec and DAI, tied
> together
> in a single memory-mapped IP. It is completely standalone, and
> outputs
> directly the analog signal.
>=20
> While it supports both playback and capture, the capture is not
> implemented in this patch, and will be posted eventually as a
> separate
> one.
>=20
> This set, in order to be functional, has a dependency on the audio
> clocks patch set posted separately. However, it doesn't needs this to
> compile properly, so I guess it can be merged without really caring
> for the merging status of the clock patches.

It works on Gemei G9 tablet which has also extra chip that
automatically switches output over from internal speakers to headphones
when connector is inserted.

Now I noticed some weird things:

When I have all the switches as ON in alsamixer, and I start disabling
them, I get following weird results.

Left Mixer Left - LML
Right Mixer Left - LMR
Right Mixer Right - RMR

Very faint output:
LML - ON
RML - Mute
RMR - ON

Output works fully:
LML - Mute
RML - Mute
RMR - Mute

When I Mute Pre-Amplifier and fiddle any of LML, RML or RMR, the output
stays mute even after setting Pre-Amplifier Mute back on:

1. All switches on
2. Mute pre-amplifier
3. Mute RMR
4. Pre-Amilifier Mute Off
.. Music stays off
5. Toggle Pre-Amplifier twice - output turns on


And also following in dmesg:
sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> H=
eadphone Jack
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> =
Headphone Jack


With following patch to DTS:

+&codec {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0routing =3D "Headphone Jack", "H=
P Left",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0"Headphone Jack", "HP Right";
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
+};

>=20
> Let me know what you think,
> Maxime
>=20
> Emilio L=C3=B3pez (1):
> =C2=A0 ASoC: sunxi: add support for the on-chip codec on early Allwinner
> SoCs
>=20
> Maxime Ripard (1):
> =C2=A0 Documentation: bindings: Add the Allwinner A10 codec bindings
>=20
> =C2=A0.../devicetree/bindings/sound/sun4i-codec.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A033 +
> =C2=A0sound/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0sound/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A01 +
> =C2=A0sound/soc/sunxi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A011 +
> =C2=A0sound/soc/sunxi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> =C2=A0sound/soc/sunxi/sun4i-codec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 720
> +++++++++++++++++++++
> =C2=A06 files changed, 767 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/sound/sun4i-
> codec.txt
> =C2=A0create mode 100644 sound/soc/sunxi/Kconfig
> =C2=A0create mode 100644 sound/soc/sunxi/Makefile
> =C2=A0create mode 100644 sound/soc/sunxi/sun4i-codec.c
>=20
> --=20
> 2.5.1
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
