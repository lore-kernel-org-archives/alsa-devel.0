From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Intel: allow for DW_DMAC_CORE as
	module
Date: Wed, 9 Mar 2016 09:43:26 +0700
Message-ID: <20160309024326.GE3898@sirena.org.uk>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1457062599-10032-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160305040303.GY18327@sirena.org.uk>
 <56DDBF29.2010809@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0735042699449683071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FBF261537
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 03:43:29 +0100 (CET)
In-Reply-To: <56DDBF29.2010809@linux.intel.com>
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


--===============0735042699449683071==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2016 at 11:49:29AM -0600, Pierre-Louis Bossart wrote:
> On 3/4/16 10:03 PM, Mark Brown wrote:
> >On Thu, Mar 03, 2016 at 09:36:33PM -0600, Pierre-Louis Bossart wrote:

> >>-	depends on DW_DMAC_CORE=y && (SND_SST_IPC_ACPI = n)
> >>+	depends on (DW_DMAC_CORE != n) && (SND_SST_IPC_ACPI = n)

> >What is the expected difference between a dependency on DW_DMAC_CORE and
> >one on DW_DMAC_CORE != n?

> No functional difference, it's more to make the menuconfig options more
> obvious.
> Without this patch, menuconfig will not show the legacy byt-max98090 and
> byt-rt5640 options if the DW_DMAC_CORE is built as a module.
> While we want to encourage folks to use the newer DPCM drivers, we also want
> to leave these options accessible.

My point is that you've written the above in a very confusing manner - I
have to think about what it means while just a dependency would be clear
and obvious.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW343NAAoJECTWi3JdVIfQ6l0H/iw0+8KAfDw9BL2VFf7LbiZR
aCf2plEhKQ8kOIy8+4BOuoLPxMkLg1J/Hy03qOhwUpMQjMN6/CxhfWDCnDZmI9eF
xPZgfYm234fVlx2ODtXWZUzPqgG7a4OmvGb10uLHvBaOP3ZNA28GuViR+pffHWRs
nHIuGJA0/IYu/7nBMF/sY6U8QyNPQeQvplROTHrn+22WuGgDvMA7JkXsEevzPUwd
w7n9sVeF5tiqVwzbHgVK3Aqmnt5/xY17IOK3yK4/DrSCZ2731XnVXGMWbZJMAtAK
X+CMDCo8kIJrXos5aBJacPdr2vIboutezPRIiUyZiXQcDs9DNlu6Y8V4viMuv68=
=WqUh
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--

--===============0735042699449683071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0735042699449683071==--
