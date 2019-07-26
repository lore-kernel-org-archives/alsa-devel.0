From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: rockchip: i2s: Support mono capture"
Date: Fri, 26 Jul 2019 12:17:17 +0100
Message-ID: <20190726111717.GB4902@sirena.org.uk>
References: <20190726044202.26866-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3965781844057460306=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190726044202.26866-1-cychiang@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, mka@chromium.org, dgreid@chromium.org, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3965781844057460306==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 12:42:02PM +0800, Cheng-Yi Chiang wrote:
> This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.
>=20
> Previous discussion in

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl064T0ACgkQJNaLcl1U
h9DmAAf9FDy70YAEs1yPd9vLXET+RkMVfd/1yiLlweWPaqgu5WqZDjmBFBOQBj98
CnVVDFj3X1Fv6bQs6Q/+jRMuP5ckxiGPCFO2n0dV70pXNj0m/iGUHtj4ly/zOqsH
hwNNbmOpHphNoz87TaPFdPCj6XWPcNUOIa9b+mv/g8sxzR+9AdhzP0xLaDY7ixN9
0sZ+5QRGFuPsu/WscetgXtdTlhxFnEYpm6HxgvmZIrdKW0hYKVM7rSj4wKxiaP9T
ZyYlSmH/oA1OATb8LuDUPE3TTCEmMnyZUSyEAHeXAeWNFZzNn4bG0XYBeQoNZE8C
HZeFqmHV3qj2cU3rejJ2g1P3zqrKyA==
=4GTC
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--


--===============3965781844057460306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3965781844057460306==--
