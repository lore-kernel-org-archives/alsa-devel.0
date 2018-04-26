From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Date: Thu, 26 Apr 2018 12:39:11 +0100
Message-ID: <20180426113911.GA21755@sirena.org.uk>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147266082917654543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 620862676AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:39:21 +0200 (CEST)
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0147266082917654543==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added remo=
ved

What is the plan for getting this patch merged?  I think the only review
I've seen from maintainers thus far has been from Rob on the DT binding.
It's obviously going to be a dependency for everything else.

Also just saw ARP->APR there.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhul4ACgkQJNaLcl1U
h9CgQQf/auIda6Dzw79FRXmW5P9u1HmRvwFwIj/szesf68wOagvCtVRoYvjSDS1W
w9GujIX0dYGRMmClXB2WN+cR6nQYhaPsOLv02wAnLkhUjT6/qm0v73Oa7n3v20hN
okuwDTa03R2BBn7eyrBnt7iLT5PEu3oP4tsJZZL4WPb5STMVXhHLJyzv4SfSjAhM
yACHFUEBSMIoSP+ylpv+gaBW3ibu5wY5IAouxJ23BvwADCufIBT0enFihaUsMImd
QC6WHhQJEhIOq0lfrStSQ0UuI1e9lufN2d8GTwWf1FYQlyIl53G4fSGbZJymsLzZ
qeWZq7sY+4eJmQL0v6cJbPr8t+Y7cQ==
=MK0Z
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--===============0147266082917654543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0147266082917654543==--
