From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
	iounmap
Date: Thu, 26 Jan 2012 11:27:07 +0000
Message-ID: <20120126112707.GB9401@opensource.wolfsonmicro.com>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201242144580.1998@hadrien>
	<20120126105331.GA8041@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201261221420.1851@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2075055664459560082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90DB4103C68
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 12:27:19 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1201261221420.1851@localhost6.localdomain6>
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


--===============2075055664459560082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2012 at 12:24:21PM +0100, Julia Lawall wrote:
> On Thu, 26 Jan 2012, Mark Brown wrote:

> >This is a really nice cleanup - I tried to apply it but unfortunately it
> >needs a rebase due to the change to use clk_prepare()/clk_unprepare()
> >which went in recently.  Could you rebase against current -next please?

> Could you tell me in more detail what the problem is?  I pulled
> linux-next and regenerated the patch, but got exactly the same thing
> as before.  I do see some calls to clk_prepare_enable in the code.

I tried to apply it with git am but even with -3 it wouldn't apply (-3
said it didn't know about the original blobs which was worrying),
looking at the logs the clk_prepare stuff seemed most likely to have
overlapped.  Perhaps your regeneration will be enough.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPITh+AAoJEBus8iNuMP3dZFAP/ipSsF68uDxE0YiYLw/IZSLp
yUt/QjibSqz2nqPOu5whMFFCQY/MNe3l0gcPa+IpaUVZB/qBDGxfnh+GWZJR1IH4
KTOyG3OUA5NZVMpIRCJj5sY3fJ1J65nKBzNRnrCsFrLAErwZOeJLUywEj+TzprZp
jT3nxEmkfJ7xupbYJmXzpJ6yf+G1Po+4hBWcph/VwJGgchzxCrsmidfczkJes7D+
PZtlTaLO5GMahTzaGoLGtRBJ92IEZerGg3+8LkdZlHdePP9qH9ANna4DGSecs0kz
VfMyqpHAqOmsutpHt6WKHOHZEyd0G+XOb6F0YWDLlmlC7MyMEGAIc/vLXyJHq4fB
2gWfZAYDkYDFcmo2iFgVMCBAEH4caugf8et5UQWEL4ENeye47e8qlBWMkAKZXMpw
RCKXBq/5iFeXgaamN3LlSv7elwUzNcis54guEjFTJWttWGxHi6qkTer5oIPJURHa
uojHhONW/IKd/ob5nPdHNR7i1gRNc2oKdXDj0tMWq3B+RB+/zeM3lws9P33UIk4H
JnmQie80bPQgKjCuMDd0Z7HoWhQEwklQZmj5JNt8KHLSQIER9Y2zbf2Bx5Pl/4ou
5U8J3lH1X86xScVBMExq8UcwHEsHlzhXpZCs45h3d1wHu/qIhYy5vy7MifN33mKr
8mzbPVTHsTIdVqq0ZFYi
=EhiZ
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--===============2075055664459560082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2075055664459560082==--
