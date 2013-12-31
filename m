From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix one bug for hardware limitation.
Date: Tue, 31 Dec 2013 12:23:36 +0000
Message-ID: <20131231122336.GN31886@sirena.org.uk>
References: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JIgDBBEDRU2Tt5Ar"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JIgDBBEDRU2Tt5Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 03:33:21PM +0800, Xiubo Li wrote:
> This is maybe one bug or a limitation of the hardware that the {T,R}CR2's
> Synchronous Mode bits must be set as late as possible, or the SAI device
> maybe hanged up, and there has not any explaination about this limitation
> in the SAI Data Sheet.

Applied, thanks.

--JIgDBBEDRU2Tt5Ar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrdEAAoJELSic+t+oim9DrYP/jBhO2bufE9gzNVT0B2NHPUT
jHcsS+5OqQBDwRzlCJsOVL77cGlH4a17Zm25qIBIbq/eyG7vvCnZTXm8ypJEuQVL
fDiprEh4a9OxRX1Rfk0xSVDblEtEPn7N8H2791TEm1gV1XLRCidd33jKPptKIg/s
0iExSGvARfCWSrhj7hmXXyM9Zhe5zou0BaP+IUfTB3CeF7xn1ZByMQ0NU/DWlKX+
qbfmepk5707t9xi6ZIzqzbgyESFVOIzlSTunkaNNh0OY/TIOCqNaxYooJK9WWhSf
PBAW7aV+woMdtpmHH4m0sk2T3LIWKHtFr4RWUMPiMjGlfufcXRK+Uq5m3H1/dZ0b
LmKy3N36k98Q0vMnO0gIrru0HEoU2ZyMZ3pE0lCkcObubUBrxxO0i6XyM5WKQ9dB
BGLSVNKmbv/dSgv5IFq1UbXYlSCZV7P4frftHt0VYhM8+7efJUs2zpLtV5RP8H+k
GW9NMRvLSpbiJjGGYiFYG4BuwdElDuVmJxWjL0+3PudIUDEMnZPMuw8EsfLWVfUn
YeNKrQtIT0dRFINet4h7E9darPbLYCbarQg5UNsHVAhuVH6AYsHw1n6K2Bb4bpXu
fQSVW/oZEicTkagSuxrm5d5yjRYwD/G7IsFl17qYu6k46ilePFPlce/xbL+gZ2Jq
+AKUQvegWr4lULdT8OjQ
=7lBi
-----END PGP SIGNATURE-----

--JIgDBBEDRU2Tt5Ar--
