From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:for-4.20 333/424]
 sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of
 function 'pci_iomap'; did you mean 'pcim_iomap'?
Date: Wed, 12 Sep 2018 13:04:22 +0100
Message-ID: <20180912120422.GG6062@sirena.org.uk>
References: <201809111307.iuux6Toj%fengguang.wu@intel.com>
 <s5h4lew34fv.wl-tiwai@suse.de>
 <20180912113128.GF6062@sirena.org.uk>
 <s5hworq6i2m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4545056918608917451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F3097267821
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 14:04:26 +0200 (CEST)
In-Reply-To: <s5hworq6i2m.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============4545056918608917451==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 02:01:05PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Not on x86 we can't, it's not there - asm/io.h seems safest AFAICT,
> > everyone has it and both SH and x86 include the pci_iomap.h.

> Hmm, the code does include <linux/io.h>, and it includes <asm/io.h>

Yeah, at least not on SH - it is on most architectures.

> I don't think arch/sh/include/asm/io.h includes the necessary thing.

I'm just about to submit a patch which makes it the (or at least a)
necessary thing.  This stuff shouldn't be complicated or inconsistent.

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluZAMUACgkQJNaLcl1U
h9CEAQf/ZdUCpIWoRMqNvzKpvS7/NpTABJSyylz5f9iE+4o4OCnXYBQbRYNUPQZz
HV6QTWuhgWhasH5Rpx27+LoVkhC9So+/GcHvBexhmEfrinMlymSrY5FozcpuzYIC
K07sDyZTzfjUOhvxgKeqMCePDjgURHNRPEU09Ywhi2LdUv+ngu6useIlh1ezFcHw
csw8ka9XB2OJ4b3FwEXuJor0TTof/rhnOLnMRoRayDtURlm6w2Ox5Gzry7WskeBE
YSLLCjWnWm5Dq4N30+60/C+JXeGLUZzB7Yb2My17drstjySFvLODrSjFWMPNJIHF
TnBZqy0bokqDHh87j1Y7aiwfQb6yAQ==
=UJ1T
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--

--===============4545056918608917451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4545056918608917451==--
