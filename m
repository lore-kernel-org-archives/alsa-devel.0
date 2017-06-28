From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: AMD: added condition checks for
 CZ specific code
Date: Wed, 28 Jun 2017 19:05:39 +0100
Message-ID: <20170628180539.3uns3nudnjrjsx7o@sirena.org.uk>
References: <1498235706-31111-1-git-send-email-alexander.deucher@amd.com>
 <1498235706-31111-5-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5619583067408325825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83D93266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 20:05:57 +0200 (CEST)
In-Reply-To: <1498235706-31111-5-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, amd-gfx@lists.freedesktop.org, rajeevkumar.linux@gmail.com, dri-devel@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5619583067408325825==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3basztfibqqsyj62"
Content-Disposition: inline


--3basztfibqqsyj62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 12:35:02PM -0400, Alex Deucher wrote:

> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> index dcbf997..e48ae5d 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -34,6 +34,8 @@
> =20
>  #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
>  #define MIN_BUFFER MAX_BUFFER
> +#define CHIP_STONEY 14
> +#define CHIP_CARRIZO 13

These defines are being added in the middle of a file but CHIP_STONEY is
also used in another file in the previous patch (and apparently
extensively throughout the DRM driver already).  This is obviously not
good, we shouldn't have multiple copies of the definition.

> -	} else {
> +		if (adata->asic_type =3D=3D CHIP_CARRIZO) {
> +			for (bank =3D 1; bank <=3D 4; bank++)
> +				acp_set_sram_bank_state(adata->acp_mmio, bank,
> +				false);

I'm not seeing any poweroff cases for other chips being added, and again
switch statements please.

--3basztfibqqsyj62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT7/IACgkQJNaLcl1U
h9CiHgf/aDVPidCe1q7eVinU4Cctb/nC+GGZu2nO5+3sMDsufBcRsCs1kUQguwPA
1OgpVSc6G7yaEennESTrsF16FHKxbFnqNqnnI9zDY5a481SZ3/IvXn4t++WItz99
MLqpIgR7aHbpxWVDD05CyqIznT+CkMyXRxFXrsuQ1cW+q9PfhMgGCsly0wxon6ZM
HSsKfPrXz/5OI6aEqrf9gJ92KsGybRWAyw94oeP//l+WoxfF8rYZcnqRI9JsAp1E
h7a8JdrjgHXE4VwfXg6aZnz1/J/CAMTRIfrDo3zJXVaYbIJYGk10mhxn3wn5ZLWe
6U9wGBNw1Aa4Y1IJHyjkAw+Plffd+Q==
=QBut
-----END PGP SIGNATURE-----

--3basztfibqqsyj62--

--===============5619583067408325825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5619583067408325825==--
