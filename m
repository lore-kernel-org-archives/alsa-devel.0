From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Thu, 17 Jan 2019 15:55:36 +0000
Message-ID: <20190117155536.GB7003@sirena.org.uk>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
 <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
 <s5hpnsx26tc.wl-tiwai@suse.de> <s5hh8e9fyam.wl-tiwai@suse.de>
 <20190116155027.GB7186@sirena.org.uk>
 <s5h8szkzjje.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4018965438871218893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 213EB26680F
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 16:55:42 +0100 (CET)
In-Reply-To: <s5h8szkzjje.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4018965438871218893==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16, 2019 at 04:52:53PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Tue, Jan 15, 2019 at 09:42:09PM +0100, Takashi Iwai wrote:

> > > The last one has prepare and complete callbacks in addition to the
> > > other standard PM calls.  And tm2_pm_preapre() stops sysclk and
> > > complete() starts sysclk.  I don't understand why these are needed in
> > > prepare and resume.  Can anyone explain?

> > AFAICT it's just making sure that they're available ASAP so they look
> > always on to the rest of the system.

> Well, but PM prepare is called before PM suspend call.  And the whole
> ASoC suspend procedure (including PCM suspend, etc) is performed in
> the PM suspend callback; i.e. we stop sysclk before doing anything
> else...

Thinking about this some more I'm moderately sure that the calls were
intended to do as I described but someone misunderstood what they did
and swapped them around.  I'm guessing nobody's been testing this.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxApXcACgkQJNaLcl1U
h9D/AAf9EtW+s13hvioUYWBeyRgDZEa2fCrvOQRxrP0FyfQW+IfX4B0/PGOZ6feP
x374WYhyk08uO/4sh7xMOs6cfwB3gmd+x+6dRqhQlPegmGxqb5s9lHWjP8eIbx5p
baeMWrR7ykZB8Kki0LJrcCPCSenmUjGxAuY3FI/kfLHLx92IIN280BjPP5mRXtnK
H0sEwHCxdindeT+eEJFa/SycyBtI93sjjRnGNGgI/Zan1UZK4KHIqqGjS464Oa6l
dKZ9zAoWNS7hC4YmIXgKZREmyTabH6P3jT89DaBGxmZZ+PM77QI5DexkVX93+tjC
OTIYguG9m27v6bowpJ4AywLXmp9p7A==
=MG5N
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--===============4018965438871218893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4018965438871218893==--
