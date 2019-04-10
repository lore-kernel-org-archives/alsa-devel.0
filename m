From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Date: Wed, 10 Apr 2019 12:12:42 +0100
Message-ID: <20190410111242.GK6106@sirena.org.uk>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0297691270919577736=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Viorel Suman <viorel.suman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0297691270919577736==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 11:06:35AM +0000, Viorel Suman wrote:
> The latest audmix patch-set (v5) had the "model" attribute removed as
> requested by Nicolin Chen, but looks like (v4) version of DAI driver
> reached "for-next" branch - fix this by removing "model" attribute.
> Asside of this fix object reference leaks in machine probe reported by
> Julia Lawall.

This is the second version sent out in the past hour or so :(  Please
allow a bit more time for review and comments, people might still be
looking at the earlier versions so any additional changes they spot will
result in yet another resend and more noise in people's inboxes.

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytz6kACgkQJNaLcl1U
h9CQWAf/d6PbLwI/eE3Z3GqFktngflv/Hvwe+3XW8M8gaoXqCol86/BusJ0fGnQL
S/cqap0+yT+My2oovt3KCTAqtA/CssjrlYvqyEbsC8pMGvewtVAMzUFaMbrLUnOu
aJEp7Fq9wCAT0Q/mM5TiFGrVBpmQlIpthIOP1wLejUesGpQLlPM0bNXhbCeBc1u/
rjB07FvCZrnEdVtO5ohtB6HPsD71lUqejGrxMr56T5tU6nAhT7ksfXyD4uRv8Wrh
/l/DGCYxBqKdHNEw5Fi2mj/2+9f5vS4uO6oJ6xa/RGfJKrXqrZupqn+OPQZ084OA
BEA0nh6cJQ2V9rnxrtcp3sVwHxTPHw==
=9K0N
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--


--===============0297691270919577736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0297691270919577736==--
