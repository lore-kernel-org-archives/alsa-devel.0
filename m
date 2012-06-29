From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Fri, 29 Jun 2012 08:23:18 +0100
Message-ID: <20120629072318.GP28922@opensource.wolfsonmicro.com>
References: <1376117137.2888145.1340052088940.JavaMail.root@advansee.com>
	<s5hobo2bpo5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2939825609679139676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 807A4245B7
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 09:23:20 +0200 (CEST)
In-Reply-To: <s5hobo2bpo5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2939825609679139676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2012 at 08:25:14AM +0200, Takashi Iwai wrote:

> Doesn't this result in the same value of connect?

If nothing else it's a massive readability improvement...  I've pulled
the change over to 3.6 for now, I need to rush out the door right now
and probably won't be able to do anything else for the rest of today.

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7VfRAAoJEBus8iNuMP3dSEwP/RPpPJssfD9RxBeqw24Rxsbc
cTntqVfBY36hDDkAASs6lBsOP1hvByPKirjKl7ZNJOctu48YFa8aGAjwBU7v/fhW
qwfsJAJwFlTBJW+5EXpHESPvpeXIv72FJcLyAETiP170ZAv5SrZKhRuiJiGlpi+0
wssNlpocg15+Qx1Vs619omd6M19+Y4y7QqC/zrmfEIZ/Z7dq3LzIqs5XWK+EyHMc
KCjhDdrINK7H6sirYGlITx/3yTWPu7jbwLBLaAZjybNVQufzq9urPUwf3NDroQxB
6B8LSn6aUTiaLoaC+U5lEyss6pkl7PJGtl3Q9+IX+EJ4IaznC6OaTVQfkbmGlc5O
D/rZv+gdDXyPokQ9qb7M8AH53w1snae9EX+m7rHrG62NahV8sD9QZ5XFv8FKX9WR
FepqW06BEyuvF0NfV6hZmXJWu1Kv3B2ASs+lDkJhDYo5Qyr67qMFDbH1F+UyViFA
1znZSrjTjtiPYu6Ue27mky65byJhns2t15W/Ls78E4Qh3cSqaCCTs3eRjKI50HmE
ibydKrLkbHO2xchHXvOl7N85gJ7YaGRcWHK0PxurPaRRVyYeie5rmp9+ofNFLwmJ
17GEJFP3HaZdwOWuykU53YYUBNCLR2H30uf0SecjM6lOitpYuosQh4n2KkzYWWi6
/Oe/5QLkj5vjdroJ4a6j
=NDiO
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--

--===============2939825609679139676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2939825609679139676==--
