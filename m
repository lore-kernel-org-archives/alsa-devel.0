From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/17] ASoC: imx: move eukrea audmux
 call into ASoC machine driver
Date: Mon, 5 Mar 2012 17:46:13 +0000
Message-ID: <20120305174612.GY3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0012928871190273773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B0D881043F1
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 18:46:15 +0100 (CET)
In-Reply-To: <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============0012928871190273773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVTyp1F/hrbhzAAs"
Content-Disposition: inline


--JVTyp1F/hrbhzAAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 10:30:49PM +0800, Shawn Guo wrote:
> It moves eukrea audmux configuration call from board file into ASoC
> machine driver eukrea-tlv320, so that it gets aligned wm1133-ev1 and
> mx27vis-aic32x4, and more importantly it will ease the moving of audmux
> into sound/soc/imx as a platform driver later.

Sascha, this and the second patch look totally uncontroversial - can we
just apply them now so we don't need to keep reviewing them?

--JVTyp1F/hrbhzAAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVPveAAoJEBus8iNuMP3dx8QP+weQ9OWEKpSObA/moiREFNmt
31D2IdH7ln20r+CRCdgxxDFo7o23Q2AJ2+WtC1dJLMWAYRQ+wBP6U+OT27XVKGcv
H6c2Z3LUo+0d1x7rM88iwuJIFJMIgarNZFKDULJ6aeeaZsHug04KXodeXBhbuJut
R5lyYChMGbeYhtI8DJgPslJmcqwQEUnwG4nlfSLgmJNzQq7KtGuh9Nh6CJJGSSTE
8+WGhHnyp7j2ZZOagVpXOyHJur07c7Jz9saZHLM+dohJsmuFpJrXvvaa4duyPjpK
L7M7hj2KeST4+qEr1PSmhGJIt5qaEy6Gbk0qXtAIKMJLg5tqcuJd98Adui3GkAFd
CxXWWm+J7pvjoI8uL+WeYWN7+HxhS2ZJPKjR8lkLcYglvT1r9hnObbWSSxYGzvlc
wN0OWhXyVmE7CH0iVOvFO5RMY8yRvsVQ0bZGHVNnh/n6ykkSmIIm6ob2W2bSLdVe
n977GnIuSd5RVUmflAeyF00VddKMovKj5p9tS3p1p2c8kqyV5VLzuMRIlXcCzTEF
JQWXvtptMmXnbPmr2ZK/SEOx2icrdFv29bXSKMiQYpf0HW5zO8PDoqsfMIkhPB9q
7yHDr8tdTo7cwLawmJc945hLkgR2t/IqA7hfNUTRIn6GWjVAoCzb9se5Tzo9MW2Q
CGfidcBC7DRxa/8MRUVS
=I85S
-----END PGP SIGNATURE-----

--JVTyp1F/hrbhzAAs--

--===============0012928871190273773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0012928871190273773==--
