From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] ASoC: Intel: sst - add compressed ops
	handling
Date: Fri, 18 Jul 2014 12:48:23 +0100
Message-ID: <20140718114823.GN17528@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3273159898444638986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC842655F2
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 13:48:28 +0200 (CEST)
In-Reply-To: <1404898076-1882-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3273159898444638986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qWV9ymU6UYcl1Snp"
Content-Disposition: inline


--qWV9ymU6UYcl1Snp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 02:57:55PM +0530, Vinod Koul wrote:

> +	if (codec->codec == SND_AUDIOCODEC_MP3) {
> +		codec->num_descriptors = 2;
> +		codec->descriptor[0].max_ch = 2;
> +		codec->descriptor[0].sample_rates[0] = 48000;
> +		codec->descriptor[0].sample_rates[1] = 44100;
> +		codec->descriptor[0].sample_rates[2] = 32000;
> +		codec->descriptor[0].sample_rates[3] = 16000;
> +		codec->descriptor[0].sample_rates[4] = 8000;
> +		codec->descriptor[0].num_sample_rates = 5;
> +		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
> +		codec->descriptor[0].bit_rate[1] = 192;
> +		codec->descriptor[0].num_bitrates = 2;
> +		codec->descriptor[0].profiles = 0;
> +		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
> +		codec->descriptor[0].formats = 0;

It'd be more idiomatic to copy a static variable.

--qWV9ymU6UYcl1Snp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyQmEAAoJELSic+t+oim9fcwQAJEB/mYrZYqvqoS5C8jHudO0
d/Nu2n2WEuuI3guFHBuTNZt6gd35ohdfKZ3jb0IlalqGASff1Xtd/GBxp3NXRDTJ
KFh4EqUzPXDGnSksT19CC14o5b6kX8vGbffr24dWWakJKDXIEgwWdOBThVcC5Icx
tHgSsYsnfXoIcAaYJqvMRZddpwKNBMacNI0CydaTurVfVgxNs9KjAuCdPiIq23E0
piLBu4qhormQmBoNgBBZRGjX0AUYGNrJUPcWrQlJ8Sc4XTUk5/UNRXAxvUJFUlKE
OOApduwtmG8yt6p5UiSE9geVv611aukeXUtm1lKQKLx08vk5KjA/TXmBdJu6fe4r
dgGESrb0kh9znPqiIa6sdzinYQAOq1Af/225BlBBFKNtN8dazWXyEhzdMyismg27
VgVrh1wGI44KASD5Ry4GZnNx+CZyzVtHQk8wmKu3h+lyPgAZrojcJuuUlsZkUZHD
TwMrUfghPnbuOkcwqnQIwDK2BGn/gmJ18fehpc2eZ7RMvAKxzlMnz55MY6P5vuva
CWEheJQjf80Qg8UskpQAexaGocf1WZW/j91G7pQkOvWbQ7yx2J/RaIiAFWcMbb9i
PAOMp+zcwWIjl4XHpxNpwm64B/66l5DKjtCV+RRCGQ26Q3NRnZU9reGkSEmcW7s4
m6vH///MnBYEaQyUAdkL
=XpH5
-----END PGP SIGNATURE-----

--qWV9ymU6UYcl1Snp--

--===============3273159898444638986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3273159898444638986==--
