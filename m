From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/14] ASoC: fsl: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 13:19:17 +0100
Message-ID: <20170818121917.cnuosdov4zvsp6qb@sirena.org.uk>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503057971-16033-5-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sy3tgyelnovn6f6h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503057971-16033-5-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--sy3tgyelnovn6f6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 05:36:01PM +0530, Arvind Yadav wrote:
> snd_soc_dai_ops are not supposed to change at runtime. All functions
> working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
> const snd_soc_dai_ops. So mark the non-const structs as const.

Same here...

--sy3tgyelnovn6f6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW20QACgkQJNaLcl1U
h9BmRAf/TRoNlN/UE20RIQWao87+alcv9XKMEnTEifehMwvHRKz5p3CMX6+DOZYS
TCnX42Q23CozxF64ywAbzRZyJUl66RxlNxiHF5sVVxV37NTmuQi1gLZqLrmLfz9t
W3Ul0u5kkrLDC8QmxlshfBTID4dxA5OWdtUi62lYds+16erg8A+zGiAqgJV7a8f1
Oew48OSFfoFw8o96SHxVTDQHwzN6flcWhj08gGfjH2H0VIgqLaGI3E+431PRePzL
CJG34cINEgg4JkV8Txx8QLGd0D6QBjJa1WaamYESTtBhtNTqw2USsj2EtsJsfhy/
MYmy3CJOzlPsnbccCT71tPanabn9YQ==
=MzTH
-----END PGP SIGNATURE-----

--sy3tgyelnovn6f6h--
