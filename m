From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] sound: q6core: Use kmemdup to replace
 kzalloc + memcpy
Date: Mon, 10 Sep 2018 15:19:28 +0100
Message-ID: <20180910141928.GI5856@sirena.org.uk>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
 <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3801373183499756355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D50D2676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:19:32 +0200 (CEST)
In-Reply-To: <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============3801373183499756355==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Content-Disposition: inline


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 08, 2018 at 04:36:19PM +0800, zhong jiang wrote:
> kmemdup has implemented the function that kzalloc() + memcpy() will
> do. and we prefer to use the kmemdup rather than the open coded implementation.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWfW8ACgkQJNaLcl1U
h9CyUgf/XqtV7Eclu39YGeJCdlYnt7Hq1XT9fgf87Qtf3o+Z0bBqDZQqhRKHusUh
Jz016WEw/y/szYZFnsVofz28QnFv7tEt6lazhaKyM5d++8BliGvbHZoeXobbWI3C
Z1gMCl5TfPL4JDVwDgTn2p70azBShev3+wygQQ/etQfO7iEBEaZltIPFDwQlsDHy
TG0XHCdajCOOtbwRPPnm1IOmcZbNOMQ3D6YcQ+IJwKOda+LC29O0McDm8RhoXvVD
RjUXKMSo0G51U5PDT37gsJ/S1Uhxr28aTl0h164WKQXyTdCputwPrQ1h3nIVvsWM
nenQ5ghluDeP3aYVSmWMN93sqtPqjw==
=OELS
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--

--===============3801373183499756355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3801373183499756355==--
