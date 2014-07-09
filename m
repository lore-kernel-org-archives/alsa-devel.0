From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: s3c64xx/smartq: use dynamic registration
Date: Wed, 9 Jul 2014 11:36:28 +0200
Message-ID: <20140709093628.GQ30458@sirena.org.uk>
References: <1404898043-1160870-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3307878329053062373=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1404898043-1160870-1-git-send-email-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3307878329053062373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pndui+VhQ7yNUqd0"
Content-Disposition: inline


--pndui+VhQ7yNUqd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 11:27:23AM +0200, Arnd Bergmann wrote:

>  arch/arm/mach-s3c64xx/mach-smartq.c | 10 +++++
>  sound/soc/samsung/smartq_wm8987.c   | 73 ++++++++++++++-----------------------

> +#include <linux/platform_data/asoc-s3c-smartq.h>

Looks like you forgot to add this file to your commit so it won't build.

--pndui+VhQ7yNUqd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvQ0ZAAoJELSic+t+oim9DaUP/Rub7J/qigVTXVlgBHHqPwtY
OrP1G48JbwU9bb3R9cqj3wwEFPI/tpSTgFCzMLcvieWgviwJ9/Zqi9lkQRn008GC
nPCe6uD7HIKqDsdE7XXFOtxFFfRHPXMt3V7t4NvL6F8tPr7gKyghqe1Byq4/YH1S
DE5lUJoHKLwoOYfegvJTK7cZLb1zsSmPRscJt4j8Fhyl+tdz/m1A4YTrF3dFnRNy
S4GGEoCz5ECyEB0ew/NXq8Ud0LA/sjJokWT4fbvD/LWtGEt9Vp+eU6AWxb5v2rXO
vjjBySUqFRXMHvep/JEaBgoQNtagDswksHXk+K00kAnUAFaUdS2Ljc3S7XKo8WUS
xOG9K/Z4LanNF853tdWXC2bQdyt7GRNNYxfGW54H7V+txQACfJU+56ZrEaR57NYN
GeWh/WuRdG8i5qI6GRmFsklE5Etj7xfByVoRcrpvwh7RQ9Yn2+j2zt0WPujtNeeV
QqEVi2DWPkgqNPBxO2TSnsPJoq4aK27E+hSNuOLPu8rj1ZHJrjg69Tuf7v4IVxES
+U3ZimkgZQEC4ZuujTZ/Y7+56E0onw3ej5I6i2OeQDpqqXTpVFp4ZH5FVpZ2J0DE
LGGl5ek5ZIJBKN7YH2EVCtlkB3N/IYKpn05lj51Ym0iTPO7pRBACdmjMwXMArs+K
CMWGYZOBtxdJIt4vrvVX
=5f9K
-----END PGP SIGNATURE-----

--pndui+VhQ7yNUqd0--


--===============3307878329053062373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3307878329053062373==--
