From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jz4740-i2s: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Sun, 12 May 2013 22:09:21 +0400
Message-ID: <20130512180921.GB6836@sirena.org.uk>
References: <1368382059-4175-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8250298321207569174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF1B261AA7
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2013 20:09:25 +0200 (CEST)
In-Reply-To: <1368382059-4175-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8250298321207569174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 12, 2013 at 08:07:39PM +0200, Lars-Peter Clausen wrote:
> In preparation to switching the jz4740 clk driver to the common clk framework
> update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.

Applied, thanks.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRj9rOAAoJELSic+t+oim9p8UP/RV6JFkAPCi7ZCDphNRd8v0i
Xm3kXI84AGnCJLChix7gvxi5hGUybAZvEnX31HeG4aqS1yFWU1JJsPZPyEQrsrXe
VR1Oi+zYuKheBRpAawwI2RHvicYmvtAedE+NKhxWLyuLQ2WDpab6w93UG8e3lQ6W
ZgxTr+e2NXw2RUe3RcVZcxR1GedMa1T5HhyCuIv5LcYvf0Yz2zcbuRLJ0GDvR0Si
pA77TYadTcHOB0RHzQ0iXxv4DrldhbRAt/6+hk5Jrvl4rfZNFypIKG1cs/Lbv1zk
EqNJ4yyQUgDzLYtJz4havvQccFRDMdmWig9KCj2KvrnVg4ytdMfKoAKNYwCoKAGJ
+Z9g92mCLTnWaKqpaD9/cKfS3zv/ChF/sRzVFKfZ7SHdLSKU1p4MzSGuKcqSzueQ
IGsLckVKDNQV8fYgPPxk70cF/taqw9HwRsFTYuV98IHTjS7phLXFEgOjKiE3ebMg
4+hXzHzIYb2XeDErM4JXE1EKwYlYbYU034+IxA19BDuTu5SRcDljCoUfMB+IoKGQ
kMSnAyD6D5urq56wR+TKp/E05dP8HTLGhJCjMskrF9dNT3SiVA6TPsTONZOeYj3m
qheA9LDThlRbh9gURAwS6xt1TPFgKheY04wMV+wPWBghJB6E878JqDONHyxvAbXM
KdISWSmeT62Y123kFZxl
=SHsl
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

--===============8250298321207569174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8250298321207569174==--
