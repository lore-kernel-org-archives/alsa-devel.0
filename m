From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 16:33:42 +0100
Message-ID: <20140811153342.GE17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2415253007756071506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 41135260320
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 17:34:00 +0200 (CEST)
In-Reply-To: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============2415253007756071506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3gP9iE9W/ycoRsk"
Content-Disposition: inline


--i3gP9iE9W/ycoRsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 09:35:51AM -0400, jonsmirl@gmail.com wrote:

> I have code in the cpu set_hw_params which will switch the sysclk, but
> it never gets to run because the codec set_hw_params() has already
> errored out.

> Shouldn't this order be:
> platform, link, cpu, codec

No, the machine driver runs first so it can do any coordination needed
between the other devices.  Attempting to fiddle about with the ordering
is never going to be robust, someone else will always want a different
ordering at some point.

--i3gP9iE9W/ycoRsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6OJTAAoJELSic+t+oim9RosP/0EBLEMpoD5/O8uYzRs7s4lr
HLXDIkjtbiRxBqQWQ1kL2yo0sW1MLeE9J6OVtvyM3VMQaIEfayDLpmkDsiKddEkp
8fzvtCiMha38DTmsdNIw/1iOcZ/Qrww8Et9SChIrGx0AzxYYCUPpvhmKNt0VdlrJ
v8la4dE2uKh0l5JUkqd4IfEE8ZZ+fK3Q3hz7G8PgaQtjVh4C1oapJWnYtxquXxf5
kiCrnsfIjGgDl6s0kwxFExJ+wtCIYk9L2xSt3qugqG+pArMtUOWU52lxpqzzDolT
S1XouR+RRo9sdl2LPVPlbHQWtNr4qkzwVRgrcJAPciPkieN9cbW3b4mSTDZRVv5A
/GElxDyVhH03ZHF+LsOT+ayxBn8Rpx2WenUHZDRherzrTDm3wJYiRlpEwTFxtSV7
YZNabLNA2KRK4inQF65njjcATYVZ4ij2B4OsJuYJ4AfbAiaCOR68RiDUFWSZcLib
d5uFtqOHDO2ZpvUvEHyy+GcEgI+fUFglv2SU4axllUyeckfmLjOiM+HG9oeul2vb
pHhZufMjbaFxQMRbZWijIOaujvpF2DnOFm+meGmcearbpMj7GtLpUtqjt9fZZwoi
VQMVsRnum9dVo87oe8XaS4TgL6n7sQ4igkWMWVU1bHTZ28KFzgPucw9ZQVpWdO7s
88ysVoQBdTjxCis3BEqQ
=mJJ7
-----END PGP SIGNATURE-----

--i3gP9iE9W/ycoRsk--

--===============2415253007756071506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2415253007756071506==--
