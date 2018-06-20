From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: common: rename 'reef' to
 'sof' in ACPI matching table
Date: Wed, 20 Jun 2018 12:17:36 +0100
Message-ID: <20180620111736.GD6242@sirena.org.uk>
References: <20180619190037.8307-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2867784043771165881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0827B266E0E
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 13:17:38 +0200 (CEST)
In-Reply-To: <20180619190037.8307-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2867784043771165881==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 19, 2018 at 02:00:37PM -0500, Pierre-Louis Bossart wrote:

> -	.sof_fw_filename = "intel/reef-byt.ri",
> -	.sof_tplg_filename = "intel/reef-byt-rt5670.tplg",
> +	.sof_fw_filename = "intel/sof-byt.ri",
> +	.sof_tplg_filename = "intel/sof-byt-rt5670.tplg",

We're sure nobody is using this stuff in production yet?

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqN88ACgkQJNaLcl1U
h9C19Af+JI6kLdcPjBYBU1dQHj4MduBluPIdTdnTiRt9StNlQNV9QK/iyVYja3aG
sNKdR79dy/0Cqco4ne4ZNomOIsjjCbtg6YatV9ZpvlmKSmwC8o8QljmrROw1o4wZ
mM/b5odujc2wVF05ZXh6YLVi3NWlFl9q0r6ruxxGaI3NlDirYYc46yafXRm86/O1
DOq7fQA4q7oPLjOkOVqDU+do1Pa3nD8nJVmv6szK5UCmNF/D78pUKa+wJACnEQ6C
f3PdSzIOR0zVegnYrtgicQMAMvFVkq+yWl0KQW12vG+LrpagooufEmdLuoQLDS3W
HzmZCAJiE4Tbf2mdthq9c3Lg/dVQ+g==
=+RYI
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

--===============2867784043771165881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2867784043771165881==--
