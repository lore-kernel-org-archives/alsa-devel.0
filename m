From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Intel: allow for DW_DMAC_CORE as
	module
Date: Sat, 5 Mar 2016 13:03:03 +0900
Message-ID: <20160305040303.GY18327@sirena.org.uk>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1457062599-10032-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5021106237304463982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2A45261AE0
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:41:39 +0100 (CET)
In-Reply-To: <1457062599-10032-2-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5021106237304463982==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="04ZNcpkPeDDsg0rt"
Content-Disposition: inline


--04ZNcpkPeDDsg0rt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 09:36:33PM -0600, Pierre-Louis Bossart wrote:

> -	depends on DW_DMAC_CORE=y && (SND_SST_IPC_ACPI = n)
> +	depends on (DW_DMAC_CORE != n) && (SND_SST_IPC_ACPI = n)

What is the expected difference between a dependency on DW_DMAC_CORE and
one on DW_DMAC_CORE != n?

--04ZNcpkPeDDsg0rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2lp1AAoJECTWi3JdVIfQ++8H/1VBC6FrwcZYVV2TfuxcJP2R
BP58hBPnHbk630Ye0Y+bepFzqBvZm0b5Br2yBKd3S5qKaKoYDF9r9v6eKFbAqFIM
IiSfMhyINIapF+2Aw8SWv4+M9FrkH2JhSvYrpOyMK0cN9kGYzsaBmbPhIn2CzEF5
l2eMs1rsnY3Hbm87oWMO2HUHKw6amLkRRwnw2NJ/2YB0UrGjw7xoM6VidbPwf92z
72NxD1XsoCXzp09n1BeevT8lqRFzoCp34YuvNj+vL8LST8hutG7OLdFfQzszwdB+
QefTtfm5Tm7N2JlEyWdpKP0saiAzfpxzB72BKClcu6HUicuZTz89ZxlYaQfB5Ng=
=q84S
-----END PGP SIGNATURE-----

--04ZNcpkPeDDsg0rt--

--===============5021106237304463982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5021106237304463982==--
