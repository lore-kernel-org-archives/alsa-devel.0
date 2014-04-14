From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: don't skip evaluate the power
 of widget with force set
Date: Mon, 14 Apr 2014 21:36:46 +0100
Message-ID: <20140414203646.GC25182@sirena.org.uk>
References: <1397378240-20821-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7308195683499952577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9353C2625DB
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 22:36:57 +0200 (CEST)
In-Reply-To: <1397378240-20821-1-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiang Xiao <xiaoxiang@xiaomi.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7308195683499952577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6nSyB+bcl/pT7+kx"
Content-Disposition: inline


--6nSyB+bcl/pT7+kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 13, 2014 at 04:37:20PM +0800, Xiang Xiao wrote:
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>

You should explain why you want to do this in the changelog - what's the
problem that's being fixed or benefit?

> -	if (power != peer->power)
> +	if (peer->force || power != peer->power)
>  		dapm_mark_dirty(peer, "peer state change");

This doesn't correspond to your changelog - it *will* skip evaluating
the widget power if the widget is forced.  It's not clear why this would
be a benefit.

> -	if (w->power == power)
> +	if (!w->force && w->power == power)
>  		return;

Similarly here.

--6nSyB+bcl/pT7+kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTEbaAAoJELSic+t+oim90jEP/RsNiYuHsh/GzmLvk/ivH1u8
Gf9u4nyUK2p4hI3wWr1zh8caMJ6lg9gmBYByDBIm99tfOYyQwYTuqRbu8u9j5jtW
AvADr+g1NdplGXX3q3exXJC2686lyjufwa8GBkCbHEZBIqFN7DuxtmhBzHyxKO1J
s3dQuVb7E8z+jAVQbJuXYN5yO5tlYU/EWvFcfU/ksT72tVjryiKS984fzZ0yY6P8
exLNY+uEWrreU40UyDh5T74Nyjw0NEi9XKvyvie7gmbwEp0V3UJkAc7kfvbTXF61
lj9/p5TpoTxeQr982bUq6nSViWU2PWR2WcxkBBW+GOzELh0HLYA0wKDoKyFFNixT
ubZig7vwyci2giq419PW3AI1X6BTb3FDjqDeSBdHPujKl6pwK7N0a7nJePA2zVTu
P62znpmdparyhpO5jc66EcQ5nTt9XpsYR8N1BJ04klv3nATZK8xFfzYrD6RSOWm3
GybtfA+8MjKQeGr70XCau6fMG+xWGagLH2jDrucICGxCtDaNbyd4c+NNJmjdmd2g
sYQQFMIrLyPtTWs3FMSpvdbQkDSmJLZpgLlrH1hkog6B34xQsoUmVqRO4/9mEHu5
o5uVPiyIq94LTapn7bW7t8bycQKAzy9hOgwpetlLnFt9IvE8IjWXTpqPGJ5aZhog
GN/yj1fW+JM7N4bmJsSs
=lhR7
-----END PGP SIGNATURE-----

--6nSyB+bcl/pT7+kx--

--===============7308195683499952577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7308195683499952577==--
