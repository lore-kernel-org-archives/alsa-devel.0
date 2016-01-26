From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Tue, 26 Jan 2016 16:03:33 +0000
Message-ID: <20160126160333.GD6042@sirena.org.uk>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
 <20160126022948.GA21187@rob-hp-laptop>
 <56A73FDE.2060607@felipetonello.com>
 <CAL_JsqJxQjw5yWmnUAev4e+pa601stcH-W-srbDCeRYOabJrOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJxQjw5yWmnUAev4e+pa601stcH-W-srbDCeRYOabJrOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Felipe Ferreri Tonello <eu@felipetonello.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2016 at 09:50:46AM -0600, Rob Herring wrote:
> On Tue, Jan 26, 2016 at 3:43 AM, Felipe Ferreri Tonello

> >> This should be an exact list of possible strings and valid combinations.

No, there is no sense in trying to document all possible combinations as
this would result in so many combinations that it would dominate the
documentation.  The restrictions should all come from the physical
limitations of what you can connect and should therefore be sufficiently
obvious from their definition.

> > This is the exact list for this version of this driver. At least that is
> > what I can verify on my hardware (custom build).

> What are AINA, AINB, etc. then?

These are CODEC pins and should be documented in the CODEC binding
rather than repeated for every machine using the CODEC.

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWp5jUAAoJECTWi3JdVIfQAR8IAIKwTPsxO1jmRV85HTUmm7Gy
AOuvoJKuaLYEF16dMbCptZn654wtbSUEVLPfmlNC3JSQyz3Je5BxZXLPu8q0m/3v
AWU3LjMN3XB433gXc4/KVNUX+1js2VoeKmBXO+iyJKbiDPG03bzrXb4qQVTGeMM+
1CPfb/6N4X7KfZ7oR43XAt0NHyDfHClYAtDAg62JclvZPeuiY+vHaFSk4HiEKH5T
Tj6rYSqOLMVu3KcaAsDY+0Sa0Fj7KQk2OO7OsKVhkuw6JDlAAfMOuD7DXXSKJ8ML
ICCzuR/8yO3ib/6uc5AyaCBoJhHf7FJpax221ZkRz+WACPYQs+h6mLLX0WEXRFc=
=Xfwo
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
