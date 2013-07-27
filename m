From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT
	bindings
Date: Sat, 27 Jul 2013 15:21:21 +0100
Message-ID: <20130727142121.GI9858@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
 <20130727115950.GF9858@sirena.org.uk>
 <20130727134452.GF16871@s25.your-server.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6683573185085360555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7DA26072A
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 16:21:33 +0200 (CEST)
In-Reply-To: <20130727134452.GF16871@s25.your-server.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6683573185085360555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMeYSPNN/8081OSC"
Content-Disposition: inline


--lMeYSPNN/8081OSC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2013 at 03:44:52PM +0200, Markus Pargmann wrote:
> On Sat, Jul 27, 2013 at 12:59:50PM +0100, Mark Brown wrote:

> > AC'97 is an enumerable bus, we shouldn't need this...

> What do you mean exactly? Is there a way to automaticaly discover
> connected codecs and register them?

Yes, of coure - just read the ID registers.  Look at how the non-ASoC
AC'97 code works.

--lMeYSPNN/8081OSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR89ddAAoJELSic+t+oim9OJEQAJv+I65+NrGS5WtwIP9aHKIS
uKWzLgMqhECBkrvnyxl2hmzjrceQwfya6H5Yjh70uuQkahP+8RjzbFtpYwMXX81L
CaU0kt44g8ed7OEpnomJEV9G+h2e69gF0LyiUEJsPjpYnUs+liS3ol6lsyopqy/W
mk8zdzTa4tgeqnoht0/6PNmccVLJQco98s9IYKq4KIOvt/ajg76ykZ9/PztlEBWK
tJldBKvT4iiUwfklFNYicKGqog0wTX7G2Jbzkb2Gts/d+WOzqMiapGWXa0/+w9vT
H/MbYymDOV7GoHJzy3ddkr2z6nKgCG/Fn8Su8m8NigxsChkebJNKfCagDCbvkQ89
tiNDPx1ZZIrp4UfljzN3iROCRTSULThJzlbrZnYXmOiX7bKfhEmyzwkWG4w0PKyp
2zNW2mSzFi+mMV2uvzAgbA4FjFGqqY38fBbGmrX4ckIkk40M6Xw7CyS2E+m4qxEK
iyz1+SA1NTLAiTwqNkDQWo2JJX1NTFdp+fmObUn0yJBzQ2BHlODleEiHyYDzSt0f
ocC09WxKaZCpLaZdTmPtuvQ8zTsMXyioJLBhwJ2tF250n5k0Q9MIUCSNFAumDG+9
UyKSFjcMAJHkC22vlu+aBeF9/If6GJlf+diLyB/raa4UBm3crVbHskxgkwPBldMK
NIIh7iW93qjKzUVvCOag
=ylTF
-----END PGP SIGNATURE-----

--lMeYSPNN/8081OSC--

--===============6683573185085360555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6683573185085360555==--
