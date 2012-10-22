From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: jack: remove unused variable in
 snd_soc_jack_report()
Date: Mon, 22 Oct 2012 14:50:48 +0100
Message-ID: <20121022135048.GI4477@opensource.wolfsonmicro.com>
References: <CAPgLHd-DCVsDnKG6uH=Pq7hABRmyEfJ30GxczD99cmjSQQiWDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-DCVsDnKG6uH=Pq7hABRmyEfJ30GxczD99cmjSQQiWDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2012 at 10:49:19PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> The variable oldstatus is initialized but never used
> otherwise, so remove the unused variable.

Applied, thanks.  However for changes like this you should really
consider in your changelog why the variable is unused - is the bug that
the result is ignored or that it is needlessly generated?

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhU8LAAoJELSic+t+oim9ilEP/02Df/RAjZTdXvmomx5QUpuV
IpzrpMvxy7JVz7yUgxpfcSgZaU8VNPbqtxXssUdHLit35wExnCRVGvjB2o6ewBdw
j88xPv/3t+lblEjMo95jBUto3s93sRPt7/qEyieO8rco/i2I9+ei9isyUKL/MmsZ
CtoNGBZXjbQMkWKGZtfi+LVgrvS5E//xUVqkASJnSlsi5i6IbKZHHBcyv4aORi9Y
d/YA4BM6dmYkvBkXo5XSQ6gsihji97/8Eb3SLPSDbpqoR/18Npk28OEMWdOStZRT
J8KxlgE6o5KQM5dAg11y9YI+4n31w5EgfXZy2Fv2I0h06qenuskKG8ZQxpwPxqA/
+5yho87P4nuCJg1tzDjBUwsOPsn+DZ/159v6u+YOLU77YuvL4pZWZfTs2GpK5vbb
fzTCj9D2HMfcFeIbY9y5iFfNKhOiiABhIUozzhrJQoVvWzJkiCmfI9GryPmTQxXt
Ho0LLZBJQczh62G5d2t4evnwCPWQA/t84tL5HyrFUaYRO+H/PJFMC7tABwBVfd1e
Tye1mn5dmoVIyrX5CjMC86VqW5LELKqvHZBxY4kVPgYqpyv36SXwLXivlWx+bB++
s8LJSt7U+mA/fuIPePfliZ/lP80gAzZFLCwVswVgvziIisEPvHSDFLJJSwzLgLuA
XsTF0bWD+bGtltujJ9IX
=otJk
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--
