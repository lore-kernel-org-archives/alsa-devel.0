From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ml26124: Convert to
	devm_regmap_init_i2c
Date: Wed, 13 Jun 2012 17:27:40 +0800
Message-ID: <20120613092740.GE4545@opensource.wolfsonmicro.com>
References: <1339569367.11749.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6699780470116420781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5982244E1
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 11:27:41 +0200 (CEST)
In-Reply-To: <1339569367.11749.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6699780470116420781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2012 at 02:36:07PM +0800, Axel Lin wrote:
> This fixes a leak if snd_soc_register_codec fails.

Applied, thanks.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2F0FAAoJEBus8iNuMP3d49oP/0kdZxZZg/FynIODvNrzNTKM
5Dt1IIXFOntJ/LgITMqrV3TmFnk4wilyuDV3DKvjRe9NiMGMzop/bw0YENphvwhL
84/CNqODx9YTZH2Wz5nujDg1/73JQtD9b39FxC6xPNt9ZP5zV+ibRcrNGZt8sMlQ
W1L2YEG0Q5Ab+CvgZ1903bwdT3YKynb0xHebUpK3EgRSSx91sNZeLprAmwDf/dKK
7UZ04v44hLzB+NEWSdeqyuzDXyW49+mksfA7akP921Lm9o9mQ01oGWS1QqNNFiL7
I/gaciCzCkRr/ZZjo6PSl9I2eIGRhtLwtI1gd/+xqYtWvcyFlOvyQu4zMzw+cd3k
RQTBAQHkMR369VEVulk7POpV0pZNdrNsQCGvM7YMIdyVYHtavSC6HAx7uHZ0S+Zh
k93JonHIq5wLpsMbGgY08qYjH8lNxRhJ3TWg72tn5uZWuZMsp5OdF2Zb2+NRxhOS
xaT1/+efM7A9HX6Swzk7Lmx209kLLccQsY0eWdnYLd93Ob72l/txnkqLuQJ5ivqy
gD0JgVY7lZyp+lNCG/yGnB8adQUQbIvL3vpBcUbLJcZ6MBZP/XqLAo1/b3sd7dpK
Fmy/e31F8IapGMhfw9Urq2Qiyc587UPzrQE2vp/uSe6aLGj6rZSTPj0ZGmnO/5h5
mhUWlJgH5UCUpwFa62Jg
=q5qp
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

--===============6699780470116420781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6699780470116420781==--
