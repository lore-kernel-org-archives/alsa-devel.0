From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 4 Jun 2013 10:53:53 +0100
Message-ID: <20130604095353.GZ31367@sirena.org.uk>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
 <20130603153542.GM31367@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB8A89699532@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1303722138679729288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B3A2650CC
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 11:53:57 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB8A89699532@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1303722138679729288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MOeiELSuYwpLEKvX"
Content-Disposition: inline


--MOeiELSuYwpLEKvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2013 at 02:39:36PM +0800, Bard Liao wrote:

> Actually, I don't know if I need to call "regcache_cache_only(rt5640->regmap, false);" here.
> We never call "regcache_cache_only(rt5640->regmap, true);" in the codec driver.
> I assume the cache_only flag is default false.
> If yes, I think I can remove "regcache_cache_only(rt5640->regmap, false);" from the code driver.
> If not, I will move it to the beginning of if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) condition.

I'd actually put in code to enable cache only mode when you power off,
that way when the support for the LDO enable GPIO is added it will not
need to be re-added.

--MOeiELSuYwpLEKvX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrbkuAAoJELSic+t+oim9Xe0P/2x+fDhIeUiRhWQasXF7TKSV
uJj58jdWT1g4dzANBImzX0kPmvV6Y/YsfFuDOqr6+gYZHfUAFaFR0adfp8f/HAKg
3bNGoXOQ/RDOfxCYlUY0Fbj5VMskAItLHVY+BuSTcmO0VaBVldQNEgu0PuB76r48
7zEO7KcvBlcBnxImYU30VS3FFYM7yZvZK5jXXehcKmGu5NvRJu87l76xUR3Cp+qy
/KuoVnPK+K+TBEWBE8X9fvNAJx5rG31Q64YJXyf2dauccO0x9h4tomUUo73+x4rO
Swn54JenX1Yp9scd3k0bNqcfk67J7KZwU+QRtd2js+togRXiVoHTKGrvyrFuRqpF
H6b5BijS2NVVF+KR77BtR5DNtkC0j+VshnEJ6waJP/aLyXZhZaVstQIgp6lM7kK4
9EnlBtQgfVsPou/AiyXVxSw4Yzr3J5ipAer1XjZpM+KpFyXS/TNBCpvyf/+iavyJ
ln05/qF+TA4gR8ztq1C87RyaSXVdNUBtnSNr1FyCSGVSEmtyZGGZAT4h4OaEZqiN
jRzS7H676EjahJchygnfmyOUBWzfAWqwyTvLbQ1wrj8ezt99DhgU7A/68rhESLyF
wvxu6qpW13oDJ5h5XRTz8VxS6oZHxPLTFGNuF/4gQxW5E/ayTyjFIhCx2G5J8Btl
ilCz6cZtUMxZmrvifLyh
=7P31
-----END PGP SIGNATURE-----

--MOeiELSuYwpLEKvX--

--===============1303722138679729288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1303722138679729288==--
