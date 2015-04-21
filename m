From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 17:39:42 +0100
Message-ID: <20150421163942.GM22845@sirena.org.uk>
References: <1429217285.7100.18.camel@loki> <5535F513.8030902@ti.com>
 <20150421092812.GA22845@sirena.org.uk> <553642EC.8010400@ti.com>
 <1429629831.2797.9.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1422975347773881688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CEB261504
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 18:39:49 +0200 (CEST)
In-Reply-To: <1429629831.2797.9.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1422975347773881688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Content-Disposition: inline


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 04:23:51PM +0100, Liam Girdwood wrote:
> On Tue, 2015-04-21 at 15:30 +0300, Peter Ujfalusi wrote:

> > We have discussed this with Liam in the past: in my view the DSP topology (or
> > Dynamic FW) should be represented in the machine level and it would be the
> > best if the same image could carry card level widgets routes and links. If you
> > have big enough change in the FW and it's provided widgets/PCMs you would need
> > separate machine driver or at least a way to have different set of machine
> > level routes, widgets, links, etc for different DSP topology file.

> The component level allows us to target the physical component devices
> that may have runtime definable topologies. This would include codecs
> too, since some vendors are making codecs with built in FW (maybe TI
> too ?). The machine level more represents the board HW topology and this
> should be derived from ACPI or DT.

I tend to agree.  We should let each vendor provide their own topology
information - if they need to do something with this (which does seem
unlikely) system integrators should be on an equal footing with silicon
vendors here, and we shouldn't be encouraging systems where we need
per-board firmware definitions for the silicon components just because
the board has differences.

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNn1NAAoJECTWi3JdVIfQubsH/RGpjkrc4EZzb+vNi7K5Ztnh
76ePxGfVkSTFjkYSz/lmsWRYHtBVICjEGh+DlWJ8e8m4W4gXfvlK/Y0y23UGO89F
M/NC39wJem2zpJqkIwpw3BxWY7P12OtR7qQ+h5zyFbGfuKSVtlk3nP27tKYYDAHQ
8aA7NoJUTHF/jAHess7EhjPeXiCGTuEz+a6Xd0WQF2Rx2PZy5sjKsfdlpHOULSVG
ObCB/B2ltVbEKhNpDRLXgTCMd92YjeHOtI/6gfk1Q0ZVJSe3SPZ18R3M4oZCdZUZ
CSmvCpWwFRRkH1NnHXCmrXsLLc1Y14lz7xqERglzHT2TIpG/WUedxdiVdgQ7x2A=
=imuL
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--

--===============1422975347773881688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1422975347773881688==--
