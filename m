From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: Use ACPI device for
 Baytrail PCM buffer allocation
Date: Mon, 12 May 2014 23:10:50 +0100
Message-ID: <20140512221050.GB12304@sirena.org.uk>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1399643264-7669-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6037366326688910182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5900A265114
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 00:11:05 +0200 (CEST)
In-Reply-To: <1399643264-7669-2-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6037366326688910182==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kdw1D5uTaq0Ogcxz"
Content-Disposition: inline


--kdw1D5uTaq0Ogcxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 04:47:44PM +0300, Jarkko Nikula wrote:
> This follows the same idea than commit 10df350977b1
> ("ASoC: Intel: Fix Audio DSP usage when IOMMU is enabled.") by using only
> ACPI device for all DMA allocations. Since DMA masking is already done in
> firmware loading it can be removed from here.

Is this needed as a bug fix?

--kdw1D5uTaq0Ogcxz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcUbnAAoJELSic+t+oim9ND8P/2x67t+5wj+qA4Hq3QwNSjD2
J4VaYvzbq583plZxSVNKGcCe++FMnjDpFX45glvCSzZuAtAYEOPL6OnkT7OpkwS8
vxP7EcgTc++ev912KnoVXV+TkiIWrW0MhzbuLPf45PDvSremdnyV/ZjOyOBm1BPd
aDHA+y2+xf4Tc+B3XGSGGK+MYJCO106xBGs8tPTyrfTKFfyQp0IB03Boxu5fVY8k
4BD4ohqtbFYcd8WmFJVbtorUxcKUKqAhbz6PwaheWGLRuwKvrXX+wr5/krBPFPm6
Q+XfZxLh8jOQ2sUTsbngFFrYoio5JwazLBfvcPGQH/JwuIfJgQfZpk9Pwv9CDyiO
8Yjm/youZS/05iWGoA2ia/FQJLT97NRzkPG5eE9iiuiLaR5baqo6qs4uHN7G/w5v
EjyLc5xDrsH9VgG6MharsYwjj/JHBLqijv6KoUTxn5gZMtw4lVGc1fti0ldxlsrK
w3cZiy0VZa1egxh72wup4PyM5+MsV1hrer6n6XjQlCEt9plS7dgqghcxdSDeb0LY
W/80cVBMMccF1c9rKBnpz/VE5NpsdSPOaedQzb2r8/xFtlK0ibeoD+NBtmeHJT2J
Km9wCM4v4lz3QHz2wLFpvN/z50VVpGlWnLoNSpElwlMKvrKKhxskI5bxBwj/chUJ
WU0tOSBxq8ZQVvn/Mo59
=chEj
-----END PGP SIGNATURE-----

--kdw1D5uTaq0Ogcxz--

--===============6037366326688910182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6037366326688910182==--
