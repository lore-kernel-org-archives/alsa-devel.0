From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: rt5645: Wait for 400msec
 before concluding on value of RT5645_VENDOR_ID2
Date: Wed, 8 Nov 2017 18:09:57 +0000
Message-ID: <20171108180957.ddcdyzu2fschypbx@sirena.co.uk>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-3-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5686624506919616375=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA4722674F8
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 19:09:59 +0100 (CET)
In-Reply-To: <20171108172404.19118-3-alexander.deucher@amd.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Akshu Agrawal <akshu.agrawal@amd.com>, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5686624506919616375==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urmjieozzwlpfv47"
Content-Disposition: inline


--urmjieozzwlpfv47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 12:24:03PM -0500, Alex Deucher wrote:

>  	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
> =20
> +	/*
> +	 * Read after 400msec, as it is the interval required between
> +	 * read and power On.
> +	 */
> +	msleep(TIME_TO_POWER_MS);
> +	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
> +

This leaves the original read in there so we've both got the early read
(which might upset things potentially) and the delayed read.  Shouldn't
we just be adding a msleep() before the existing read?

--urmjieozzwlpfv47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDSHQACgkQJNaLcl1U
h9BTtAf+OO9TTN3brKpilJG8nEQywBQGelHzj106J7XvdEi8BQB0lefEYlapDqGs
2xBZYE35GBGVBTCKndt9rAauKY3I+cYZjkaxvesI7JGVDrzopDKwrJAC0BfV3cUo
/vtmgGNVmgDx12PpuODcdUFnSoCECug8Z1tdLgbatYGwhHnGUt3IyKN/BnhXWHtY
eS9TbZZFN/XJXBqHMCKHVCl5g1lm4JwrAy7x2jSWzbtbJHnDlGBuZN+Ov+inxGNE
4hvVFLCDw1K0nZYuzzOgoA5E9geYVEqfmonkcVmOP97Hqi8d6GEWo/0OzuiNfRSH
qSYSHvO6JqyvOVUTPjcpfQkf0F6jjQ==
=mGwq
-----END PGP SIGNATURE-----

--urmjieozzwlpfv47--

--===============5686624506919616375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5686624506919616375==--
