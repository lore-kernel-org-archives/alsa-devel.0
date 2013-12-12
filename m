From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Thu, 12 Dec 2013 11:07:18 +0000
Message-ID: <20131212110718.GI11044@sirena.org.uk>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
 <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9126381326586899492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D9A260859
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 12:07:23 +0100 (CET)
In-Reply-To: <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nenghua Cao <nhcao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry Zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============9126381326586899492==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2013 at 02:56:08AM -0800, Nenghua Cao wrote:

Don't top post.  Please also fix your mailer to word wrap within
paragaphs, it makes your mails much more legible.

>    For common mix/mux which aren't related with DPCM, it doesn't need
>    to do DPCM update. And it still can use the old controls. But for
>    the mix/mux which impacts fe<->be link, they need to do this works.
>    For them, they call use the new set of controls. I think it can
>    make our code has better backward-compatibility.

How does this improve backwards compatibility?

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqZjiAAoJELSic+t+oim976EP/21YmYVGm8yWQrFY5yR3Nb8W
09BYQIHSScaISeCCsSDpbeOm1W5EXIN70MNi5zBxBS7htn+tiBGLp23+0HrwlF3a
V0X+eABkHKQ6fD7ffLfvcZZ8vBiVhJDUCwu1Gy5RVzxVmUwXO/9EuN9WxLVTVIfS
nAGWuIqWbFi0Ov89uv30apoAzVIF5zaeeIbTAUTQmwu/fEVAOloPMhiWRg/dE3/N
rAOwNf3Frt/Lrd0BAYti7aPkrTSghBDVjdQra8sYvjsHvP8uTdFInxhxE45TpFGP
5vD1uAYZ+8c5hC5us0EZFoi5ILii8z0GK91hFPwoALt78hQCTm1dy1DO315ETSUA
llxdeTQiTsVlnFC6T1Z3IMnDxMj6x1YcNyFpTrmjF6itFqhRsVRlSe8Escw4I3yM
XYvD9yqgoU1Noz+Az4lTY3AESKXAfGTb8ocb4CQqwHq2JNI4qp54D4AzT8uaI1Ft
bkFQoY9csET/iIDGRGrGkiw0w7Ub+mpaDLDIs268OzQt//tlbhPoKdvOD8gRLQT5
6GD1h49iRuDZdE36fDGRtybbfVmPqx8pVMM1d8nhVnMkaQdTohLExRwH+vTqcVrm
XCvUAFoDeZSvGn4wxIbw3oBHB4bqj9pghdmgKCE884c1XeXH+d1iUkC95aW7TiSQ
EreGCkxIy0It3bO60jyV
=nquc
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

--===============9126381326586899492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9126381326586899492==--
