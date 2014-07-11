From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchips: fix build error
Date: Fri, 11 Jul 2014 14:48:48 +0100
Message-ID: <20140711134848.GX30458@sirena.org.uk>
References: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5732481588957454393=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Jianqun Xu <xjq@rock-chips.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5732481588957454393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvGBTzZYFChjGQji"
Content-Disposition: inline


--pvGBTzZYFChjGQji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 03:07:08PM +0200, Arnd Bergmann wrote:
> The newly added rockchip_i2s driver is lacking an include of
> linux/module.h, causing a build error in some cases:

A fix for this has already been applied.

--pvGBTzZYFChjGQji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv+s4AAoJELSic+t+oim9d/EP/0nMhsAYcplyh5pEcmyKrn3r
h2/QEMi+anbPW4xnY8WyoPBi+cjVidjVUJhVbaJwJWT9myDOkFCLD+S3zFUNprCT
9cr0m9THQT4g1+m4zVLLHxjAokP2rdZ9nxNJlxFeQnia2jwYtKyMyO7UFGHeLJ2t
kUSPV8M3dfhDBNm8Ky3tVQ0fwX6w/Ib2eX7eyKlKmtA2SVShAZ4QNRH7jfTfwsMy
YPBHMVCQ7cOwur+6gJiZhGQLQfwJ8utE7JD1VGDwwF/sQvFwTt8nvF1OQA+4jDU1
7wOd7beTxYBhGsxuKYFWZJM5mBAqVLeyQPZ9c29YMSfXWO8vMMTYiQR50IwcPxf9
naeaoNUe0ZwxrqxDCpvXCUGQamNJV2PiVmMgtS8xOyZeba+NofK1AUElzFzm0IOV
qUpDhjTOwpVE+cBSGhEvjMJ5z7dEigd1O/3BgDj+JoojxgRb7CqfwPEP3av7exyX
ed0bIjFQAGIJSz9BmpFlMDklSZQZSOqffRgDDtD65FRwYW0wdnOtLE8hzfMJ2Yme
0l1BqpsDc/D7FyshSAE0xn8Sdv1hOETl4P231+ZWn7eiHEJasROaArd+JoPt2h0j
gQBPnksJSJKpOQfbRjvBscuO9Kz+DQsHz+gcrIRIrH4TB3xrVd44k4VePvwQRm1b
5PnGRMurFJfC+1uN/gbU
=aMvU
-----END PGP SIGNATURE-----

--pvGBTzZYFChjGQji--


--===============5732481588957454393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5732481588957454393==--
