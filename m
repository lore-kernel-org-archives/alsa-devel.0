From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: Use ACPI device for
 Baytrail PCM buffer allocation
Date: Tue, 13 May 2014 11:54:24 +0100
Message-ID: <20140513105424.GH12304@sirena.org.uk>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1399643264-7669-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5204770334402867515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76372265279
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 12:54:42 +0200 (CEST)
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


--===============5204770334402867515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdA23zU/ut33cbq"
Content-Disposition: inline


--aPdA23zU/ut33cbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 04:47:44PM +0300, Jarkko Nikula wrote:
> This follows the same idea than commit 10df350977b1
> ("ASoC: Intel: Fix Audio DSP usage when IOMMU is enabled.") by using only
> ACPI device for all DMA allocations. Since DMA masking is already done in
> firmware loading it can be removed from here.

Applied, thanks.

--aPdA23zU/ut33cbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcfncAAoJELSic+t+oim9eVcQAJ2B0f0jePlYez1JeI8AvSQX
w6b7EXKJlITk79Gxv2hJC93MmjigcSZ3bUJ3PZ6QvAd7lPiWtYxnYlv56uIETZzp
DrLC7msOg9BXz9lzGqx+OBnTnvzbcjrj7kuGkO9FtCSCXGLxRTekMdRmrvb0BA1D
cKnFT6m0Yuq6Nexb+hoSapNdoiPmWemXMB65+7rjt8GM/nFKc4uiQ5L+XcEK7/L2
rn1XbettX7SiTWPChaPFtv9cmeWscCljotjPXWUwHh+ufGUwIGlrjM/MhL9uwZ8l
XMxlKxIk8cutDmdlOqWS73sQIsGR2chiIgqRye9j+cVyVxHJGw3bACk0mR9zgjb1
TdQDnE9Keo6qtpAUSb4GHGKa7Xlz7W8kUbmjtR73inlRXoISPjj75f7hAWqCbAEp
elW+UBp/jGpZyl4bg/TEpuD7DqPa+MBvT8Zd84jdbv13fSHRJgEO1pvozgPcDG0G
hbCKhYpuu2MPFUCZApioHpHVV5Jnb2QHUFuC6gRKFHVh2bUdBeT5iKKBOeJAZXhs
GwFe5AXlC8FsPjng7sJgbXva1X2VnJpcPoxaNvNianWAycHIAZXoiXQDAm3EPMqK
tgNFlW7FxX0uEdQtY9UaFR8ZyB8SAPIZp9hGL2HNQ9TLKH27Q8bfYY0FaeFW01fE
NLt1h0bVtbyP2op4buiO
=uiQc
-----END PGP SIGNATURE-----

--aPdA23zU/ut33cbq--

--===============5204770334402867515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5204770334402867515==--
