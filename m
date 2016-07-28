From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 28 Jul 2016 21:44:10 +0100
Message-ID: <20160728204410.GP11806@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost>
 <s5hh9bb7he6.wl-tiwai@suse.de>
 <20160727172125.GF9681@localhost>
 <20160727180456.GQ11806@sirena.org.uk>
 <s5h1t2f6jdm.wl-tiwai@suse.de>
 <20160727182233.GV11806@sirena.org.uk>
 <s5hpopy6dbi.wl-tiwai@suse.de>
 <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eUJndGal4TJgqj0h"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <579A6C1B.2060904@metafoo.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--eUJndGal4TJgqj0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 10:33:31PM +0200, Lars-Peter Clausen wrote:
> On 07/28/2016 05:46 AM, Vinod Koul wrote:

> > I agree, it makese no sense for devices to be hotplugged. And for
> > developement flows people can do rmmond and insmod. That works fine!

> I don't agree. In my opinion hot-plug is an essential feature of a
> modern device driver framework and if ASoC wants to claim to fall in
> this category we ought to support it. Hotplug is something that always
> pops up sooner or later. E.g. if someone puts a ASoC supported CODEC on
> a hot-pluggable device (maybe USB) we don't want to duplicate the code,
> but be able to reuse.

Right, so there's two bits to hotplug - there's hotplugging individual
components separately to the card and there's hotplugging cards en
masse including some of their components.  The latter case definitely
does make sense and should have a reasonable chance of working already.
Hotplugging individual components is much more of a nice to have, though
as you say if someone wants to implement it that's obviously not a
problem.

--eUJndGal4TJgqj0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmm6ZAAoJECTWi3JdVIfQBmcH/0nhJgxpsHMI7oUCAoCS8Bny
yu3ayq0BnEXaNvdDGiBBakKTuy+7ebZjgVEoyGvb6VpX7SAtZsGwxWPDI2ljiSBN
YmhyJB15EFptRRDzlZS5haxBRxIDVwi20x/kjTJILbtlFBdnDqkvjtN50eVk/hUn
9CMnb8XsW/ic3G71WMuvNimTE8udlGjUNy+ksR73pB4aMkaj62Po74p1rAGA8svp
xNtj+TshFyTOz0VGMIyMC5lsmKtVFpcGDo33niIDsRrfu9NKOZj8Dj9GNHENRGJT
OTOY37WxuuTmu6L/T+aRZi/HJ4GB2jedtjJvj2lD4RFt/S38igUdy0wqJvNNYGk=
=nPRM
-----END PGP SIGNATURE-----

--eUJndGal4TJgqj0h--
