From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Thu, 5 Jul 2012 10:38:08 +0100
Message-ID: <20120705093808.GJ4111@opensource.wolfsonmicro.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704142745.GC4111@opensource.wolfsonmicro.com>
	<4FF52948.6090904@ti.com> <201207050832.16750.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7786985917063114102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD98624466
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 11:38:09 +0200 (CEST)
In-Reply-To: <201207050832.16750.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vaibhav Hiremath <hvaibhav@ti.com>, "Hebbar,
	Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7786985917063114102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8D3PigL67BfDl295"
Content-Disposition: inline


--8D3PigL67BfDl295
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 08:32:16AM +0000, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Vaibhav Hiremath wrote:

> > Does machine ID still gets set? May be I am missing something...

> No, it doesn't.

This is a *really* unfortunate decision, BTW - it means that if your
bootloader has a device tree available it needs to know if the kernel
it's booting is DT or non-DT which is just generally unhelpful.  Sadly I
don't hold out much hope of being able to fix it, though.

--8D3PigL67BfDl295
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9WBQAAoJEBus8iNuMP3dRcwP/j1e02Qg74hQnvIsBAFidKAJ
fZDHJtrRD7p0cS5B7KJrlXXTObhrERfbLO+q/5N2MvQrqCviWPJKVx/i+HM84tNi
TN3QHHO+ITBD/OWQ/R7oG2hUCsISXeNG4iWnbWtcoAvzjjMykxSLlNhqF+uXFzSa
+oO0LpTlfieiG18DGOoFf/2MCEa75KiRTAEB6pqJigZniSmQ/m+XnGneVGrEteR/
xHQPj1pr6xC88KqALetfR/iwIUR5P0dApGCnmOWmRVjh1eCJ5H2FITAL6EJ+u0zv
A380Mp+ksV8VVJVQRb2A76knVzBKkZN4LCd7pCRTePsozR041C8JP3JBRYA5Hb7q
+i9IMC3FKutPP8xLwg+rde5Oslli6Rjywhdhhnr+7Iw4T8SafJ/sOCt8RAO1/HUy
h/G/iafLTAdNO057gn+8+G4N1i7Sy80W7cCQp7qEQiye/Jf5H5M7NgkE8Yui/BDt
PLNeU2tgddtVFXeLy7OQ/p8ara4o9iDX3WKGxA42si4rINWxNYk6H738CdqdfeNx
xdsUI+ZYtntN9MJzUJNJUiJ5dONAZPJNy7BC2fvZZXS6DYuHiW8NdyLQEnsNzP9G
bzqcEqEdyWMikb7k6uhAIwpx3yB/L3fwoHSV8wnpuVvr50J1bidfkMaoC9E93iyH
7Xq4W0wClmKlVBD5oeu2
=bxwV
-----END PGP SIGNATURE-----

--8D3PigL67BfDl295--

--===============7786985917063114102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7786985917063114102==--
