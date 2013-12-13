From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Fri, 13 Dec 2013 12:10:21 +0000
Message-ID: <20131213121021.GX11044@sirena.org.uk>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
 <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
 <20131212110718.GI11044@sirena.org.uk> <52AAF09A.40302@marvell.com>
 <s5hy53phthr.wl%tiwai@suse.de> <52AAF531.8020200@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3443024638464972221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 86293260376
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 13:10:24 +0100 (CET)
In-Reply-To: <52AAF531.8020200@marvell.com>
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


--===============3443024638464972221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Er97KPJOrxRt+yKZ"
Content-Disposition: inline


--Er97KPJOrxRt+yKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 07:53:21PM +0800, Nenghua Cao wrote:

> Yes, you are right. I add this flag only for avoiding the traversing
> dai_link in soc_dpcm_runtime_update(). So you think this work is
> unnecessary. I will make another patch which will do DPCM runtime update
> always. Is it Ok?

It seems safer, we can optimise later if we need to.

--Er97KPJOrxRt+yKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqvkqAAoJELSic+t+oim9DwQQAIv6qhs2wNPH2+zauxi+feH4
DCcG/+uHqYtxmq2E24kHLZasEjcHfi71eK8oCbAgPcUSviSAPcns9cjpm0ovG3Df
82RqX7ixiUBQ9HnHwzqG4/ZrxTS+AlnUKCaFK+Tb3sezxZgrqY/wPJyPV4D/7jpW
jpjDMNrlQUpJ1Gu4b4CfbJt8tJqOk/wRC49MPSAYgFQ2fGbwTq1zqdZIs2E+gwST
aeCb43ziGbpgHM2J7rYjmuAlP8jNhiTbbGIEXXaZ5GLdKCJ9Md5uYH4AiaSyRxUd
RJnYvdnxzFnqZD5bNlpC3AMXYhbqe1E8BAw/aFeGv3k+TX88jzXm4CmH073y0kVK
QGCtBVm0RcjuVP/KxyK90LQsv3OGxrXLaV7WFO5LUTYkMC9qBsVTc7lConzKjPI8
no6j8rMdcBB0tmpe2rewbySSXF/xZY29qs7R3UbqmS2gZTxtxntqSaf3DBOox/y3
+78on8N5PgseIFNNE89BlZRSr4eL7sfNm7j45Ee6MnEyh20tfllKfkzR8XJAtkme
8m0CMPAysmTGphi71KMiLDtWU+cogBWSzt7c8jUmfLn7I5qhMJr1635eaDJbzbZo
xLgQ7WUmgwd45bu+zL+mRLAlg0o3EJUuTFGU5T4qGXW3OhbaWxtPW3/NdhE5lVTp
aV+1c9dHQ9x+ZBRdEDer
=h5n/
-----END PGP SIGNATURE-----

--Er97KPJOrxRt+yKZ--

--===============3443024638464972221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3443024638464972221==--
