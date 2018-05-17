From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add CNL RT274 I2S
 machine driver
Date: Thu, 17 May 2018 15:37:25 +0900
Message-ID: <20180517063725.GM20254@sirena.org.uk>
References: <20171127124437.8441-1-guneshwor.o.singh@intel.com>
 <5bdd77e1-fb83-0626-c377-a457294ca38d@linux.intel.com>
 <20171128162415.GV3187@localhost>
 <f0425e26-a13d-d0ed-4191-f5973cb14231@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0130162947231589882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 91469267630
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:37:26 +0200 (CEST)
In-Reply-To: <f0425e26-a13d-d0ed-4191-f5973cb14231@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0130162947231589882==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0+35XlDF45POFHfm"
Content-Disposition: inline


--0+35XlDF45POFHfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 28, 2017 at 10:44:50AM -0600, Pierre-Louis Bossart wrote:
> On 11/28/2017 10:24 AM, Vinod Koul wrote:

> > Since you are still working on the fixes, I guess this can sneak in before.
> > The machine drivers are typically low hanging in terms on complexity so we
> > can merge this first followed by the rework you are doing. I think that part
> > will still take a bit to stabilize and cleanup.

> the update goes out this afternoon, working on it, does this patch really
> need to 'sneak in'?

This seems to have got buried with all the Kconfig fixes and reworks?  I
was expecting a resend based on those given this discussion but that
didn't seem to ever happen.

--0+35XlDF45POFHfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9IyQACgkQJNaLcl1U
h9BkhAf+JDDxXCt8Hlk1IwmN4E591nup7sJeNF1tO0/7BTQjuzK17MYjpG3O5Bnr
3t7sjssPTQkJLLezl7EhzSN/9ztNVyMMq45162squXVj6lVasWzcI+rGsKIOFxOA
VBkEfAc6+GzREO/5ETwVq16O/pNWtLlXEjom/WOgdEjyqCvkWY3sfNPhdCkq3g0w
6OEHl0waC+//REWGV0/HQF1LPNCV2iyzyjwcH6ZROGx5wMLUVZ7lB+kg3lNGt1rv
4KyE9LU8Dn0NF1v6rQqRxFM85KZWsxxCVSgOZlnkxlNqUZUzc1hl6ZEjr1zDlpwu
016GNqrvMwAiWomEV2/6IEbeUO6DGQ==
=828o
-----END PGP SIGNATURE-----

--0+35XlDF45POFHfm--

--===============0130162947231589882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0130162947231589882==--
