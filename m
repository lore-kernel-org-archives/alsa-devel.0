From: Mark Brown <broonie@kernel.org>
Subject: Re: Correct modules for Bay Trail MAX98090 soc?
Date: Fri, 12 Aug 2016 10:53:17 +0100
Message-ID: <20160812095317.GZ9347@sirena.org.uk>
References: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
 <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0390285369071223216=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 051EE2677C4
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 11:53:41 +0200 (CEST)
In-Reply-To: <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Laura Abbott <labbott@redhat.com>
List-Id: alsa-devel@alsa-project.org


--===============0390285369071223216==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HSHpc5A+GJc9BHcd"
Content-Disposition: inline


--HSHpc5A+GJc9BHcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 11, 2016 at 06:31:27PM -0500, Pierre-Louis Bossart wrote:
> On 8/11/16 3:42 PM, Laura Abbott wrote:

> > which changed the dependencies for CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH.
> > The set of options Fedora selects means that
> > CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH
> > can't be selected. Is there another driver that's supposed to replace
> > CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH on Bay Trail or do the dependencies
> > need to be updated? The bugzilla has alsa-info for working and non-
> > working cases and the Fedora config is attached.

> If you remove support for all other baytrail options this driver should
> still be there and selectable. We just can't support both this driver for
> Chromebooks and the rest for other machines with the same distribution at
> the moment.

That sounds like a regression, what's the plan to fix it.

--HSHpc5A+GJc9BHcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrZyLAAoJECTWi3JdVIfQR4wH/0kqSPi5qxvinsjpERNwNG2T
c/j5LwUgYwbWHSiqTo8HJPZ2nc259F61zfld8N0eheU6u/nEGEe8HOpkHvsm/+wa
lO0P0lY1NoLI82C1wWZSBKzXxuAJuVMYiL9+TOH1VN1T4b1iTHtbfGikxyyn8slr
WafJe3DC9zlkhL+21H4jiJbpZmKAdYmtv8MRW5066NinLZjR776ZgeYCUptpHkZO
pE5VkuM4fGa3GrxvT7f95VUVpbngoXwW8ZHH3Jy5t+oANOcJmTbICCS+S/By3pnH
l9fRrNRtfp429dzfBGl74CPGGAweIjCW9bDT/QRvZX7/ZRer5n62lNcWyvmg72w=
=k2Zw
-----END PGP SIGNATURE-----

--HSHpc5A+GJc9BHcd--

--===============0390285369071223216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0390285369071223216==--
