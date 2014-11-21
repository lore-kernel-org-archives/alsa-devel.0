From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: adau17x1: Mark DSP parameter
 memory as readable and precious
Date: Fri, 21 Nov 2014 18:18:03 +0000
Message-ID: <20141121181803.GF3815@sirena.org.uk>
References: <1416592432-29132-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5238104682675116305=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E51D265DAB
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:19:23 +0100 (CET)
In-Reply-To: <1416592432-29132-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5238104682675116305==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewiRz7/e1Zp6iMRV"
Content-Disposition: inline


--ewiRz7/e1Zp6iMRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2014 at 06:53:51PM +0100, Lars-Peter Clausen wrote:
> To be able to read back data from the DSP parameter memory the register
> range needs to be marked as readable. At the same time we do not want them
> to e.g. appear in debugfs output so mark them as precious as well.

Applied both, thanks.

--ewiRz7/e1Zp6iMRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4HbAAoJECTWi3JdVIfQpWUH/RS9x7jh0uvZJlVxvE+cSUe0
eq3naECjRFsON7scljpezwJ2P53Ul8ECZc8dkn7qqdg1u29Dk9Wd0AvvOcVXdzn8
QVuS7k2bECGzIsUr5uOEjnXPEyPhzNkqtYV1x2g1F88ZF6IlIm/pmcmEkbdtbIBl
HkLd30Dn0hRI6StGKHcDell/kquWTAOV/NHHuuv5o5TllNsUqG0UFE3Uyxkallw9
e3dGnzLPjWY1Mn/6+6St5OelAfWFBhfweHllaqzhciomiFDlSKTq9ZyJnc/TjdcD
aIu5NKADJirGs1dkAYx8Kpe5C0cAVo6ghxOyTCJ5X7Q0CvhyQ3zUEJHvVaeyHkQ=
=4wrL
-----END PGP SIGNATURE-----

--ewiRz7/e1Zp6iMRV--

--===============5238104682675116305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5238104682675116305==--
