From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Thu, 8 Mar 2012 12:02:07 +0000
Message-ID: <20120308120207.GJ3638@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<4F57ECC7.1040100@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7381721467070007370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92F7F10BA3D
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 13:02:10 +0100 (CET)
In-Reply-To: <4F57ECC7.1040100@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7381721467070007370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Content-Disposition: inline


--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 05:18:31PM -0600, Timur Tabi wrote:

> I've tested this patchset, and after adding the changes that I pointed out
> in my previous email, audio still works on the P1022DS and MPC8610HPCD.

> Therefore:

> Acked-by: Timur Tabi <timur@freescale.com>

Excellent, it's great to see the SSI drivers merged!  Shawn, could you
please resend the unapplied patches with all the relevant acks collected
and tweaks that people requested just to make sure I've got everything.

I know Sascha wanted some slightly larger changes to the new card driver
so if you want to hold off on that until you've done the updates that's
fine but it'd be good to get all the other stuff merging the drivers
together for 3.4 if we can.

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJ+3AAoJEBus8iNuMP3dkhsP/iprg8KXB6I73zgnJvmlrto5
KPt9a++klLf39Wsoq5Z3E9JzngSB9riTJJhkexXEJZdYveu2Tl+jkM4u/sT2yIT+
TPorVYjOo+N389rX9RzyJyv3pZ1AC0nDmv9L2PNq9iihHoYVhV++WQaEHnwTLLOi
BMwYGsLF/wolAk7Lz6aJJTcU1mGJ0ft8d+WjTHH7QIZn9QVy65WR3tSHzGL2JfCN
LQGDMFmXKgj7FUrMRMpJmHs51tuoPWNiTdfzKCC3s8HOTOKOCCNZ/DNN8OKUxYrz
tgnDpSEjVMQN0LbFyVZlpNEGTdqUeDK3o6b96oPoDjQpSYPQMkmB3EKhfh2RMp+a
rXqXvjGXH6vObhZRzYsndI++RprFE5+Lm0hFUHDVPXes26IDEigOKP6t5Yz86t+O
lukZZuJmm4CrzadibYHsB0mCZstuVPswXULn5pQLJuJJYDbWKp4Z3Wgnff4OB1VE
AoRvP1SmY4+MPAEfnZUNW5N52vm4iaxldWAAzD5QZFG7Ww0xzK8CP5PhGxmSQmIl
yKDBHjnehpF7Pyat4e664XcCDiQsB0oFwD00QKTEanqfhZOPBZ9GBuyQ/HVD6l7z
h1RUmY9C3sAU120LYARDnXQ8hHNbgJGGTZQieSST1VxmKnnmfw6/W4rr/uJNxdUm
4NS3FJt35HS7ur1x+uEC
=JKhM
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--

--===============7381721467070007370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7381721467070007370==--
