From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/102 - chunk#5] Add
	SOC_ENUM_SINGLE_CONST() & co
Date: Wed, 19 Feb 2014 10:43:13 +0900
Message-ID: <20140219014313.GJ2669@sirena.org.uk>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2691840751928845116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B7E292652C4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 02:43:31 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2691840751928845116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GN/IAAAoV4GJoJGS"
Content-Disposition: inline


--GN/IAAAoV4GJoJGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:51:27PM +0100, Takashi Iwai wrote:
> This is the last chunk of patch series, which introduces two new
> macros, SOC_ENUM_SINGLE_CONST() and SOC_ENUM_DOUBLE_CONST() in order
> to simplify the codes without ARRAY_SIZE() in the caller side.

Please don't send multiple hundred patch serieses at once via e-mail -
it's very painful to work with long serieses at the best of times and
having several of them at once magnifies the problem and causes problems
with other traffic.  Please at least try to split things over multiple
days, and for something like this one looking at the new macros first
would have been good.  I've not actually got everything downloaded yet,
will look when I do.

--GN/IAAAoV4GJoJGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBAwpAAoJELSic+t+oim9408QAJrw6m/ihEqU7iPiLFWwX7B7
H/pRawrxZEv62O2AiniAdNGckG8HTzlXM/NyKeGtCuIi9Q6+GwYG+/b0kIZLZ1nP
ZNh6OQqlh1VTexUfei4gG/aupg9OAgiTROQbC5PGev/7vro0Sg2CyA7u2dw9o6ve
QzW4hoqMI8VuYu5Dvklzd/WR9oDKa3jPR2A2TWQKtqAIljYf1z0DaMy6PyIzjCpR
C0uLKaN719L3DmuBqj1hleJlPn0+tGO5AprVV5BHY7GYWTn3dAXvb3eEbJYsTC5H
o0ag6KXJ30mQekM6fTIlZ6isq29OjcDngitSSkkSImjXaLvbwUVnBeIAK8VSm8e+
NHYdWhcJyyssJjxE+plz5M8xKJ9ptsYJPDT374RYVA04kk2QS1/gRAOePARH4fii
zZmazzgsQFqnuBE2ySZ+QkCfE179CUNr0yEacTR3MgXsdAjbI9GyNx7m9AbpeL9f
o02IRsvHo5sOSPM2B3srd5zAGk/dvoYAsJ/wabEp+xRY08j7o7/5Rkwtsg1P3nRZ
PTjsCuFHoV5AzZK3eg/2pvO2Q6shhop6ck6t7Ei2dvb5+j+rTZ0RZsrbhFk2033/
bSs3wkl/+Jl8avfhfhhzcQhvx5YNQDKvyAtuS0MrhOEV5CFj2IErnwatxFyXehC2
aHwCC+h/9YDw8+GzP6Eu
=TLfm
-----END PGP SIGNATURE-----

--GN/IAAAoV4GJoJGS--

--===============2691840751928845116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2691840751928845116==--
