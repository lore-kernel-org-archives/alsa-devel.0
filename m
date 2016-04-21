From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add DSP
 firmware manifest parsing
Date: Thu, 21 Apr 2016 17:07:13 +0100
Message-ID: <20160421160713.GV3217@sirena.org.uk>
References: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
 <1461219323-1036-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5358816197944629440=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 971342612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 18:07:20 +0200 (CEST)
In-Reply-To: <1461219323-1036-3-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5358816197944629440==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bLgs+aUf1UT65bBm"
Content-Disposition: inline


--bLgs+aUf1UT65bBm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2016 at 11:45:23AM +0530, Vinod Koul wrote:

> +	num_entry = adsp_hdr->num_module_entries;
> +
> +	tbl = devm_kzalloc(ctx->dev,
> +		num_entry * sizeof(struct uuid_tbl), GFP_KERNEL);
> +
> +	if (!tbl)
> +		return -ENOMEM;

I'm still not seeing any bounds checking to make sure we don't read
beyond the end of the firmware file.

--bLgs+aUf1UT65bBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXGPqvAAoJECTWi3JdVIfQpRsH/0ZHztZXnhekly8KphPZa65N
8vI0DYiz6NGrhkqUGeQKjMetupJ2/aHh4xNuqbeHc2zkO8dsPNVg3G9/2wkwxqGv
Kkd7IFDyzzqIPDicwBu9VyNuRHbawlOxHPR6NVatULsXYzvKsgnXYoORgxBD1HHy
O6OjXedrUuf+WJ+CQWbtbFcVmejfEr1o7gPlruGbozhr+hp9FvKQ40JZF5a1EI/e
6ETWFYYA6OscujWRCSGtoWeYbIavoiDJj/6FyAaDA1I3WbEckRur7w7n/4I3pNST
mjAShmaHL49KYWkwkuhlZiV5gA36FwAptUkfOx8wTlLZHaQw8kdm3kluUeggCdU=
=n2S3
-----END PGP SIGNATURE-----

--bLgs+aUf1UT65bBm--

--===============5358816197944629440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5358816197944629440==--
