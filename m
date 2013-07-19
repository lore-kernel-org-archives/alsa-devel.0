From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: sirf-inner: add mach driver for
 SiRFSoC internal codec
Date: Fri, 19 Jul 2013 19:51:01 +0100
Message-ID: <20130719185101.GV9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4699308047253406407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EF2226577F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:51:05 +0200 (CEST)
In-Reply-To: <1374232042-26088-6-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4699308047253406407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FZIkiClxIZ9JeWSb"
Content-Disposition: inline


--FZIkiClxIZ9JeWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:07:21PM +0800, Barry Song wrote:

> +#ifndef CONFIG_ANDROID
> +	unsigned int            gpio_hp_detect;
> +	struct snd_soc_jack     hp_jack;
> +#endif

Not for mainline.  I'd suggest setting it up for extcon anyway
especially if it's just a simple accessory, that should work for both
Android and mainline.

> +static int sirf_inner_speaker_out_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	int is_spk_out = ucontrol->value.integer.value[0];
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_card *card = codec->card;
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +
> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_direction_output(sinner_card->gpio_spk_pa, is_spk_out);
> +	return 0;
> +}

Oh, right.  If this is doing what I think this is doing you want to use
DAPM within the CODEC then this can just become a pin switch or you can
hook in directly if you continue to use soc-jack - it has DAPM
integration.

--FZIkiClxIZ9JeWSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6YqSAAoJELSic+t+oim9BLsQAJCO+WIsRfuqX2Z2J6F8trCG
zyfZstBga6qjW/BADTyKI9BBelDVI9HEfh0eCDi2CUfqg+r61flZAnovRL//slnm
yZA3o3MQHH92/PdV+HLCaHy9rDuw0VcNRqubpFP2j4AsGMaBQ+DHfCS0TLP7BISw
/DQjxKSY8qBbxLw1M8N5/TEKnBtKHdu97yNZ5qdrc6oZfcO1+T/JtZrL/pAudYsd
9YeTpIX0+B2LyaK0ZtAZIn2FzKYSldNXR605OM4BWEjQodcVDG4sSCqcv/GHEDcP
6zo98F2qhcwAAuV9aCWJlA74r85uVz2lLryPP+fQ+ck3b21v08N/NilzJGqfYkJe
ZCIIlNTUkIe+ka9vJPd9TG/2ZFkzxXc9+kQUwQbAaxSm94x+rvF8JgYcdG/IpEkY
UiUEAfw5nWIYZDWbfPXJ1MZ06vY8TfXNl/h2iA6Ix+rrfidbI9+tuCK5TA7z+4e1
Tz60CjhadGWleqtkMZlt7ToPAsIMhlO8/1rolgGdMBqNiad28Y9RnNdvs08Vyq+z
LRw36wLsJCHsnADRn4B6ifr6Q1E/NesMwGI2RQOv1FMbZ+DoRWGdSrc0W+yU4gG3
NAtf7BJjei6EPZBq346sU4vSU4wvoLdkq2KMrEw2QY33BsX3cMXrOAVLNRxBsGMw
r2b9WMVfLHiLJpK1VlOc
=7DOz
-----END PGP SIGNATURE-----

--FZIkiClxIZ9JeWSb--

--===============4699308047253406407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4699308047253406407==--
