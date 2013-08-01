From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Fix kcontrol path list
	corruption
Date: Thu, 1 Aug 2013 14:34:03 +0100
Message-ID: <20130801133403.GR9858@sirena.org.uk>
References: <1375358887-9160-1-git-send-email-lars@metafoo.de>
 <1375358887-9160-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9080372883419775781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 598F126030E
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 15:34:15 +0200 (CEST)
In-Reply-To: <1375358887-9160-2-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============9080372883419775781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6QLs9dyyyh9K+Tsl"
Content-Disposition: inline


--6QLs9dyyyh9K+Tsl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2013 at 02:08:07PM +0200, Lars-Peter Clausen wrote:
> When calling krealloc for the kcontrol data the items in the path list th=
at
> point back to the head of the list will now point to freed memory, which =
causes
> the list to become corrupted. To fix this, instead of resizing the whole =
data
> struct, only resize the widget list.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> This is a slightly different version from what I posted before. It should=
 still
> work but it would be good if somebody could test it.

Nope, it's still failing for me on top of -next I'm afraid.

--6QLs9dyyyh9K+Tsl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+mPHAAoJELSic+t+oim93JYP/jw7PEPHPdlXKYERTkqI15UH
x6BdZeBf3zNY/fVfVxJWfR5bknjp6+PAAX9m+LK9WWXoTrd9RxoIm+wB764ub824
jQXJjulN7Nqxoup7ChjH2ZHIitZOkXplCeV7zI8ItykTl4PqqJLEg5VOuNuEYn+s
ZJIP0CPojDzUCh5lUJJcwpG7JDenbTmaNJMroofQPLi+lcont3GmxmhlHZxGUcRV
SgQdXP7uQM1XOM6AEo/u495nmMePmEJBYzRH+mFIzaFhe9E2re1BjQCZ+h28C+30
WIYlxBrlFQA8iWA9UrT6AwLFpYjP4qK2QxZpOKhjDAn8w9HL/dAPoNdwImLYMEbG
jiulAl18hMJR83xBoydxlrzlvFjMpiaY8dHYVx8UN2U1aNjdzRd5b+qvaA13pmPZ
hwSphTO0LQ0pjj08dtjGBViNqICk8F98lKnHqmugGJ8kbBa3/KI4YpdVYuBL2y0p
EsnTBGMbXJzemWNi1cMNLYrkUZHBkFawuJqQoyBYEygh2QCo9lMRuuyBGsJNjFWL
pJqi63URx73q1+q/UKVuUcf8Q43NjlanwxMijpEZUeAesKzUIiCPLI/OyVUmN5yR
huTmwaj+uVYsG/fhl3Klk45l61RPtt9NBh+FCQftwZ/9iqGA5ppon32ohnzvxK6u
OK7H1i91sJ5ql3Kq3uYO
=dTfY
-----END PGP SIGNATURE-----

--6QLs9dyyyh9K+Tsl--

--===============9080372883419775781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9080372883419775781==--
