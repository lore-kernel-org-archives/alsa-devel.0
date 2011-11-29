From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH v2 1/7] firmware: Sigma: Prevent out of
	bounds memory access
Date: Tue, 29 Nov 2011 00:12:10 -0500
Message-ID: <201111290012.13051.vapier@gentoo.org>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4311294361241402985=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 2256A103940
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 06:12:13 +0100 (CET)
In-Reply-To: <1322469860-8210-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============4311294361241402985==
Content-Type: multipart/signed;
  boundary="nextPart1773647.zGVGVXDcfA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1773647.zGVGVXDcfA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart1773647.zGVGVXDcfA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO1GmsAAoJEEFjO5/oN/WBgoEP/3to4cwscxu3B6V4PryFIaEn
5jLDTAxx91oVdVzVlh20f8OeEbErEaGsACP7W0fy4TxUMzl7ZR4X7o+YS/t7xThN
svKDKSIVDDnP5EvN6aBP2ad9fYOma19W9wrEz8/3tDFTV57WzMdDSGm6N5agOY1G
WtkFh8s7PoML+oqp2xT4GrK0cG3UEeeaUid/0A9o6A2UWLnjfS/U0Zk32AaviH8T
HpWKP+pKIylSlyYBML6XS+P8TWNB32AgvBmlOnTVGC0qo9s75bKLEDFZwlT7cxYm
xhpZJz1FRdY/7I8Si21cdWhpZloopxM+hX236CbvXg+70MPNG6X5yhIJgKCKAzmh
DPFuxvKnFlusto6YMMt2uDDqTdXm66oTXF1ndUA4T31dQ7xIWCqc2FrgJ1PTROKi
KQd9LR8Uvj7Ri2VHanezW3CFLMvE1B51NArCgrlmdxIgecFPEK8b2wirpNprKlPB
0wmzP81N47QTzDPuGcm85xlPzl0Lb6lJ8CdQZQD7v1AWAIhcrIn1XBEvKLf1ebnV
pEjl3K/DoBC91OUFK4fl0lQYLdfrFFngMUdUHFlOxHqMfHLoKwIW4nh/3E2l4MUP
Jhp0Pfiist0WsB/vqsTkMdUoIwAQWBaYyHnN30ASxCRsy6iKiD2iZrIw3d0FGnPw
Sne8WvflGrAjvnh0dnqm
=vLvx
-----END PGP SIGNATURE-----

--nextPart1773647.zGVGVXDcfA--

--===============4311294361241402985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4311294361241402985==--
