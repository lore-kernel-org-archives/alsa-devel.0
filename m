From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add jack detection
 workaround for MINIX Z83-4 based devices
Date: Wed, 30 Aug 2017 16:07:40 +0100
Message-ID: <20170830150740.rxqizok6abyiulff@sirena.org.uk>
References: <c98257b6-a5bc-a1b6-5194-cc29b6aec571@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3367017565892503569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2122A266C5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 17:07:42 +0200 (CEST)
In-Reply-To: <c98257b6-a5bc-a1b6-5194-cc29b6aec571@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3367017565892503569==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sje35lktrd2sc5gu"
Content-Disposition: inline


--sje35lktrd2sc5gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 30, 2017 at 04:07:36PM +1000, Ian W MORRISON wrote:
> The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices requires jd_mode=3
> to make the jack detection work. Using a BIOS DMI product of "Z83-4"
> will match both devices of 'NEO Z83-4' and 'Z83-4 Pro'.

This doens't apply against current code, please check and resend.

--sje35lktrd2sc5gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmm1LsACgkQJNaLcl1U
h9B4uQf9FPqQJhDApDE0iNWQ+To+ahTgwupSqdfpbYnF1qXrA+o3ZRy1oLx6p/pf
PkrOD83vzo2Q1MMcHHyssRhLhhj0JOSgCo5HuWsTwJ8k8EqiREVzWigeDNeqW5Fp
NFAkrYbEd5q9BKkEaHE5Y1u/O8eGIj0197gq3CV6kbf0ohrRkSAGdPvwDO+fes18
wLQH+cs3xuFo5BbjrGf+c4lWWFA3ANvcP5DOUTN2DxkI7QujKCtVqATzy+2C8GCc
CJKFDxu0E4Vp2ZOyBVDCBaOZprUnt5Rjux4G0JOvsK4k0FrIK1uTp7mTADf+GKPK
iwMt5Ehj/zGYnyMjjRNcucg4esb0kQ==
=kvKp
-----END PGP SIGNATURE-----

--sje35lktrd2sc5gu--

--===============3367017565892503569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3367017565892503569==--
