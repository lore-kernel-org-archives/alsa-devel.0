From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/15] soc: qcom: add support to APR bus
	driver
Date: Thu, 14 Dec 2017 16:48:07 +0000
Message-ID: <20171214164807.GI9788@sirena.org.uk>
References: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
 <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6416905629080670737=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E4B4326732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 17:48:08 +0100 (CET)
In-Reply-To: <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, kwestfie@codeaurora.org, tiwai@suse.com, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, Andy.Gross@linaro.org, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org


--===============6416905629080670737==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 10:17:59PM +0000, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added remo=
ved
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.

I'm not seing any of the Qualcomm architecture maintainers in copy here
- are they not expected to review this?  I don't know what the usual
practice is for Qualcomm things.  Adding Andy, Dave and Stephen to copy.

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloyq0YACgkQJNaLcl1U
h9CuFAf/SZIj0fLEo1GJ8Um+hbrW9Xx7xBrDor+Wjm04eAW+3lj5Uuz2SERt9wSA
Mp1VQGO6ZK1/FtQkmeBNLKpbjUAkjFq4mWtmBD9uN3N1oiG+MqPTnqkFkrSEvu5d
kMH3kJQnH2DLBON/IXdzj85jAqqext4xPnJmvpq8ypAXGVYeWXEB+mrkqwm+K8AC
43VVwGvMXMU+uc9hWZsrQrwXugteydMYwMXd8u/18PtZcDF4jyJnxb1Z2i29o0ih
RxhxraHl/xyjjJyEk03pB6sVIQNETSJhziXPrFWlpc8CGH36l2hVeIJHF/UiemnI
/xz8YAWS2+Wr5/9GR1OlHHS3G6CLzg==
=iOpX
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--

--===============6416905629080670737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6416905629080670737==--
