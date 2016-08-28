From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/13] ASoC: topology: Able to create BE
	DAIs
Date: Sun, 28 Aug 2016 16:12:15 +0200
Message-ID: <20160828141215.GA3950@sirena.org.uk>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823173354.GZ22076@sirena.org.uk>
 <57BE92E2.7030807@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8932153835519290883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB76D266D5A
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 21:36:13 +0200 (CEST)
In-Reply-To: <57BE92E2.7030807@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8932153835519290883==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2016 at 02:40:34PM +0800, Mengdong Lin wrote:

> In previous design, we had thought that BE DAI and BE DAI links should be
> created based on ACPI info in BIOS. But unfortunately, the BIOS doesn't have
> enough physical information, so BE DAI & DAI links are hard coded in
> platform and machine driver. But when new platforms are coming out with
> different physical connections, this BIOS gap blocks us from sharing a
> generic driver across platforms. Now the gap in BIOS ACPI info still exists,
> the implementations also vary for different generations of platforms, BIOS
> for public shipped machines cannot change ... So finally we fall back to
> topology to overcome the BIOS gap and make driver sharing possible. We have
> tried creating BE DAI & DAI links to new platforms and plan to back port
> this to upstream drivers for existing platforms like SKL.

I don't understand why we're not able to just enumerate all the possible
back ends in the driver and then select the required one at runtime
- even if we do this there's going to be some fairly strict limits on
the set of back ends that can be added.  Do we have any concrete
examples here?

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXwvE6AAoJECTWi3JdVIfQYycH/j76K0BvTd85n6JLw62SeVGG
aEa+Wdt4vjmzihL/poFmbXuLsn9tADIRlcwUaSpVVr1YtUCECro6odWgqrHQGHsH
fybnVtMuX7hIGoKKEAgUrKU18c7O9dlgAvTlFi5fThXy2cPVlzWZVJGHHnRlAcFt
vgrY8v0RJBr634MIaYaGCgBqX01RUb4O3bFu+uU/exnbgMPSFImXLvULCftXSWFC
snsn4XkgncTVIyN0rFdOmXr3ipnDvLqAVMMsQAQ5P5RxA+uQI4F1ZfehyesxOjbp
visrn774+ZO15UxFWQVaFjDGskquEFn5Zst0V1vh8+mtZJ2QrH39PbVePAoPR68=
=x+2z
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============8932153835519290883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8932153835519290883==--
