From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Tue, 17 Apr 2012 22:29:15 +0100
Message-ID: <20120417212914.GZ6652@opensource.wolfsonmicro.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
	<20120417182204.GV6652@opensource.wolfsonmicro.com>
	<s5hwr5enpau.wl%tiwai@suse.de>
	<20120417194341.GX6652@opensource.wolfsonmicro.com>
	<4F8DCF81.4080508@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3820284684977177603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B1532443C
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 23:29:18 +0200 (CEST)
In-Reply-To: <4F8DCF81.4080508@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org


--===============3820284684977177603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GXk5ufetu984H6pr"
Content-Disposition: inline


--GXk5ufetu984H6pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 10:16:01PM +0200, Pavel Hofman wrote:

> Mark, I have always viewed alsa drivers as split to two parts

> 1. the "PC world" where mostly individual often amateur developers
> post patches improving support of the hardware they own.

> 2. the ASoC world of embedded solutions, where mostly vendors
> contribute patches for the hardware they produce. All ASoC posts are

That's really not a good split - while audio seems to be one of the few
areas where embedded vendors are in the forefront of contributing code
for their own parts there's a fair amount of hobbyist work in the
embedded space too.  The first example that springs to mind is the
Kirkwood support which has never had any involvement at all from
Marvell.  Even where people are employed to work on the code they're
often not working for the device vendor but rather for some other
company who happens to be using the device.

> Even the until recently highly active intel-hda section does not use
> any of the ASoC infrastructure. If you read the ASoC documentation

It wouldn't be appropriate for HDA to use ASoC, the hardware has a
rather different model for how it's constructed - the main thing being
that obviously there's only one control interface for all devices and
you're supposed to be able to write a generic HDA driver which works on
any system using HDA.

> http://alsa-project.org/main/index.php/ASoC, it would not occur to
> me I should be using asoc codecs infrastructure for ice1724 card.

If you feel there's something that could be improved about the wiki
please contribute to it.  Though that said as far as I'm aware the ALSA
wiki is about as actively maintained as the bug tracker which we still
haven't managed to get shut down.  All the content I've ever had any
cause to look at is links to off site documentation, most of which are
now broken as they're to pre-breakin kernel.org, and most of what's
there is extremely old.

> Working hard on series of patches and being met with cold attitude
> as for not adhering to ASoC standards (quoting the alsa-project.org:

It's really the fact that it's not using ASoC, it's the fact that patch
here is adding a driver for a device which already has an in-tree
driver; that alone should be a very big warning sign.  Ending up with
two totally separate drivers for a single device is never a good idea,
if only from a duplication of work point of view.

I'd at least expect the presence of the existing driver to have prompted
a question along the lines of "I can't figure out how I'm supposed to
use this driver here, what am I missing?", or something in the changelog
indicating that this issue had been considered and that the duplication
is a sensible solution for whatever reason.

> If you want these independent contributors to start using the kernel
> infrastructure common in the ASoC "tree", please tell them clearly on
> the alsa-project.org website, at best directly at
> http://alsa-project.org/main/index.php/Developer_Zone

Again, if you feel the documentation needs to be improved please
contribute to the documentation.  I honestly can't see where I'd put any
information so that people would usefully find it, but then like I say
that's largely because it doesn't look like the wiki gets much use so
it'd put me off looking in the first place.  If you're saying people
actively use the wiki then probably you've got a better idea of where
they're looking in there.

> I can understand the very active ASoC subproject is defining current
> standards for the rest of alsa tree but please tell the currently
> valid rules to all the developers.

Like I say the major issue here is further back at the point where we're
ending up with two drivers for one bit of hardware.  That's not
something to do with knowing about ASoC, it's more general good
practice.

--GXk5ufetu984H6pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjeCkAAoJEBus8iNuMP3dyeAP/jWci4BLT7D0ikfKvvk+4HIy
kDTm8Dv/cHAZZ5MxymQF+ur96Pzr0L1NHba6uVs1xynsGQ85NXStG9jCFAwQtYx/
35EMwqVqdOM1L78nI/9KCochldvCnldI6LheJYaItFDDyCK7NtvUoxgDVGB45SyD
2HRXf5V0pbrgfhoS2EZbL8i/ti/LOHUNFaZuum5ErQ80SWCiYOPcpOK/hGapv9tN
j7n3ZYToGtewS1OHqbWpYdoLYOYKUsYvSqrBgqGTaW5tK+qmAJq/25g5OC0EIrHp
BCdn/UGokZ02f6qg6LQESMkltq/4vWXapam3IJlktMAD597urjYKTtCGUcyK/avh
iV3mjNr/wYFijjUKZbWFDu594wQxOkVt1W/pIWFz9QLeXir3Tdqgx32h2DJyu098
cgKnUc7xLGTvqQj717M/LKBTI0SsOZKTqFn5Y5i2AmlKFGswcTPpo6CvGuvQrvg2
1IdEDlblMhoLSFLvjVICoeZe/gKw71rZPuhwNJioudVMh4csFUgj4Lu+KYfO43pu
Bhlznasx0YG1IpgcYoFbYuzQmSG+qugsMdtiXPLn1wCJGxEHXLUReUQMPAxlpzHB
keyWKaf7UhGIWUI7qRca0Cafg8P0sg/ocZeNvSNog+bnGPBnzL1cejT19lZdwZgu
bbmi76EvcDutHNli0ONt
=wdoz
-----END PGP SIGNATURE-----

--GXk5ufetu984H6pr--

--===============3820284684977177603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3820284684977177603==--
