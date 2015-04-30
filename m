From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ALSA: hda: register selectively for
	SPT-LP
Date: Thu, 30 Apr 2015 22:23:30 +0100
Message-ID: <20150430212330.GQ22845@sirena.org.uk>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <1430405556-19166-3-git-send-email-vinod.koul@intel.com>
 <20150430203355.GP22845@sirena.org.uk>
 <s5hk2wtjpsl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8155975729230190788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E5A26619D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 23:23:37 +0200 (CEST)
In-Reply-To: <s5hk2wtjpsl.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8155975729230190788==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XYdzVmMsNSecE+Q/"
Content-Disposition: inline


--XYdzVmMsNSecE+Q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 10:59:22PM +0200, Takashi Iwai wrote:

> Ideally, it'd be best if the system can do everything automatically,
> e.g. loads the DSP driver at first, then falls back to the legacy
> driver if no DSP is found.  But there seems no clean way to do this,
> so far.  Thus the flag was introduced.

Eeew, that's horrible.  I guess another DMI quirk table is going to be
needed... =20

> Another way to skip the unwanted driver is just to return -ENODEV from
> its probe callback when the given PCI is SKL and the flag is set.
> Then the driver core ignores this and continues to the next possible
> driver (i.e. the dsp one).  The same should be applied to hda-soc-skl
> driver in vice versa.

Right, that was one of my suggestions.

--XYdzVmMsNSecE+Q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQp1SAAoJECTWi3JdVIfQbZsH/A8BYQwFj1wR0QAehSSk1irC
eTPMp7F0mVSIx0IRIH49sW4sxMgu9/t2Zym0YqDTL10Mj6EzJGtje4VDa6vQFUi7
hYBzspxv202KRsLL/l+TY4jEvfxNGtXw8MLU0rMpH6NEvxaAbedm1A1xGyhms7un
lJVfevP87ewFJ3EoV11RPQNWlq67txv1Dd3fKrsCgqxrJVwWq/1xwEf36E9OQDCD
59yrMCpkUfyMMFy0cN0MWkle+aaSlq/kTrSj0oC+QIb2l1wajvzMqnlCTclIMAui
/xvpSyuJ6oRpALewla55x6BHInRbaVnn7IekP3iK/OGEJnG7c8aczeeHYQURZa0=
=JMHR
-----END PGP SIGNATURE-----

--XYdzVmMsNSecE+Q/--

--===============8155975729230190788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8155975729230190788==--
