From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/5] ASoC: dapm: Append "Autodisable" to
 autodisable widget names
Date: Mon, 4 May 2015 13:04:41 +0100
Message-ID: <20150504120441.GK15510@sirena.org.uk>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430480247-28753-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6808851017020338804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2BDC261740
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:31 +0200 (CEST)
In-Reply-To: <1430480247-28753-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6808851017020338804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 12:37:25PM +0100, Charles Keepax wrote:
> This makes it a little easier to follow what is happening in debugfs.
> Additionally is also useful in facilitating work to add autodisable
> muxes because the control name is already used for the mux widget and
> thus shouldn't be reused for the autodisable widget.

Applied, thanks.

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2BYAAoJECTWi3JdVIfQBhMH/1n66BFBMVV7Q/c3Ybu+aZNc
woJx0i2SbpJbrW+QuE9JyoMdsDxf93h2GrK67cgo/4MmAO0vy1TTNsGFn1WZAjxA
trSmLGMfK1+l4IF6FjwPYlWu8oOIc7e7DmUjg05BEez3yzzsPhsD1DNY3d3Xujep
oZGyH+MFbHO3qgDr0IJK8TfhJfJiFsWfXZAarb/7XViM+bfw05mRmTaoy5J0F+FP
8/IANHFeBkv6U85iwda4Pkqu+MPttN3cqTtqm5dvYRskVnFWae1oNi+bA6/tUpUS
woU5p3osX8W63m9MSz/4xG2zw3j8FXgtYVxVwA/06+On072mzhKxrcCdHrUpjWE=
=wp+d
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--

--===============6808851017020338804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6808851017020338804==--
