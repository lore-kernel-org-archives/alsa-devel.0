From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: Intel: Skylake: Add MCLK
	configuration
Date: Mon, 8 Feb 2016 16:43:04 +0000
Message-ID: <20160208164304.GH7265@sirena.org.uk>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
 <1454654950-23091-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7750300211551856461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4573C2605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 17:43:13 +0100 (CET)
In-Reply-To: <1454654950-23091-5-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7750300211551856461==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Content-Disposition: inline


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 12:19:07PM +0530, Vinod Koul wrote:
> From: "Dharageswari.R" <dharageswari.r@intel.com>
>=20
> The SoC has MCLK output which is typically required by codecs.
> The MCLK is controlled by DSP FW, so driver can configure that by
> sending DMA_CONTROL IPC. The configuration for MCLK is present
> in the endpoint blob.

For integration with CODEC drivers this clock should really be exposed
via the clock API too.

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuMWXAAoJECTWi3JdVIfQYd4H/0dRs0Sa1K7OvS/Iob8IcoBn
b3/Lp9NiEUY4rYpNE2h8ZkV00cGQwUpsK/Ra4PHAqbR2AhOauGAosrz1AjeDOFgf
O8fqaArejsJh+F3NzSXukE7VfAc7CqSpahqE0BIrpi4LhfgdgXkgpPpyXFe3VeKe
O7Nph70L2goTeqZgNft0qY5rryGJyV77G8Tpc6yh8povcLIpPMajLC8WPtZC9n70
XT3FTdkhfUU6XmqZ5p3l9NaupqLDHMkGKR5VAEhWZp+79SQoMvmhXaeM82xw+kiW
rShF51u3n9iZIF9EEtJ8Doa+6amztx1pfew75ZjIU2vqWfctAjdkJ5z8EUslNQA=
=kCsP
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--

--===============7750300211551856461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7750300211551856461==--
