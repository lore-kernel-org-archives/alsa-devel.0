From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Move core_ena to be
 co-located with start bit
Date: Tue, 18 Nov 2014 17:27:11 +0000
Message-ID: <20141118172711.GU22111@sirena.org.uk>
References: <1416327927-8559-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9203703401588413212=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C72C626047F
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 18:27:23 +0100 (CET)
In-Reply-To: <1416327927-8559-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9203703401588413212==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fxBYc4U7HLIDBZ2G"
Content-Disposition: inline


--fxBYc4U7HLIDBZ2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2014 at 04:25:27PM +0000, Charles Keepax wrote:
> Many firmwares do not wait for the start bit before they begin
> processing audio, whilst this is a bug on the firmware side there are

Applied, thanks.

--fxBYc4U7HLIDBZ2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa4FuAAoJECTWi3JdVIfQe7QIAIX2mE+tijUT+JCFZRAKS1UD
RELUPqNrGCjzT1z2uKgRU3EIhAFAJ3ileNmzFi8Q+/Reg1yEEvq/bRSgglnV46SU
OYdSRZ0MNwFeR47GtJRUDSEvzZvsh6OcNrH8e6cB0pNPdtA3v9DqjLVTnKJJdh+g
6My7BhzrEMsepX1jMqcPze7OIDdLazAXtilVX8Ynh9Qst1wcvQZnV5KHuAg3zDuR
r+xLfWMX82mzeWXNoVzqhVTlEYH49LMhl7SKMv2Ysh7arxuE0CDfrdkzKyA1Hjpz
yQJzWl5voosyFyPtt8ZKcOcUYkgtEFiI4BW/6iLaXLMtOznzSxTh8oNVawseum0=
=2OpD
-----END PGP SIGNATURE-----

--fxBYc4U7HLIDBZ2G--

--===============9203703401588413212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9203703401588413212==--
