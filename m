From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: sgtl5000: add delay before first
	I2C access
Date: Tue, 3 Feb 2015 13:09:50 +0000
Message-ID: <20150203130950.GL21293@sirena.org.uk>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
 <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1723692012179911350=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B476260415
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 14:10:01 +0100 (CET)
In-Reply-To: <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: tiwai@suse.de, fabio.estevam@freescale.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1723692012179911350==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfc5LiPmc6BL+hTl"
Content-Disposition: inline


--sfc5LiPmc6BL+hTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2015 at 02:07:55PM -0700, Eric Nelson wrote:
> To quote from section 1.3.1 of the data sheet:
> 	The SGTL5000 has an internal reset that is deasserted
> 	8 SYS_MCLK cycles after all power rails have been brought
> 	up. After this time, communication can start

Applied, though given the normal speeds of I2C I'm always a bit
suspicous that something like this that's messing around with
microsecond delays is actually masking something else.

--sfc5LiPmc6BL+hTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0MieAAoJECTWi3JdVIfQ0fkH/3WA1MVUsRsOmoIGGzMheJcF
1XA3XxaOYjN00aBV4GaovlSXB1ZjEew/UvlJRv9nd9xApJYxVwptyelKulRnw86W
oI/zCac4KetqynRRXZdiEifRYcNWssk5PrR4fMgMFlr47d83nfKocaRJdQFr6Ruu
82pEr8uSbfx/4iYMBXKVPLBAmiW+oHEle5h0IIFBthlyGJCz4MTNaoJVLUciltTY
JDvHTcdWRqL7Xwf26Ih76o29xB02Ixrg83HIfSPemc8XfZ3vZ3/5h04Eq0j1AD3w
eDpyuKAsSSLKM7bGBhXdLMB5jdcI7V29QSG+Uo083rm6MmI2vrcu8/P4iTIuYvE=
=J1VW
-----END PGP SIGNATURE-----

--sfc5LiPmc6BL+hTl--

--===============1723692012179911350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1723692012179911350==--
