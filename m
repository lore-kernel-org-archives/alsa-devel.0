From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Fri, 29 Jul 2016 15:41:45 +0100
Message-ID: <20160729144145.GF10376@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
 <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 11:01:27AM +0200, Lars-Peter Clausen wrote:

> In my opinion the flags are just as much a hack as the pointer. In an ideal
> setup the component does not need to know what type it is. The reason why we
> need this in ASoC is because the framework has grown over time and we need
> to support legacy code.

Yes, the pointer is essentially already a flag - having a separate flag
really doesn't add a huge amount here.  What we need to do is get rid of
the need for the flag entirely.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJXm2soAAoJECTWi3JdVIfQOAAH9Rb30xoYwOCStU/FgE9HKw4L
taPToplAF/QDiz9GBDkYaYvbCr0xSOFeBjXnT/AsvtBTJKPLvqmR3sRtIkGQ/lrG
dq7I09uSTqNLtwhtXz8Csv/i2BfeC6DNhPMUAteVUKRzHFDeyPHUsTyQq5THWAsN
H0nRv4iOykUP0zaoMDFtgx7I2Cy3Scti0SUEu/Iz3KXKSpkp0KcttAUKWrmLC+t0
RNaxvLMQHYgKNOpF65n2tEE+HSb3ezgtlTkfNEA+A5oxZlXyIP7w1DYYrhjc2Cjr
0HHCvwKnPbccgZy0HRyHraa8kUqG+R0LJ6EkaQMXg8MNpwWz5kyBbcxKQpY+kA==
=9aLF
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
