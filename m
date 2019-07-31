From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC : amd: reduced period size
Date: Wed, 31 Jul 2019 20:47:20 +0100
Message-ID: <20190731194720.GH4369@sirena.org.uk>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1564402115-5043-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1564402115-5043-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Cc: Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Sanju R Mehta <sanju.mehta@amd.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 05:38:31PM +0530, Ravulapati Vishnu vardhan rao wrote:
> Reduced period size and offsets.

Why?

>  #define PLAYBACK_MAX_NUM_PERIODS    8
> -#define PLAYBACK_MAX_PERIOD_SIZE    16384
> -#define PLAYBACK_MIN_PERIOD_SIZE    4096
> +#define PLAYBACK_MAX_PERIOD_SIZE    8192
> +#define PLAYBACK_MIN_PERIOD_SIZE    1024

Is there a need to also reduce the maximum, the hardware culd support it
before?

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B8EcACgkQJNaLcl1U
h9C6BQf+Oo4ryGKqExrjlr4uVgeaAMIHXAeGfJG+wmHgD6YbMabBcib7q7imVqKk
1npEyRS6jlWFO9jRTVUGfMHhAP51/E/1oNmJB9YllLPq4cuViQUH7ztud3pcN04z
zQ8hm1OtH9YmBfIoABFxYgFd6DI+hn/OdEX4dN4Unv0ppvTQZ0NTCd0Ikok+061U
CacojaF/Z/mrjZir7lXvFuxC9PrG+4/C6FakQC9ApRbewYjxybg+KkG2AuN7CeUK
ZP9ZrbEpe6668ZDm/cpSI4axkP+FCVTKorW6M19AoMbcOWCdCL90D5hhO+1pgv50
CT55tq9iGxYm7D9cLBE0glLW+Ymd0g==
=JOkR
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
