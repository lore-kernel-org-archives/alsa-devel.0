From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/8] ASoC: wm8731: add rates constraints
Date: Tue, 30 Jul 2013 12:29:49 +0100
Message-ID: <20130730112949.GP9858@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1374867270969735201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E97202651DB
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:29:53 +0200 (CEST)
In-Reply-To: <1375180329-4860-2-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, patches@opensource.wolfsonmicro.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1374867270969735201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mdlWJHP8WUkO1oOu"
Content-Disposition: inline


--mdlWJHP8WUkO1oOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 12:32:02PM +0200, Richard Genoud wrote:
> Depending on the mclk (or crystal) selected, the wm8731 codec have some
> constraints on its data sampling rates:
> e.g. with a 12.288MHz or 18.432MHz crystal, the authorized rates are
> 8KHz, 32KHz, 48KHz and 96KHz.

Applied, thanks.

--mdlWJHP8WUkO1oOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96OpAAoJELSic+t+oim9KD8P/jufnid8JfAwCFurbaWmciex
ASQ2UuNfKZxhunDX0IdQ0byCdXA56HRgJap9zhWlE9YrlAflPhcseAO8SkhPaDoB
Bcxgtc3Qhwq4HhJz7sux8fjijsDfiFqSL+ZaJG5GGJTW6tNCu+SnhtGcj8zztYyw
hseY5H9Us/fKmMbXcWqg4U9KpPVCi8V1U6oEMlGTCLHBKAJGtLYq//LaC8Gdenc2
xW8568EeylLF9rOPiB8xtvDEO4arbd+xIWQLJLG742iERJyI8r0yx7NKkQ4+m5ek
0mDOG1ZpwArGuMztzrXDIw0RO8TKB570pq1Z4xz1eMWqOluONEY+BXVBP466DmEN
ORryiBQcSXhfQzgIZHduTqWPlKUapwsYuwif3ODvPmKTxagzFt1gQe9zrgKES2mG
Lx/6TfDjVlW3u64L/5sK6dSEE9HeX4My5ehr8oxoNSaZpLat+S+bPWdi2YZnbYGE
1E55WN9UMH01FtxBsAsdCdDBVZJm1FNvqGwfgi6lQYE8b9RHNYIuHB0kLu2Hsmia
s9r0awsUtdjGreC1nD3XHiB24PlFGF3rm6koMF2cH39DBF35aTc6r9bXQ1veP4qy
gNnUs0uiVKWG1de1bc/QM+zWTRu33pgAZm29hvWvbMIeezdDcx9/w+oTOFhLDDFd
+bdN/0oqyy76wTWOGkKq
=urka
-----END PGP SIGNATURE-----

--mdlWJHP8WUkO1oOu--

--===============1374867270969735201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1374867270969735201==--
