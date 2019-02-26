From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for bclk_ratio
Date: Tue, 26 Feb 2019 16:41:44 +0000
Message-ID: <20190226164144.GE7082@sirena.org.uk>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
 <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
 <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
 <CAGngYiXSNbQbcY1tbnYURWTCu7rJk=L1H+So7kanJmpxkV5bEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2056605564=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAGngYiXSNbQbcY1tbnYURWTCu7rJk=L1H+So7kanJmpxkV5bEQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============2056605564==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 11:31:15AM -0500, Sven Van Asbroeck wrote:

> That's a very good point too. In light of this, I struggle to understand how
> the ssl_ssi can specify this:

> static struct snd_soc_dai_driver fsl_ssi_dai_template = {
>         .playback = {
>                 .stream_name = "CPU-Playback",
>                 .channels_min = 1,
>                 .channels_max = 32,
>         },

> There is talk in the manual about "network mode", which could work by changing
> the LRCLK only at the first slot - thereby allowing clients to receive all
> slots just by counting, as long as they know the slot size?

That's basically what the FSL controllers want to support - they're
generic programmable serial ports, their most native formats are the DSP
modes which only pay attention to one edge of LRCLK and then just have
however many samples one after another.  Several other devices like the
PXA SSP ports are similar.  They can generate I2S style LRCLKs but many
implementations struggle to interpret incoming I2S properly, they often
have issues with triggering on both rising and falling edges so get
confused if there's any unused clock cycles.

For a DSP mode it's more:

LRCLK   /\______________________/\____
DATA    |SLOT1|SLOT2|SLOT3|SLOT4|SLOT1

I2S style it'd end up as more like:

LRCLK   /-------------\_____________/------
DATA    |SLOTL1|SLOTL2|SLOTR1|SLOTR2|SLOTL1

This sort of stuff is why ASoC has a preference for exact clocking - it
improves interoperability with hardware that's generic serial ports as
it means that you only need to pay attention to one edge of the LRCLK
even if it's doing something more than just a simple pulse.

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1bEcACgkQJNaLcl1U
h9BrMQf+PxGNzTusosONDOZ8aeG/BZA6TfOd1oBgpaPluraxpJhF7VwpkSb3Vdq0
KTEq3bqc+aA++lyFHxvsvJVGbCOKPc2Rc9qs7SQKueXV/qyw0jTGtAompB4mH09O
4wuMzfNoriEqXoRZt78NvrTCJ2UZUWG9XL+TGWWCOeAZcgSeKCcHNjU40JzyYzTR
fVWXHA5GifD6pfV3vIDHe83TtQNEv886i5iEGXG5DrDLrhCgUBArWcoKA6fszux6
9Cku7HDmCGL8LBo9XU+rAZahTbILi+05pNSSJrjYxATb2ZN7Xe+U+xKJp2FQCKgM
OF3vIhSl9yAMP31mwAdXP8xnabFuIQ==
=iwoq
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--

--===============2056605564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============2056605564==--
