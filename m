From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/5] ASoC: Remove
	snd_soc_update_bits_locked()
Date: Tue, 22 Apr 2014 13:25:18 +0100
Message-ID: <20140422122518.GW12304@sirena.org.uk>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2063213645996989634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA4D92625D7
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:25:30 +0200 (CEST)
In-Reply-To: <1398165797-22997-4-git-send-email-lars@metafoo.de>
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


--===============2063213645996989634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kIWVDTJhVd8bNV9f"
Content-Disposition: inline


--kIWVDTJhVd8bNV9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 01:23:15PM +0200, Lars-Peter Clausen wrote:
> There are no users of snd_soc_update_bits_locked() left and it is identical to
> snd_soc_update_bits(). So it can be removed.

Applied, thanks.

--kIWVDTJhVd8bNV9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVl+rAAoJELSic+t+oim9mPsP/jx3rkvw3MqajR1KIvIAG4Kh
jWqq7pwos25+znyNEZY7lF/gpBUGJ6juAopUzqcnzBncrhU4dgRrhJ18n1IIWJp7
JKy2RUaBIVwjPLuUVJTIXF/Yzodx2pfR1uxdcOim9s59l8W4pnJHZFpso9L7NqNT
r6dl6MiYCaI7tnq10jDW2t6r8H3XMaBBPBNJaw9UM+t08KGapCrY4R/q5qwM86Yp
2jtiCz+E7zcsJDVVA5+XlQGEUNI4NbMUOrkwuiCt42EMe+JhwPUE7H1hlMSXfHBW
Fy5s02xsiEKcKvVnAWZ+EviMNmylHBdlu23+vxUuuPhE+AY0ipXEZ1xlb3TRpuyI
uTNDcz3fufi4l1o81HcgArsdshHf92mWPmqhSgy/6O8oN1s60QZa59o8U+k+NKMF
aaCyPHPxVEjAD9Y+wVY75yu+tmKw4UgPq0r1nVrnZhmu+cYPRShUxkZLR+M71EpQ
Hctxx4Tzygt8LR7lMuJXMmXA0TYjDxqfxpGJfjfUz8BR9AeelQHb1jkzGi6wi95B
KBPoWM9s/Jd4CE4FeY6vHwxtXUbTL8zNGvDBKpH/aG26a9bKiXx0HdMn+4Oh9EV1
Yiz40Hkb7NupcZy/Q//VUWLtMFaFOE6ZE7kFVOsJtqN95qsU1fv56ZYbFWpLDgld
ppyZMPFmEDNYnwuyCr97
=KOnG
-----END PGP SIGNATURE-----

--kIWVDTJhVd8bNV9f--

--===============2063213645996989634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2063213645996989634==--
