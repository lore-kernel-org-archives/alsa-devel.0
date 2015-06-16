From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Tue, 16 Jun 2015 11:43:46 +0100
Message-ID: <20150616104346.GG18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
 <20150615155752.GV18309@sirena.org.uk>
 <s5hmw00gby8.wl-tiwai@suse.de>
 <20150615185405.GA18309@sirena.org.uk>
 <20150616044458.GU28601@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9010207582587184882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00D122651B4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:44:00 +0200 (CEST)
In-Reply-To: <20150616044458.GU28601@localhost>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9010207582587184882==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xGZLEhdrcEmdnWHc"
Content-Disposition: inline


--xGZLEhdrcEmdnWHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2015 at 10:14:58AM +0530, Vinod Koul wrote:

> We have been using defaults for our testing, and PA and other usermode
> entities seem happy :)

> Btw Mark, the text is not our invention. This exists in legacy driver
> as well.

So you're cargo culting it without really understanding it which isn't
so great...

> Said that, i see two thing to be done here, one is to remove this in SKL
> driver for now and if required add it later with better explanation as for
> now usermode seems happy atm, so may not be required right away

Based on what Takashi said it seems this is a memory consumption tuning
knob so it sounds like the low memory work that some of your colleagues
are doing is going to want to add it back sooner rather than later?  It
seems like a reasonable thing to tune, it's just that the text needs to
be updated to reflect reality.

> Second one is to actually make this in core, move the flag in legacy driver to
> hdac parts and be used in legacy driver as well as anywhere else

That's good, of course - just have one config option for all HDA
drivers.

--xGZLEhdrcEmdnWHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVf/3hAAoJECTWi3JdVIfQA/YH+gN2iu13tNY4qp4e01aO+Wpi
Up+ilPKibZROmst79fHSW8Fkxgg9a/63Vc4lFem9X7DFixatY2yr0lVSCfC582Ct
MJM3XAhHffuZNl+tbwgO5xSxd4AEdLZ2MCAP4njLc1skXQ3/vHKpTjJNYPjAI+00
4U/Z9A7K3ulOTu26JlxMPmB3Y4fmEIWTxyOVhc0XiZQKJYKMmfxxn37TVqQXucyH
V0vR1L3J0ivvanE1b+ExvM6UdBo0Sq+QNnLjP5gpFVjGN5KVXpQZ8LBR8o/rTrHH
j1Hk9dVhDTjkbD57ePGB/IYyeZIANfvMk7oO/+c+iKJWC81TOLpWtuLOX2dXm8M=
=jJWS
-----END PGP SIGNATURE-----

--xGZLEhdrcEmdnWHc--

--===============9010207582587184882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9010207582587184882==--
