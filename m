From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8904: add CCF support
Date: Mon, 24 Mar 2014 11:07:51 +0000
Message-ID: <20140324110751.GH2269@sirena.org.uk>
References: <1395370262-23305-1-git-send-email-voice.shen@atmel.com>
 <20140321103747.GK23372@e106331-lin.cambridge.arm.com>
 <20140321115511.GM11706@sirena.org.uk>
 <532FFE7B.2040507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <532FFE7B.2040507@gmail.com>
Sender: linux-sound-owner@vger.kernel.org
To: Boris BREZILLON <b.brezillon.dev@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Bo Shen <voice.shen@atmel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 10:44:27AM +0100, Boris BREZILLON wrote:

> 1) Expose the wm8904 clock tree using the CCF (and its DT bindings)

We can't use the common clock framework in generic drivers since the
common clock framework isn't generally available.

>     clocks {
>         fll {
>             compatible = "wolfson,wm8904-fll"

If we're adding compatible strings for non-reusable subcomponents of a
device like this we're doing something seriously broken.

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMBIEAAoJELSic+t+oim9k44P/AychiNEmCCQ4zgOZFLFZVvN
5vBEvkOWEBYZrobeqynmvVuVoO71hcEv08ZNBLgj4TjbP3Ct07NusF+vWsmE3ciC
evNAx7T/HDYgL2qf1Ry3ai55cyVd/85sn4OBoRHAhBdKZ21yitLFnKUV9KkqwxDN
hbA2XMHEWWRLEgrAO2dLvpfLJcPv9WDpwA+otr6E+Xdiqg/QD+V6QmZLHtLupeTF
mZkqZmtpaGTH1CRsH+/zvTon7/HlDtv90sGVJlvpVvnWklxA9PrwnUdm3hm+/kA2
uZpyvQ9emT7QDp88u7HpPtAu2J3WzZ7oY6qWvqpQ+KPEFWvgYUK8l8EDbVWLzw/h
i3O0yAUQ7SqXdiMNWQlGpqg8G4LhfuprqWA31IswgOMnxawLU91MNy75aYg029Q9
dVvNLp7CfZJjRpVqks0CDuq4NZTP7Bj/JdbeI62WnBToAZC+SOb2w4PDa5m3FLMY
3qF2SQeMMJiXhO70Ql144vf6s3+WW30Y5oT0GvW5e0AdOCBfo9o8c5tFwsCuZRUM
KZ+PgpBdhXGdwRZzg331215toxdKUdgEeGT5pATIEJj937vY5bjaULGbrLr0sTCE
7Amx5P6yy5gOkd2geaGmwfpBXBm/1Q8EEPnqjyoSy4VjIyk1koJlw/T8ilsaNdqp
5cT42EnZ7US142pRof6q
=oFFi
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
