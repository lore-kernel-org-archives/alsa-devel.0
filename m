From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Mon, 6 May 2019 12:53:45 +0900
Message-ID: <20190506035345.GJ14916@sirena.org.uk>
References: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7e8BFhNxqpjiNKz7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--7e8BFhNxqpjiNKz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 05, 2019 at 03:28:59AM +0000, S.j. Wang wrote:

> We find that maybe it is caused by the Transfer-Encoding format.
> We sent the patch by the  --transfer-encoding=8bit, but in the receiver side
> it shows:
]
> Content-Type: text/plain; charset="utf-8"
> Content-Transfer-Encoding: base64

> It may be caused by our company's mail server. We are checking...

Ah, that looks likely...  not sure I have any great suggestions for how
to resolve it but at least it looks like progress on figuring out the
cause, I haven't been able to see anything wrong locally.

--7e8BFhNxqpjiNKz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPr8gACgkQJNaLcl1U
h9DVeQf7ByKyqDU+F0dmHJsGDAll4nFkuDLq9wax+i1rjUCghvBhzq+0tNPf51Dk
oJT0+OmCtKJcYIu4Z7OsLBDr75SiQE83YxdWnaAGik49IJUA7ggTXCtXfpLcs2Vy
VtPc2H969t2crPjYI3AkUIJzYHB2GCwgsWvKmDeWS0c6Sb55eN5DptFsS6UuPcrI
CCOhBJvO9P85bBNjkMRAla+SM6GV77Uq5DC4iV7ert68gwp8pRVdMY1sNTx9J7BZ
soqk2U9xLPJtJUeZs89WKZy8mCW1BtFuvQAvt1W/mNJmkWWedc4FkAQgHV3b/pIn
z4slaJ2AqBkaAIC0hq6wGq8dKSVecQ==
=/QHA
-----END PGP SIGNATURE-----

--7e8BFhNxqpjiNKz7--
