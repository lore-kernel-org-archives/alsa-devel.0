From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: omap: Replace instances of
 rtd->codec->card with rtd->card
Date: Tue, 20 May 2014 22:55:05 +0100
Message-ID: <20140520215505.GW12304@sirena.org.uk>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
 <1400492508-2732-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8290553999907368483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDBDB265086
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 23:55:27 +0200 (CEST)
In-Reply-To: <1400492508-2732-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============8290553999907368483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1rc5jQht9vj9V9u2"
Content-Disposition: inline


--1rc5jQht9vj9V9u2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 11:41:46AM +0200, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help to
> eventually remove the card field from the snd_soc_codec struct.

Applied, thanks.

--1rc5jQht9vj9V9u2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe882AAoJELSic+t+oim95M0QAJqj0YCj2ajFpjJOtBAL/Xjz
UpcLCMNu5j6XdLKOT64JzzSBGiM0MhghaibmHzvBkP/eiDYBZ21PJ5HJqvdlfGdG
ChX1EdgExN9vwbLITi9ag50TZr21rwM2xPDKkRvRuLb/xfJ+yj8GRDQbi6iXAJrq
hg/XkWWNdABoEYFsuc6VIhADwHH1GzZ4o4tu6/R+4c+mgUp7uKTOgaRKK3gXwsHT
RuHkzqrMW5PAdGxYMqG7dcRS/FVxFTBXLnmTGzEP1Ly/bX4YiB94xxLDB+I8kmtE
7PvxTm6Ei0LfEvWQB/L37gfUSI46EOXrsAScRVwOKe5uDP53Wiv+yd5od8Rx7u7/
0T1xNaCeZI2POEd4hibzCPGIwpreAk6W4biXh5V4KpQmeffSbLg3TLcrgQbG46FW
ey34R2/h3LYoGyAXx1EYt4idfTTKIJxVbgRuCZ/jaWb6C5xd7ITpZsf4PcmtWBJd
+9QHnI/5N9bEe40CLyK73Fv2eML4byV/KpXPhCEgsaYPiH2v7QiEbDlkBF4DrZRL
nwmIr3SV4mvwCBiXLqmbJuJNI3v20mP7JmE994O5zVL7g/rGec0ZCpbe4kRaM5GG
+x/ARgt7FOktguqR8DZEL+b/knhBLXydANKtykqCz9Tk8/hJKlGWPZbYWEVgGU9m
4maU3Mdu72QIjDJ/VZJ9
=0ohl
-----END PGP SIGNATURE-----

--1rc5jQht9vj9V9u2--

--===============8290553999907368483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8290553999907368483==--
