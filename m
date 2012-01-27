From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Set idle_bias_off flag in
	snd_soc_codec_driver
Date: Fri, 27 Jan 2012 11:22:25 +0000
Message-ID: <20120127112225.GD32008@opensource.wolfsonmicro.com>
References: <1327658529.10143.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277044585904787607=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 081A12434B
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 12:22:28 +0100 (CET)
In-Reply-To: <1327658529.10143.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Vladimir Barinov <vova.barinov@gmail.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org


--===============1277044585904787607==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2012 at 06:02:09PM +0800, Axel Lin wrote:
> Since commit 33c5f969 "ASoC: Allow idle_bias_off to be specified in CODEC
> drivers", now we can set idle_bias_off flag in struct snd_soc_codec_driver
> for devices can unconditionally support idle_bias_off.

Applied, thanks.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIojoAAoJEBus8iNuMP3dFksP/j79bchKnp94rKM1R264v9vG
6F0jrUSvKDs4CTiKMSLQOdlGnxvf5Ha1N7N/Bq4iQGWS/tQn2RRdiyyiM5gFEnBP
KW7E2ag2ebdrYxhCUhCjkPeqeNbQrjyO6JgvXXAQIuJ7DzB3P+uAD88XylEK02we
pO6Mo9Zno1NjFTX7DjAztW6yUGI+YStNsJCDgeHAKMyyVwucTdo90zmkJq3IWFFM
EbdPdSlUd6nmeDo9xnN5iEd+WYRBoX96zR7CfQz8vErlmaMdZqg6QfGssB3M2ib0
ZMJT6bUFjzkIiNv59ZoKrk8Q0O2veIGNLoiL4IsYxUtwq0nVSLV09sTW+vQUkj9u
3W6LzTmiTZ+g2SQvgBo3Wn80h46IIX8W76fud6HJGlxk0u2EAEHyujH/cA/Df5mc
qS5esucLXItVTibbykYSOzgi/QW/ZjgycAiGaEEHmmwi625EBFT+20uQ6/asBQXI
jOt78n6OytpYm332csDzR0EyXKrSEr8WeMpzV857xDwWhXpL93QQIevlRddFrwiE
yuqPRjEyHiRyGg/Z+Lf290R3QiCKUHi4vX37x+53dH/XWg+bk3ScJ8jRWN11QrfP
RwxL6HYJFhrBOIUfQfVrt+C9PHVTj8QJnBuuAOmLKnzcnOz5QAlguJHQfDvhbSEk
EzterwwVcZqEH97dCkYY
=ccwl
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============1277044585904787607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1277044585904787607==--
