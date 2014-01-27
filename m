From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: tda998x: adjust the audio hw parameters from
 EDID
Date: Mon, 27 Jan 2014 20:54:37 +0000
Message-ID: <20140127205437.GC11841@sirena.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
 <20140127204441.GZ11841@sirena.org.uk>
 <20140127204915.GC15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R4k76f8oNWH5pGim"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140127204915.GC15937@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
List-Id: alsa-devel@alsa-project.org


--R4k76f8oNWH5pGim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 08:49:15PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 27, 2014 at 08:44:41PM +0000, Mark Brown wrote:

> > Can this parsing code be factored out - it (or large parts of it) should
> > be usable by other HDMI devices shouldn't it?

> Yes, preferably as a generic ALSA helper rather than an ASoC helper -
> I don't see any need for this to be ASoC specific (I have a pure ALSA
> driver which has very similar code in it.)

Indeed, definitely ALSA generic - ideally we could factor a lot of the
integration with the video side out.

--R4k76f8oNWH5pGim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5seKAAoJELSic+t+oim9C8IP/04prbC9qucCblOEYW5TSoX1
q+pRcO0hrA7XLuD3VoJH1XGnIGUC41G/ApPtYjIg6nfzOjQV6g3eetMHiaU7YpX3
fiTYTFxz0aOeDO+xOy56YqgXcKX1JduEd0eX/p8BJPkASIcb/Mr9WSK2zUKFLpXD
O5FgHKN+HNaTR9s61j42DhT4qntWotJVjq3hso59Mm3ykMA50M2eVO58zmc4nsse
MwlTCdW0Vu1SiXU7VU0OapStZ0AWgggWPDPECfpwJZfLU4uLtPaUWAK/3CNmbVOF
m/0PeH2SZnHbooHUM4whSKJhTo4es9PpIbwUbrYLGqp8aM5eE2DNB2bWQ0qCayCI
CVrhWtre6Abr+yye9i+EAxDlVybJus3IohRtLA0kfivgNkPD4bbj9+yRdCehcbVF
EYX60ViW/O+9FOK/GFvA7FnoYBGHJUdlttEHPXNQYQfyTy/TPv1LF/x3ZlREi7Wc
LYQmLj43RRozr4H5VpDTbogylgDZE09tt42o94U787F+pGdCqxam4JO7ZRibIO+i
R5b8WDcp2TQWvNXqrv977/Imk7kM1myKco677oi4PJFRlWpHQ74ggm3E4AwTIaqh
27S/oWhlD+wYwkVZDhp0dOpeks3B9xIAT4x3XittHmvHOxDMKPXRDSrdZWa0iszE
uHyqm/ojCOc/nRzf/v4+
=JGqi
-----END PGP SIGNATURE-----

--R4k76f8oNWH5pGim--
