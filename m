From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio mini conference 2014?
Date: Tue, 26 Aug 2014 11:47:22 +0100
Message-ID: <20140826104722.GJ17528@sirena.org.uk>
References: <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <53F1B892.5080109@metafoo.de>
 <53F1BA5B.6070400@zonque.org> <s5hbnr7u5xp.wl-tiwai@suse.de>
 <20140826084220.GA17528@sirena.org.uk>
 <s5hvbpf5zn1.wl-tiwai@suse.de>
 <20140826101953.GI17528@sirena.org.uk>
 <s5htx4z5yuv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4032345555138255257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D98BE26514C
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 12:47:35 +0200 (CEST)
In-Reply-To: <s5htx4z5yuv.wl-tiwai@suse.de>
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
Cc: =?iso-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Paul Handrigan <paul.handrigan@cirrus.com>, Daniel Mack <daniel@zonque.org>, Arun Raghavan <arun@accosted.net>, Dylan Reid <dgreid@chromium.org>, David Henningsson <david.henningsson@canonical.com>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4032345555138255257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BqONIA9TJNoFXW05"
Content-Disposition: inline


--BqONIA9TJNoFXW05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 12:28:24PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It was because they aren't automatically probeable without loading the
> > driver and taking a look at the hardware - if a distro wants to use them
> > it ends up having to load and unload the module.

> So he was grumbling about ISA sound card hardware design?  Then I
> understand and agree well.  Though, the fact that it isn't
> discoverable is same on many old embedded device drivers.  The
> difference is whether it's used only in a custom kernel or in a
> generic kernel by distros.

Any embedded devices doing that are just broken - for embedded things
you do always have an enumeration of the devices even if it happens to
come from a data table in software.  For ISA there's no option.

--BqONIA9TJNoFXW05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/GW2AAoJELSic+t+oim9VasP/0cR29dUlE2gANHuYpMzLtnB
ebJFO8LNtKgPV+GicperJX+H7WHlXBVenAXh+vvB0JoehKZnAHmGEimOBp67JLP0
ZmDmuL48Zqip+XJPpX9yANQExDQXE0+tbb0ICVr0wo2emqSJEY8cXDa1ihBs8XY/
hH1HH40PjqKCbANnwxuUGBNfqcCc2WnVfhghKe3PriQn5+2VCfxAxkQ7A2aZ1T4A
usL7U75nGcpoXGkc1c+rfDzaaIo9cAvNyuQGBVC6fUI1qAOjRNhGvED4bU+GdpSu
9/dsG1db2N7dIeMfRKp+XfohXfJgd8QNiI4yLEiJMEBGEv+iWhLw/pRQILwm/ifI
S/wXU5Cz/RO5azwNfOOrAqHBbG6APq2cekDsY5yrkpfFVzwKlZfwsnRM53Hf0BTq
fqoStK1IrhmnBTYJqJevQPk1/rSXdyrsMrgJ/BRcng6OeiC1qV9x6MU6DuVOSezf
8f8AwViAZ6KZrzDxKxg0MKk4E6hdFwrSAyqqSkCxInPAAfU+MbsY2VaNLp4Wz3AB
e/U0O3FOEB2J2ZizoEz6OdNS46bvpRg7Ymt2pIOhpkePiHvzK2bmQmR/dyDCkYx2
zcnl3DEF1srGftC2X9rBePE+Pa3S45zYSMaXnDkMAMccOl/l+lOOIrKFl8F+xhmv
R4o24sHsi/Cdu0uwHp5N
=VGdZ
-----END PGP SIGNATURE-----

--BqONIA9TJNoFXW05--

--===============4032345555138255257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4032345555138255257==--
