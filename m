From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: pcm3060: Add control for
	differential output
Date: Mon, 5 Nov 2018 11:20:36 +0000
Message-ID: <20181105112036.GC5365@sirena.org.uk>
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4202083341284698655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 56FEB267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:20:37 +0100 (CET)
In-Reply-To: <20181029085913.17298-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4202083341284698655==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2018 at 09:59:12AM +0100, Kirill Marinushkin wrote:
> DAC may be switched between differential and single-ended output.

Isn't this something that'd be better controlled by DT - it's usually
going to be part of the board design?

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvgJ4MACgkQJNaLcl1U
h9AgSQf/bjb+cz0gVa1FFg7KcrHXXzzQha95LA4kVHTYuxOHaFISIMrY/aaTudvI
4h4TrRlY0tGBiAxzbqt6yZcGmh55K5UDQpAY81QHrkBKrxzEP3SLWzNiDZGrlO2f
3Gokdic9Cf5mZ2tV/z+OZ5MMS/NbVWigb1cVmyQgliewpIN6gcnVy0Gtun3Mverr
q2slTHer+7ye3FA5AK905Fv+F1GysBta14KKbISRV4LhMCJ9C9cO7oqV896nRtnZ
ob4nUggUVFhpu86SlbnXvhqyXabI+tv6MCWFKTYkGgdXBGnH2YpgDAOLk6ch2IqZ
0R2fYqU9GG+NKs+LsDwaWAnmBuHYuQ==
=Cpfl
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============4202083341284698655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4202083341284698655==--
