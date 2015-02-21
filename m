From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5670: Add disabled item in
	dmic pin enum
Date: Sat, 21 Feb 2015 18:31:02 +0900
Message-ID: <20150221093102.GE6236@finisterre.sirena.org.uk>
References: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6240191861624784462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04CFC260638
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 10:32:05 +0100 (CET)
In-Reply-To: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6240191861624784462==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2015 at 01:59:26PM +0800, Bard Liao wrote:
> Currently, we will configure dmic related pin definition if pdata.dmic_en
> is true. However, there is no disable option in the enum. So, any dmic is
> used, all 3 dmic related pins will be configured. It may cause unexpected

Applied both, thanks.  I really appreciate the much better changelogs
I'm seeing in your recent patches!

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6FBWAAoJECTWi3JdVIfQUAkH/3O5l64G+C1e+f/GIpgQkVgk
Q9+OU4I12CyYT17saQv9mmgnKQ/9BvqO8m6yf3DHCAA7CKYPvgU3ymjoMZi6Z1yg
qPLpFsP18Fl6vD8peGrXQuYAC+vC3I5absloDjkvQxeYKJI+ahpIicJ+rytdfHO2
1J7HIrKK4i1GhA7Nitd7DSRwbDV06elf+LimL+A/OLi7UP22cZ/ZdxIphPhNb0uP
pN9oICPBwYbw8oNxwRlb2cQfONyW44d8w9iP/lQo05sFVzjFklP7K0uFN6ItfE7/
SggUniIhQe79sqTE/qHVEzu7NvHJkYrtVblbqMWoOGdXzesQvXoQarNa/MlWpyk=
=gjQK
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

--===============6240191861624784462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6240191861624784462==--
