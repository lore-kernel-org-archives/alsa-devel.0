From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/8] ASoC: Intel: rework the mfld
 platform driver
Date: Thu, 8 May 2014 18:27:12 +0100
Message-ID: <20140508172712.GF12304@sirena.org.uk>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7065718670821086087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C7E72654F6
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 19:27:25 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7065718670821086087==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bftLtL6628g78IAb"
Content-Disposition: inline


--bftLtL6628g78IAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 10:19:17PM +0530, Vinod Koul wrote:
> This patch series reworks and reformats the existing platform driver we use.
> This is stepping support for seconds series of patches which will support
> Merrifield platform with DPCM based implementation

I've dropped this series since it broke the build in -next by adding
recursion into a board subdirectory and there wasn't a response - please
fix and resend.

--bftLtL6628g78IAb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTa75tAAoJELSic+t+oim9zpAQAJQMsKm7EzCN1Ad2ElDB9E+i
ASjWr0QKoUIAFo1AaeT0pHM5ZXLOuZX16pq3vJzdwFAZDZTcpMs+wioBtx2Kg5In
dTv4AEcEWt4vInJFvzpQooNnRvVTpDuRVlCCMmFJChGfV1xwiBI7XChfGQzxWB3i
6586gNEI2BSSiBLcWCsR7wbKDa9IriOQEfCKUgSzI9WhZz7mqHsIeVsQlPcSBdOt
rXf3hKVpyhLttB0BP+dkA86bt4QzW+b9tA5/uYoTBqKyGnXeFi2MimqgG5b2Vl4a
35KX3GNwAsfmI+P4DfgnlqigsJOZPJ7eJSNQ82wa1Q21c+4dUDUROSaqzCVLE0UZ
CQxfw96RdrKrYJHkSvfAL2Sq1aH8DgefYM3h1wUP9dv4WGnq/In7lzzNETgvOkv0
KJ8QehKVGlWaWdeRKIM+0KXEyz7JlWou7LLiZviujVa30FZnxVajHEarfEXoQaaB
z0kzj8Q6HD3oCLFFCAgzSgJ5Ba8wLCBRPBrSfWiOhRRCBNO5A+PqgIg0IHBWkErP
uSTC0EiqbxQeA3+Zlpp2sNn3XpgIOMqwt80v41Mzzf1xq7InSwgOCpAEqJjIsIAu
dwo4Cla9oDWJSNBpHaTw7EZkZ1Yb/MV1VbEcqvCkZgiVXP3LAThTcwTjQMnvy8Ec
3c4grhjVyBUD3eMdHoQO
=hJu6
-----END PGP SIGNATURE-----

--bftLtL6628g78IAb--

--===============7065718670821086087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7065718670821086087==--
