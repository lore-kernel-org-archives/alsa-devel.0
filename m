From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm3168a: Call clk_set_rate in
 pcm3168a_set_dai_sysclk
Date: Fri, 29 Jan 2016 00:15:23 +0100
Message-ID: <20160128231523.GE4130@sirena.org.uk>
References: <1454000060-8407-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454000060-8407-1-git-send-email-Damien.Horsley@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 28, 2016 at 04:54:20PM +0000, Damien Horsley wrote:

> +	ret = clk_set_rate(pcm3168a->scki, freq);
> +	if (ret)
> +		return ret;
> +
>  	pcm3168a->sysclk = freq;

Since the clock appears to be mandatory in this driver (good!) why are
we even storing sysclk?  Just remove it, the driver never actually used
it anyway.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqqEKAAoJECTWi3JdVIfQGa8H/2liweKOFK+7tHpVIgvnUzOU
eBYiruileaiRXqMxIpvP5ij37w316JFZPCU+kRaGVx3Zjuk3tasiQXrZxIubCuL9
rqH272k5UdRo/tRLhstYFpLJXlUWaXBXsv8Br41nZAavanmOeH25SnrA664WiEDy
KJz4RKv8PAI26umQbStvcPbmIuCEmLBYqQQdhFIH33DYF43DkXUScQ/RzQlf+vMk
XXooyT0A/DLTyJiBgnVu1KtNzoP/6Mw4GXvF0TiOBuCX87hi93bH0dyzBKthQF+v
WitJ9PeRkNHQc+HnuLbzp2t1ctAsfcHoI507aFDMLL4myoBU8ChlzTmQZVWnVq4=
=czte
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
