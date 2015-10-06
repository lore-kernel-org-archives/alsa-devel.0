From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add the HW EQ for the
 customized speaker output of Google Celes
Date: Tue, 6 Oct 2015 11:39:51 +0100
Message-ID: <20151006103951.GI12635@sirena.org.uk>
References: <1444098005-25968-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0950466557937460677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A22ED2652E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 12:42:12 +0200 (CEST)
In-Reply-To: <1444098005-25968-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0950466557937460677==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/A+0zda39IeytcGG"
Content-Disposition: inline


--/A+0zda39IeytcGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 10:20:05AM +0800, Oder Chiou wrote:

> +	{ /* EQ_GOOGLE_CELES */
> +		{
> +			{0x1c0, 0x04b8},
> +			{0x1c1, 0xfd02},
> +			{0x1c2, 0x04b8},
> +			{0x1c3, 0xfd02},
> +			{0, 0},
> +		},

This looks like binary parameters for a DSP algorithm which I'd expect
to be exposed as a binary control.  Userspace can then set whatever
parameters it needs (perhaps after looking at DMI).  Adding Dylan...

--/A+0zda39IeytcGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6T2AAoJECTWi3JdVIfQUIoH/ixeVg0e0AoSa5dGRbYVgq5T
XbmeVaS+3yaIdoTTTxeTsvjhaQTA09RWrvcP1W0+bXDtE5fNi2eDwtZVkb4c/rVp
/QTFp45l52Bir9XNhIGxsIAiFabRzSFioFJbvnm15hVFE7YwXojWsDDhPBgTVrc5
t88B/Dl6JEch4zpz7rzvKhFVwVo8wkw84pdfreaRY8GkHZIBH4B8E0Yqu8xQGclZ
0SoY1wpfwgA8hlFHNHLvLB8XZesMmPBcmPEJZwaSW3iH668R/4AlDfiZ7zj9D2Cq
xMxhDxnZxEAcMoJ5ITJdsT1CPSu5eRDlCdN1yOckZjbqve4upApUhQNNqjzsDSs=
=2+Q4
-----END PGP SIGNATURE-----

--/A+0zda39IeytcGG--

--===============0950466557937460677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0950466557937460677==--
