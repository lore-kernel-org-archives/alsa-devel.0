From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: qi_lb60: Use GPIO descriptor API
Date: Wed, 23 Apr 2014 12:19:03 +0100
Message-ID: <20140423111903.GQ12304@sirena.org.uk>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7537104676784618410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97FCD261A66
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 13:19:21 +0200 (CEST)
In-Reply-To: <1398199596-23649-5-git-send-email-lars@metafoo.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org


--===============7537104676784618410==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cefKH10kddc8n4c"
Content-Disposition: inline


--6cefKH10kddc8n4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:46:35PM +0200, Lars-Peter Clausen wrote:
> The new GPIO descriptor API is now the preferred way for handling GPIOs. It also
> allows us to separate the platform depended code from the platform independent
> code (Which will make it possible to increase build test coverage of the
> platform independent code).

Applied, thanks.

--6cefKH10kddc8n4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6GkAAoJELSic+t+oim9IGUP/3quTPiKLPFnpEZ1sD/c4sya
TbLPa5OMaWJGFgkUzbNhjyjzYxG2k7PWMpaV9bilPE+IWyX6COnssnnYPimikTtY
6sEAz0Akg0TMvkoBf0GDJCyskV6blb8EEk43NGn+rvDebqCV2jO3rw+vEK2usV1n
QeWZ5HfiFaehwv2RQo7ZC55Ag3hybcWh5Q7SYbgsCpmliMmEvFi6KedPD0HSlQj/
nPfdRAkqLPQph3n2Y+PAPb/47KLkKBODhb1Kwk+NJWR5Qzai5Dmu8aekqw0Vh//i
2BS1Vbzz4v1TZG6ywbAivx5aqj0jZbR9LRypAm1ILIjvxoBfeT4x845yif3viv7D
q5fN7DQdvxCvFpQj/3hY4ffN4lg86KyTApXmwFhTm8/+AX5ZH0DSbOjkbmB3t7S+
sMjGRf8ZErdI3lpvo4vCZSzoVK7T9BLU/IbtBms4BDOoAEG125qgf1higFT9LalS
g6jRJRKevKc88N4WFPOzj6gBEoPHBXzv2J0yHKGVCBKvxIKlc+QhonInS/cpE4O4
hUcmfF4UAvY54ToBxuCc3ejC7OZhLC+FCWXbGq0bhDbl45/ui86JkC7jJ4jlV7uO
038g3OMxWruGJCl8iG3JrXE77DQz2otscB1Zz7Ki2TtlueRTGdktq0l3IK7fRf2y
8ad+GB5igo4+UDMP1BjI
=+TjX
-----END PGP SIGNATURE-----

--6cefKH10kddc8n4c--

--===============7537104676784618410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7537104676784618410==--
