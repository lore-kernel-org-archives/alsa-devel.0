From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5645: remove unused field in
	pdata
Date: Wed, 6 May 2015 18:50:12 +0100
Message-ID: <20150506175012.GE22845@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8345533290893489688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66D8B26070C
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 19:50:17 +0200 (CEST)
In-Reply-To: <1430833322-13531-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8345533290893489688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y0+U+U1OM05jSAdB"
Content-Disposition: inline


--Y0+U+U1OM05jSAdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 09:42:01PM +0800, Bard Liao wrote:
> We can know if dmic is used by reading the value of dmic1_data_pin
> and dmic2_data_pin. Also IRQ must be used if codec JD or button
> detection function is used. So, dmic_en and en_jd_func can be remove
> from platform data.

Applied, thanks.

--Y0+U+U1OM05jSAdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSlRTAAoJECTWi3JdVIfQL64H/jV59wai6m/k/5J7NOuS6fjt
CtkggkUBmCl1C42xHYcvZUh+9pOsBd1AE8X4TLUSMa985V4QLmBG3isxpxp0xe4i
eMLXHBGi5YXFGmunUboadHqbUWqzbVoASlDXH6Mq6GEJCcnxRpdvIEk1G4TaCnZg
CC0RKTMHYg3ifZ92mR5PKhxRGrtK04n/nXK56NTzXFyExYpDz64cDuaWc44GXzhA
WjDOfjaURLZxaqy3VOTZBflzcupP+0WOeUY7oizg09ZnJlStxSSH0biFH+1IBuaJ
EEBRG6YeGAeFA1wZtLtLR2W65fb5Vb9DZ6sC6LyHK6M//NoLtSMt1Fo2eBaFtuk=
=OAin
-----END PGP SIGNATURE-----

--Y0+U+U1OM05jSAdB--

--===============8345533290893489688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8345533290893489688==--
