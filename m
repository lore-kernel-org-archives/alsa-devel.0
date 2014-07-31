From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf-audio-codec: Fix return value
 check in sirf_audio_codec_driver_probe()
Date: Thu, 31 Jul 2014 21:22:31 +0100
Message-ID: <20140731202231.GY17528@sirena.org.uk>
References: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4118640770103370044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DDD5C264F3D
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 22:23:03 +0200 (CEST)
In-Reply-To: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com
Cc: Barry Song <baohua@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4118640770103370044==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QAqM1DfIDVlQc0I"
Content-Disposition: inline


--7QAqM1DfIDVlQc0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 08:04:12AM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().

Applied, thanks.

--7QAqM1DfIDVlQc0I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2qWDAAoJELSic+t+oim9IV0P/i6Whcd8YugGZrUAYdqr+3CO
9KQVJ7kVRBjmI9g6sae6siQ6m+B6WLPz3sfma7zDttS59AVzmdluLJZYGD8n29Jo
9v+WLexVpWKZLvjTgleqn5vy9PzN+1QRgkXZPIhFYY+6+RLdQdtXuKA3Dh7gcMcv
e+AJLGPhKHXK2pe446/ErEb9BDDT1juznVFVr99qUjEyE+ml1wp7AoUvlsuPu4Jr
KDDW6kaYH8psvMZ7vIW3d7UUU2L3wzc3tfvStWXokwf2piLyJ9UTBz4q5S8co6G0
NGXgEHCBg5kCYYpYLUqoGf3xZU7kG5haMn4PqaVeaNZeNCtTkqugqSpvC0QvOu8V
dfoRS5Rrrptj87NR7Nh2vNnfAbNbsD24W2ORmMOgYpZXtxc5xC8lEaU4DA+B8jVC
wNIo5GYngsnOHuUmk5wnRNYbP/PT92QRiT7ETjQEKhv8AaMlxbjUaxpmm7bnNcGd
fsCa0G3Ako7mx4ARP6yeqts2+r6mtl9oTJSJ2xVY57pZGvwuxTrKcwCEiRRmVICc
wlE/RoOqy4gavlnhljsbl1kLO5v2EZEyv03ONHfGcgL+kqJ9psTrrHSiHgvj5lDF
cCW8dGJZm55yW6awoH24TGZVgLNTXxPIIjG7nzOKv1Ae1TvX/hojlN+M2T+tMFuH
jypSeodrk9ezcODshqrq
=IRbE
-----END PGP SIGNATURE-----

--7QAqM1DfIDVlQc0I--

--===============4118640770103370044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4118640770103370044==--
