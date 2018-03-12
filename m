From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: AMD: Use single dai for da7219
 playback and capture
Date: Mon, 12 Mar 2018 10:01:18 -0700
Message-ID: <20180312170118.GL2186@sirena.org.uk>
References: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1404401077536281769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 242DE266E43
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 18:01:21 +0100 (CET)
In-Reply-To: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1404401077536281769==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 02:41:22PM +0530, Akshu Agrawal wrote:
> BT I2S is a bi-directional dai, we will use the same
> cpu dai for playback and capture.
>=20
> TEST=3DBuild, apply grunt_mixer_settings:
> iotools mmio_write32 0xfed80e40 0x040c40c0
> iotools mmio_write32 0xfed80e28 0x10000
> aplay -D hw:0,0 -vv <file>
> arecord -D hw:0,0 -f dat -d 5 -vv <file>

These reproduction instructions don't make much sense outside of your
test environment (how is anyone supposed to know what
grunt_mixer_settings is?).  I'm also rather worried about the random
magic numbers you're using with this iowrite tool - what do they do?  It
sounds like this driver might not work at all without some missing
bit...

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmsl0ACgkQJNaLcl1U
h9B/Ngf7BU2XDi1HW8WcGIE6nUu7PWtbTspfczhtRXmgY0jQDO4ex2E7v181hQrK
MNNg10nsWpdm+Musmz5mH70CPy70dpGOWKQWolPsut3qq94qpW9ATKc4Ub3fG6Lk
fZ2qlaNy3PMWO9vic72zRnIHSduNDEEc3oYD+Q/UXEBU25k955Tw/btXnMJaIlyt
nFM6RqGIMeHV5TjOcCN2sZ+q8BkMrkP6kurmOMXQsHw5GWQIlV0AbbiNm694e0GW
qsLUWH4iVv0rkIpMSCzC1p+JweOYvD1jVTdkrh0P4unIAA97EjRzAw/pEYV9NmLm
K5tJO+DC8Zz+uCCzugbO5e5uxIz7Rw==
=0nEt
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--

--===============1404401077536281769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1404401077536281769==--
