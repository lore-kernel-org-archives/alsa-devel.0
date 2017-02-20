From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of
 pr_warning to pr_warn
Date: Mon, 20 Feb 2017 11:06:12 -0800
Message-ID: <20170220190612.ykyguxtclicy5dxc@sirena.org.uk>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
 <20170217235751.GA4125@Asurada-Nvidia>
 <1487377247.2198.9.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7808498271172681144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4822266917
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 20:07:11 +0100 (CET)
In-Reply-To: <1487377247.2198.9.camel@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============7808498271172681144==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ju3l6r467ztwkroa"
Content-Disposition: inline


--ju3l6r467ztwkroa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 04:20:47PM -0800, Joe Perches wrote:

> If or when you apply it, you should
> fix it up to suit.

To repeat, I don't have this patch so someone will need to send it to
me.

> $ git log -1000 --pretty=3Doneline --no-merges sound/soc |=A0\
>   cut -f2- -d" " | cut -f1 -d":" |sort | uniq
> ALSA
> AsoC
> ASoc
> ASoC
> ASOC
> ASoC fix up SND_SOC_WM8985 dependency

*sigh*  Now try counting the frequency of each...

--ju3l6r467ztwkroa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirPiMACgkQJNaLcl1U
h9B43Qf8CZDZfm6oqfoNeLBKZKeeclz178n92w0podzmWP1T5Nbai/1xWHPu6uBg
/DH/XOF8d4qmKy7/BIXDg0XyreopDCqG+g8WHzol0H7Faf1pzbRaM8faAmagRPCX
/fv0wuG4R+mAoGZw3bd6yQk0VUQWHgZqXX28KwD3OY+47zbPloE9Gq6IBNqb1TFx
aFScg5IYULKs/4MEvanceca3py3H/9mDmXKqpeibUp5X/CKYKsYWqzhyjYKSQMnK
Gjb9hFEPyIspnYPaUs1/Le+pCuYM4RRGwqrhCrcXdKxg8opW9WbrWvK8aGKRqY5G
COGO5JBwn8ibCQ0oUS/zU2SxX24ojw==
=swEe
-----END PGP SIGNATURE-----

--ju3l6r467ztwkroa--

--===============7808498271172681144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7808498271172681144==--
