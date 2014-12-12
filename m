From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix comparison of pointers
Date: Fri, 12 Dec 2014 13:21:09 +0000
Message-ID: <20141212132109.GH11764@sirena.org.uk>
References: <1418162021-32229-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Uwm888OkiLvmClh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418162021-32229-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2Uwm888OkiLvmClh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 09, 2014 at 10:53:41PM +0100, Rasmus Villemoes wrote:

>  	if (a->reg != b->reg)
>  		return a->reg - b->reg;
> -	if (a->dapm != b->dapm)
> -		return (unsigned long)a->dapm - (unsigned long)b->dapm;
> +	if (a->dapm < b->dapm)
> +		return -1;
> +	if (a->dapm > b->dapm)
> +		return 1;

If we're worrying about standards conformance type stuff here this is
also buggy since it's out of spec to compare pointers that are not part
of the same array like this.  Casting to uintptr_t is a better fix here.

--2Uwm888OkiLvmClh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiuvEAAoJECTWi3JdVIfQHQEH/jWHimuQ8k0BH3LjjDq+LTam
71Tj0F3eZ7jv34DfnERaBZ0Z6eYZFwsVmxN1CIfR9RzooLHLoVlc3jWxI5al4n8W
M1q9Bb/hi2hTK6iOiQR8m+XUwtKW6VrUUdlLhNzb1wHwyZ4bmI12Q5KbcrXsxpxQ
1FatMXXIXbeI+Wz448+3cFoIlr+MQ11AsS0jfVuFnAtdyk6cs0PY0BowJM9qNc7u
KIDKyRLKGKUgfJxd1pgzNExwO14rXRJdZgO0kjIyk2ch0wN9pFHNXKbPFq9anWX9
1CugWIHNSfhbPnPGAwUYcXdvqxzS8Z7rW9FqNgCiY0x0g07MbERVygj1Qhb7iis=
=x4te
-----END PGP SIGNATURE-----

--2Uwm888OkiLvmClh--
