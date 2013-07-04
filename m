From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: add ak4554 driver
Date: Thu, 4 Jul 2013 11:58:36 +0100
Message-ID: <20130704105836.GX27646@sirena.org.uk>
References: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
 <20130702094202.GZ27646@sirena.org.uk>
 <877gh88ls9.wl%kuninori.morimoto.gx@renesas.com>
 <20130703091844.GD27646@sirena.org.uk>
 <877gh70xma.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6098304074852698337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 957B926179B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 12:58:41 +0200 (CEST)
In-Reply-To: <877gh70xma.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6098304074852698337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gYXIgL6/MA84ylAn"
Content-Disposition: inline


--gYXIgL6/MA84ylAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 09:15:13PM -0700, Kuninori Morimoto wrote:
> ak4554 is very simple DA/AD converter which has no setting register.
> Note that it has hard coded asymmetric data format
> playback : SND_SOC_DAIFMT_RIGHT_J
> capture  : SND_SOC_DAIFMT_LEFT_J
> This driver has single DAI and doesn't have set_fmt.

Applied, thanks.

--gYXIgL6/MA84ylAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1VVZAAoJELSic+t+oim9yGcP/1YjK+edG3kC4UNlyk2+E+2D
u+puQSqykmk1TfKf72OhKJ97e5EnYEUOC5nEAWTxXjDwPYz0mwu7jF4+mpLlwy2R
99EsGHRutcfzf+tFk9ENNdPFOWVoyG5kpqQhfl3eIJsQuXcD24LW2vT8rJ2/UeBN
b1OZXUCgyhYKhqeoQUgcJpnXUAbqhmki1GdVu49gl9T7kKbz48eE1KeSxzyP/70H
Jv25WYMpKohYob5Xg3nVRC4WdfMZcFsLt8DTkB48NPiCmjKF8IcH947ixaaQ3jJn
qjO/yuQbywN7WfHdqHbC/Y9YJqx7pVIPNRYTJdVEcPOXbi/MmhPfxtVFIGhHPAev
rvHshV0QQfOoxzDjMAiK5vue0NU6N/c9aVf2jeot+sMM+gJdvMjXA+DrE1JPjl0/
/AVuTJ4bxfMSm3xCVwqneJqWYNYZtuGQvxP3G+NLacLY34RQs92U/UEmJOQFuRkx
1pVcDWfNOI/1r/SKbNwl+FvH9zAo2TKChKYQV7YXZ5vdZw4icKuifHU7JRnM7S3Z
86D/O5Nb2abQ4+NSSG0LEKp+WRH7h9P81irERIpo0JVcACpA1k7WdlIzVhHnhgu0
sCCkuwdFPBWgy8UALXJ1vJk37sKeeMfdZZi0FBxf1r9VnAYIQa0t+T6NT1ClFioz
QNbKM8tLENqLhWcKTQRl
=HymY
-----END PGP SIGNATURE-----

--gYXIgL6/MA84ylAn--

--===============6098304074852698337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6098304074852698337==--
