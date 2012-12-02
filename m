From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 14/14] ASoC: wm9081: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:06:07 +0900
Message-ID: <20121202040606.GN17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-15-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3925498929904025773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E11B9264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:06:11 +0100 (CET)
In-Reply-To: <1353930587-12907-15-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3925498929904025773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z1Z8UV8BNhgCynIS"
Content-Disposition: inline


--Z1Z8UV8BNhgCynIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:47PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--Z1Z8UV8BNhgCynIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutOnAAoJELSic+t+oim90G0P/03L9PnGCjCrhlHIDcKMEJyh
/hwoX3K9+e7vW+vduLod5vLKsxvMhLtRT2dgxvAHhX7p43K7CWhft1IXThNtMZso
bYLkGRroJ+pVGooSK8dGDy2k+M9JsDdusk6vC9PSJCnJJP/en4ZTr+a5H+4bIw08
Cnyjpk2H29jQW1xvPMDcc9YNi9jZ56XqPmGP+/oZ9pKW8pM9uGw2XJTtpWNgFjvu
AFISRdU++tlJ9is5kZXe3/reNmFfyWj7RBSQeCyx3qjGgGJcD6X0KXY8Xabk2dDw
FiHiv2KD02rYUKqNjQ7zqiUKoop950yOjE8W8wOm/A5p14LkOcNMGByGr0aS9gJd
d5qheC5VzKvXGiW0cg5wyYosttHw2lF+Teji/hoIH19SeAIPRVctqQYI3NQZ5ot0
ArMzoMQSRMrqR/FuM2iW0yuiHWRGFUtCf7Wl+Mqkzy8lOYnCOygCiwk9PeKFyjx+
M4Py8NzCwDMfoller2RikNoP8hTe9Q3qjANFtE3chASHNJS8fgzt5dWOpkACkvuD
OUvNojcfdLkkILExDxHpO1/W9+sAmyVWwVRPQhq5ajRoLNVe4CtKK75Qg3ihKnEt
UdlDF62SL3G72rwpCj8ttxvPQVNcldTdKRLBumz+4LA3LLxSCgj4HP4HNtLCJnHL
pOiMVlq0A7k16znrqoLW
=SWqy
-----END PGP SIGNATURE-----

--Z1Z8UV8BNhgCynIS--

--===============3925498929904025773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3925498929904025773==--
