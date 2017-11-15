From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 15:37:08 +0000
Message-ID: <20171115153708.gfodg2wa7ttllcoh@sirena.org.uk>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
 <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
 <s5ha7zn69e7.wl-tiwai@suse.de> <20171115152411.GI3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4866837609723436442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 77FE4266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 16:37:17 +0100 (CET)
In-Reply-To: <20171115152411.GI3187@localhost>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============4866837609723436442==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n34csul3ahsfe7oo"
Content-Disposition: inline


--n34csul3ahsfe7oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 08:54:11PM +0530, Vinod Koul wrote:

> This set is growing and will keep growing. One machine is already posted and
> it's cousins should follow soon. I don't see a point in having options for
> these ad distro's would be enabling all of them and having all of them
> enabled works fine for me

Distros enable the overwhelming majority of drivers anyway, they're not
really relevant in terms of driver configurability.  More relevant are
people trying to build a stripped down machine specific configuration.

> > We should begin with thinking of which entries (and layer) to be
> > selectable, and which not.

> Trickier part is non selectable ones, I am going to take a stab at them and
> see if we can merge few which can help is making lesser options and clean
> that part a bit, maybe a common SST_IPC symbol which adds IPC, MATCH etc.

Those ones are less important so long as they're selected correctly by
the things that need them, it's not like there's not lots of complexity
in this driver.

--n34csul3ahsfe7oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMXyQACgkQJNaLcl1U
h9Dkvgf/Tz36afXDfbtfjRmZ1r7hF4Z4MreiFRBkX9Ai9Iiv2sKB7NQ4RXrbeFBV
OwEZPl6krlct/xDN/LFk/r7QvazLKgDx7mdvxqtQZ0BmnSvouAjiHXoHxYdKlNYr
yUD1owifuHXOwoKONbltGDlpsqSCQ74h9x0JzlaBJmo/GmrwfVqv5pauhPFNUrYo
xciVmRvkrCEkzRCAI5o2iLzSFY3bV1OETeJUYEBqT64U/a3ICFAK76Zf07dGytK1
s2NQYXDO8yVIQepuQgEyoYjnB4s56nDP4qdeKNEsOqjcB9G4jQ4YYSg5McQkhyZ0
UPVowkF1Z++4B8S+S5ZBlSH12rr37A==
=nboD
-----END PGP SIGNATURE-----

--n34csul3ahsfe7oo--

--===============4866837609723436442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4866837609723436442==--
