From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/9] ASoC: Intel: Skylake: add DSP platform
 widget event handlers
Date: Sat, 15 Aug 2015 09:46:14 -0700
Message-ID: <20150815164614.GI10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
 <20150814214336.GU10748@sirena.org.uk>
 <20150815134208.GD13546@localhost>
 <20150815143638.GC10748@sirena.org.uk>
 <20150815151204.GH13546@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8007329379993789688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 232F02654AD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 18:46:45 +0200 (CEST)
In-Reply-To: <20150815151204.GH13546@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8007329379993789688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fXCyug6VAL2FbtaR"
Content-Disposition: inline


--fXCyug6VAL2FbtaR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 08:42:04PM +0530, Vinod Koul wrote:
> On Sat, Aug 15, 2015 at 07:36:38AM -0700, Mark Brown wrote:

> > This is the sort of thing where the whole lack of documentation thing
> > that I keep going on about becomes really important - there's a limited
> > amount of time I can spend on any individual patch series and so things
> > that need to be reverse engineered are just going to get queried a lot
> > of the time (and even if they get reverse engineered the feedback is
> > often going to be that the code needs to be clearer).

> Okay, I did try to add comments to help understand but looks like I still
> have more work to do. Will try to add these details as well

If you're adding any of this stuff it's really not obvious, all I'm
seeing is very tactical stuff down in the details of the code which
isn't always useful without any big picture - bear in mind that there's
a lot of Intel internal abstractions talking to Intel internal
abstractions none of which are terribly obvious, and of course the
tendency to throw in things like the NHLT table or acronyms like mcps.

Bigger changelogs would help a lot here, as would building the
functionality up gradually rather than dumping large sections of code.
Right now the changelogs just tend to be some fairly brief comments on
the purpose of the code and don't really go into the structure or the
design decisions that went into it.

--fXCyug6VAL2FbtaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz2zVAAoJECTWi3JdVIfQl+cH/A4Ox+TWNf0mm+e7uD2KCe34
XaGORnbXqKM9kYRGvE7+rSN4b7ldAFBX2DJOJaVzIEPRQ/Z2/G+QQ7p7Qz7mA/XH
CMEeOW4q0EfX3yT4h0YuHd+PI1+lyKIaCEYzsko+eQ35DTX/KdIijMdl2ucTvx/Y
4AHi0RPHlbkXSKHTDf2F0T2c5InD8xBxkEYtWn1lazPDP7fBfjowG89CMWRnfZY7
ZJ89/Qy54oiPJRoZeuTt7Y5Pmru9HJBaeesRO2jtWwDglDBv+K0qObS7YmkBFOQO
RHAbmKudCNDIVnrWDnelzGkWFZMBdWoYVSsP+GxMXqBl2a9/yE+iUh72wMZXrs0=
=pAP1
-----END PGP SIGNATURE-----

--fXCyug6VAL2FbtaR--

--===============8007329379993789688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8007329379993789688==--
