From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Mon, 5 Mar 2012 16:15:20 +0000
Message-ID: <20120305161520.GT3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
	<20120305144920.GR3224@opensource.wolfsonmicro.com>
	<4F54E065.8060905@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5210643355458912857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 428B324498
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 17:15:23 +0100 (CET)
In-Reply-To: <4F54E065.8060905@freescale.com>
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


--===============5210643355458912857==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbZGpL0ScFxCd8mt"
Content-Disposition: inline


--kbZGpL0ScFxCd8mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 09:48:53AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > This doesn't seem at all Freescale specific, it should be a generic
> > helper, and in fact there already is one - the machine driver can set
> > codec_of_node in the card structure to point to the device node and then
> > the core should figure out binding to the device for you.  If it doesn't
> > we should fix the core.

> Can we do that in another patch set, so that it doesn't hold up Shawn's
> work?  All this patch does is move the code from one file to another, so
> it's not like he's adding a feature incorrectly.

Well, it shouldn't be much effort - instead of removing the code just
delete it mostly - and there's other issues that need to be looked at
anyway.  There's also the arch/arm stuff that needs review...

--kbZGpL0ScFxCd8mt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVOZ4AAoJEBus8iNuMP3dLMsP/0g+MV/mbm6DQpKlv2QIFgWf
n2fyQOsTLpLLlrD3EQfWuHLm84v6hIEg0RYtE0Ui9qXn6N3fSbDivYVgHiAKA+gJ
xfY/A9JCPwdNY48SvdCYb9sz0tOFUr5ZwTXlpoyBa5OB5soq+VPivI0TdVX8QmT8
xePFBcBETQQv2dUsGLDGMxbEz3AacQGKxx7CDuwm7Sn31paClRTD/hWoHLdaiVta
nfftqhLXymohgEMQaXqKbycy0pLVPbNK/J4fjUU3ZyTwbnW5WYjqKFYrq7Pfjmvt
+9gkyvLB1NqbY+EiZY5mMDfAUJUlltC4d94NrPz9lGxLLZjNBjKdIu36tfHP26dK
G/hjV6yCFaJf6q6/lYiQvvL8OBip8ZsE2qT1UpogUcSqxOBclNKGAVn67RYI/gMv
F0/Cie855FbfMjCUc5slNklugHd85J/gUxR5YeuDqbqCAwD34QrnSb0aC4Y4dv5V
yzSUYsVKbj4lCFqKvfmvKvQriSIabREpzX2ft+j+XaKWViBUagBTzYTWBN1RlZxl
myfJctfKg5iouljLhOBdmPawTjBKUpTun2Zr0eYp0aiFbxW08O6LdD5rac1LiiGW
d1lnRBdVYwl5O/V8D9QoOY4vP5qI0dAH/uszPUEMdQ0kah4MY1KjYYVyZQs7+qth
DHnS+iKQooLo77Gn4hY0
=IYwx
-----END PGP SIGNATURE-----

--kbZGpL0ScFxCd8mt--

--===============5210643355458912857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5210643355458912857==--
