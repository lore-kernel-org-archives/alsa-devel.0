From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Sat, 1 Mar 2014 13:49:43 +0900
Message-ID: <20140301044943.GS29849@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1265188349187759552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4AD626522D
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 05:49:53 +0100 (CET)
In-Reply-To: <1393399342-31177-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============1265188349187759552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcSDOt7TZFizttpn"
Content-Disposition: inline


--ZcSDOt7TZFizttpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 03:22:17PM +0800, RongJun Ying wrote:

A couple of very small issues below but otherwise looks good.

> index d62ce48..23946c2 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -54,6 +54,7 @@ source "sound/soc/spear/Kconfig"
>  source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
>  source "sound/soc/ux500/Kconfig"
> +source "sound/soc/sirf/Kconfig"

Keep Kconfig and Makefile sorted.

> +static inline void sirf_audio_port_tx_enable(struct sirf_audio_port *port)

Drop the inlines, let the compiler do it if it decides it's worthwhile.

--ZcSDOt7TZFizttpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEWbfAAoJELSic+t+oim92tIP/3M9W2Vnpu495ds9W2ofs/0O
Yb64n+e4gIF0y1TXute2cR2EvqNdak5QnK86BwSloatgJ44ftRn+Gae4LjNMpgNd
k1qU3lO9O8L4UBL8uOZJsJOqyciQJlr4uQZxqSgGHFjigv6mWwvJ7mowpsCZDUrn
h1xMQsG1q2czUlRKnJKc40WcecCCIIeVIDHfyVjgNUZ4PtKGv9Dx8n8pCVwtrnP+
HAyUrBM4EMaDugYyxaFrr++R6GMq6j8+E3FrgKBJVAU3ijAbQ47lSJRMss6+9pNw
2nvBIIEz2uLtUbt6Mk5vXLw2097gdElZwHto+g1braxOZKW1u7N4Gm1Nd1LZCOmK
DhDASHU0FKEcxKukzWBvDhwbAfjTcDSxUbtRnKVRoPGlwTRZPtegD0r1IM54MFuG
nT9EGikkNyz0ET5KbANqXFQVtDkBOAuYBJOziDim4tkk1UisOX1N+2RRlcfhJHG8
M29GV5LvGFVhvDCzKCZ96VQtb8MTEzM3XW9qSwiRh8urMzATMPAMWPIpeZ/JB8y+
pV6pgPlmYuHWOJ9q/XUrMbn2k0WukaOg7qqgB/707WYaGoeEGqPCbAskG+HEo3Pk
w+pGx+U2NIqbJ9vhMP8QG14JPAF6QOo/YtKJxFClKmgiyB+2bwHuZEiSX1hpLov9
F2Fzqqh9E+F5OTGn5sl3
=u50x
-----END PGP SIGNATURE-----

--ZcSDOt7TZFizttpn--

--===============1265188349187759552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1265188349187759552==--
