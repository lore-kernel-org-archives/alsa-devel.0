From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for bclk_ratio
Date: Tue, 26 Feb 2019 16:21:16 +0000
Message-ID: <20190226162116.GD7082@sirena.org.uk>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
 <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
 <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0207310574=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============0207310574==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 03:45:19PM +0000, Russell King - ARM Linux admin wrote:

> Adding more WS signals makes the bus deviate from the I2S standard,
> thereby making it impossible to connect a set of standard DACs to
> such a source, whereas adding more I2S data lines, you just connect
> each DAC to each I2S data line and common up the bit clock and WS
> signals across all.

> In other words, the TDA998x approach is really the only sane way
> forward.

Right.  You do also see some things doing this by stuffing all the left
samples together in the left clock cycle and all the right samples
together in the right clock cycle but that's usually more programmable
hardware that also supports DSP modes and it's just falling out of the
implementation with little effort rather than someone sitting down and
thinking this is a good idea AFAICT.

> Now, as far as transmitter support, I believe TI Davinci SoCs use
> this - my Onkyo TX-NR609 AV receiver uses a DA830 SoC as a DSP to
> do the surround decode, which feeds multi-channel audio out to a
> set of DACs over a parallel I2S bus.  The "mcasp" audio driver
> has multiple serialisers to cope with this - see
> Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt.

Samsung LSI have multi-channel I2S with multiple data lines in their v5
and later controllers as well.  I can't think of any other examples
upstream off the top of my head.

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1Z3wACgkQJNaLcl1U
h9BZwAf+O5lBTBCcTNtWa5FxNmevC0BIrazw/Sttqj56RdJa4mRnoYRCNyKhCb4v
xs1UE7Fj4nC4Jny4nEMyW6KNpdB9Cy3YpXJb+3b3Yi0/6VMB9C23i2ysbAcGw29W
EzuwxDhyowH/eM/H1CjMijVrqjXVTm9mvu/qAp+IvZhVSFDBD/iiDnA+4I0RrzSw
7JjyzgePsw+zocWewiJkSCyNz4JqJK61zTVIhvIe4lcQ/sXmL4gD2ji32NtnGSDi
6r7eVNUXHSqjb2qa17HIPr9FcRkUhNg6ViQnZugFIx3qnmLnmQCVM0YvFoxyUsuj
irM2dsO+oR8g2ywEUh2EVCylhjWAVQ==
=1Mdv
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

--===============0207310574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0207310574==--
