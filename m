From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
	iounmap
Date: Thu, 26 Jan 2012 10:53:32 +0000
Message-ID: <20120126105331.GA8041@opensource.wolfsonmicro.com>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201242144580.1998@hadrien>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002379435816258396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12C20103B77
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 11:53:35 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1201242144580.1998@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1002379435816258396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2012 at 09:45:26PM +0100, Julia Lawall wrote:

> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.

This is a really nice cleanup - I tried to apply it but unfortunately it
needs a rebase due to the change to use clk_prepare()/clk_unprepare()
which went in recently.  Could you rebase against current -next please?

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPITCgAAoJEBus8iNuMP3dwdsQAJ56S/crd3AxbmMkzZ3Mw98q
hnczJz2G63Ox7lPwugL9sj1fqFmQjZYuJfwrgqntrSkPuJ5iOVFQrmOAlJS8Oi7X
W2tJUtzZWZKI0B90SglcMkULpG+qkCaQ3CMXHxdkFqEFQ7MJzd609kugWkCJS5ou
gOGLXt0FyE6iwlZmn9nRqrNDjLeECKMfF5BMlAJ72EARWOSMBwsyKvxfUpCwoTKQ
OToQxW2uljtrKu8w907MubWZAWXhSZ7nVVUNd2rC4K9Ri1ssdNKLL04TTxNdGHop
FmLoSb9sKZp2j0op32bwnrZlKxIa7isTocBepW7LZLMMI8iIISt1cYqw/Rmv9G14
EIPiiANQIyZrrkwMRZO8UNlmM+6pxiQg62Ns53UY2vsVJI99DiMcyYXrPUfDvXt0
qILSCMs8xkqSJDxrPcZJyTFP+StuHSs5s5woh4MohUn2Lc18izmayaudT9ni8eL1
S5ngXgV8xzuiGeHCRDz4nzkk3JlRKwlhiWL7oV1Cu40mrthvROPEVaxlJwEfhGeC
cvIdfPYhu9gM9RqCK9UsKVTHEG2MkEkM6p0BTcazEWSUkZ8YsXDo5m6iWU20URXK
CW47OINCBV2PpTZEfO+mTQoQCVXVwAVZPR5GZmRhEzpOwSHinnd5Ce+UOli2rLYI
Teuo5tyqs3JDa+VlO7uO
=yVEa
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============1002379435816258396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1002379435816258396==--
