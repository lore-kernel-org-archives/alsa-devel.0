From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tas5086: fix
 TAS5086_CLOCK_CONTROL register size
Date: Fri, 28 Jun 2013 12:16:03 +0100
Message-ID: <20130628111603.GE27646@sirena.org.uk>
References: <1372363151-31082-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008917554135021001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9093C261670
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 13:16:06 +0200 (CEST)
In-Reply-To: <1372363151-31082-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2008917554135021001==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d/z4umqiXmNgwtKu"
Content-Disposition: inline


--d/z4umqiXmNgwtKu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2013 at 09:59:10PM +0200, Daniel Mack wrote:
> The TAS5086_CLOCK_CONTROL also has a size of 1 byte.

Applied both, thanks.

--d/z4umqiXmNgwtKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzXBvAAoJELSic+t+oim9ce4QAJ11B914MfJvsBZGFOdnwhov
YGhXvAuNU5z8vTJGx6WUbNMwMg8YL/zzjittnWicaOhKFIGEvTk4R1hnx/3l8FKX
14cgQvqsI4jThfneEQwAIaztsZBL4WHHlDpVFQvDzVpRmDIMpkAw/Ys6Oh0T7aLP
CEyjCyFjYYDMW4ptMuLPTkdoGC8AjfkMlSbN/d4dkehPCJXTTgxkfscsMgUeojc/
BOcYCPqTB/41Nd9WRjn63lbXmZdmqMV2ei3CqU4NXbsFQ4Dhx5qOUvawozDg1JZN
2Ytg64p8KPaRIFS3PQG1Yhn0J1p5BiGEUP7F9Kjj349kJoilBhLCR1tAoA0mMBzP
a0Q1yD3r9bHzxocjmkdwYrL5/aeXwwxOcID7oKTcf8vzRp7lFYk256Tx+zMUbn+Y
e0Z44AVYNJtkGQQbFBE6+Ofsnxw3lQyR6GALDZ+JW3Z7SXnKt2yPYFRRrpzqvy1F
OUOkR4MJ96VQS/RkSsgPQdybAjvj8Rv24n4UMZimKjcMUMoB3GUJnUw+yt2BSYi0
kcGSze3Py68UtFoi/+Ko4EoBJv12gknn3Ot9FMB58V1NwEd99nFLDFvBDOL62Sl3
sOEalu/J+Wu8PpAQ+riEfthwmlzwagogvCzbAjDk75hppIucxIola3sTzwwYJVz3
BY42qs3FYCP5+N6NsVn/
=vohO
-----END PGP SIGNATURE-----

--d/z4umqiXmNgwtKu--

--===============2008917554135021001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2008917554135021001==--
