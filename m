From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8996: Replace
 codec->control_data with wm8996->regmap
Date: Tue, 25 Feb 2014 13:35:30 +0900
Message-ID: <20140225043530.GT25940@sirena.org.uk>
References: <1393090325-10712-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5755910141332472173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E224265488
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:35:34 +0100 (CET)
In-Reply-To: <1393090325-10712-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5755910141332472173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SfbEdRFDbkyOr6z4"
Content-Disposition: inline


--SfbEdRFDbkyOr6z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:32:04PM +0100, Lars-Peter Clausen wrote:
> With the ongoing component-ization of the ASoC framework and the continuing
> migration to using regmap for IO the control_data field of the snd_soc_codec
> struct will eventually be removed. Prepare the wm8996 driver for this by using
> wm8996->regmap instead of accessing the CODEC's control_data field.

Applied, thanks.

--SfbEdRFDbkyOr6z4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB2OAAoJELSic+t+oim982MP/iYmQJSB8qqr1yejjQjC8BYf
2xwWLxm7XkIR6KeA4mJ/7cb2Qd0EWeRQuy6odwexl4LhCOq+AnmbImiRJJp1e1Js
CtKT08hHqdkUg8aVonnGPTbISPqTc0gu0y5Ax4aTwgkTYZ6RYo9vn7lEiXZ55+mP
FQa3sSR3aRsjh+DkhFX/57WyC2v1dPolwh7qpzMb2DCwibwlFvszxnDz/ZpHiYbA
kP4X/TBNJflN5YPszhnZFgLRnKdFuEkGZypLf+dqHd5R74P09tZuVDr1x5KIEkQw
CgmpY18KeOdx6XJCEEs+kAoO49FzUxrx7CcFzvAmtBjN+R3kIPXP9cFlkXMm+qOw
rMv/A8Qg5IOk1ZKAGekIcOxMB0dIRAbaT50oF7ifi9Hj92laLMwo/nPBE4IpIxFY
NHQ6PEKEoN4/d8M9M6/TLBXyPL/uUtIrV3bOnH+TppYj6zexKXH0KO21KZVE4fSl
/vqo5QycH5Ldh/BI5pvZ2wyT1OmkW1JUoTGj7kCGualErlikbuoKFLsZYnMFaVAD
EIZUOt3d/gvGTzwpJLkHv1F6GbB0rMbpOO9ppE6gSEyOtYWdhV5FMl6w0lwYPtWx
9UD9q58RkEadXeRdKYKiqRTsEVdjK4uBDRze6UIGS91hO/UHyAlLyAi4m9HaZ49V
FAEUdY7cor7oR69I6dOq
=DyQv
-----END PGP SIGNATURE-----

--SfbEdRFDbkyOr6z4--

--===============5755910141332472173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5755910141332472173==--
