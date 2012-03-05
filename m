From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 5 Mar 2012 20:34:09 +0000
Message-ID: <20120305203409.GA3224@opensource.wolfsonmicro.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
	<1330958882.4370.15.camel@odin>
	<20120305152616.GS3224@opensource.wolfsonmicro.com>
	<1330962910.4370.21.camel@odin>
	<20120305164532.GU3224@opensource.wolfsonmicro.com>
	<1330967112.4370.23.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0171264028410536084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FAA91043FD
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 21:34:12 +0100 (CET)
In-Reply-To: <1330967112.4370.23.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0171264028410536084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PAKmkkBo0+rTwAqJ"
Content-Disposition: inline


--PAKmkkBo0+rTwAqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 05:05:12PM +0000, Liam Girdwood wrote:
> On Mon, 2012-03-05 at 16:45 +0000, Mark Brown wrote:

> > control_rwsem isn't in mainline...

> Sorry, my typo controls_rwsem. Mostly used in sound/core/control.c

Oh, ick.  Right.  This is a bit nasty.  So, the ALSA core is assuming
that we won't lock against ourselves during probe, which is actually not
that unreasonable given that the driver model guarantees that probe
isn't going to get called multiple times.  Now, if Grant's probe
deferral stuff makes it in to 3.4 (which would be nice anyway and is
looking likely) we can actually pretty much do that as the driver core
will do the waiting for things to come up bit for us which is the main
thing we're worried about here.

That said there are cases where we want to do a DAPM run due to
interrupts.  Currently we're actually just suppressing all those DAPM
runs so perhaps we'd be home free, we'd just need to worry about widget
status updates and that's much more localised.  But let's just add the
nested mutex for now (well, I guess for 3.5 at this point - Linus is
threatening to open the merge window this week so probably shouldn't be
pushing much new stuff in now) and take another look later.

The other nicer thing to do would be to fix this at an ALSA level - the
controls_rwsem looks like a good candidate for something like RCU, it's
a read mostly list with very infrequent updates so even a rwsem is more
heavyweight than we need.  The index offset stuff does make things very
slightly more complex though I think it's tractable.

--PAKmkkBo0+rTwAqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVSMYAAoJEBus8iNuMP3d3X8QAJCR0BCIwIpbgr8Xq7zRJ/Pr
4jdckqiLjuWmkWk84maJhLppNfy3VtNOKanDCcRYo7z4x8VyYwsuSeIqd7hnbYYo
kMYW3+MnfqJcldxL7sJQVtXNEAcTkdtiIFu3hQlC6+VDukCW47ajosDURAyCxHQB
cIll/drB/1Y/1+2XNM1q5O/jM00XMdVIdyZjZ12X/wm4KJMzsP7RGjedn5ra4dAY
hBuOwbJTpGnaMlbqDYxcGIb7uuA/t/Fi5ybHHS40JuSy6j5CGX5v61ckFSSe285z
s2oHI6PXTHYrnU3HxD+IwFGaUpjg9T35OpiwsGQbXe+F2i1RF5mc5U96BrbEOq+8
OCj861Ve/QSnDLokqDDxBWoCWDTeYARrRc/fAav6OnctHmVkyuVotbnbHg99Rad2
cK6Iq5BQZhcS8qOSDN+en9fbUE7GGB+GAEhzxVE5VcmXon9t7yQgvcktalX//bAB
sjXFpKOns0RtmZwAcTWnb0pwxuNqUbYoZJ5SYzk462wUEEuOL419m+RLtRpFHrKB
W7DT51qRQTYj167oHPuk0bCJRoCh0I5kRBXFLjyfVCw73lSSWueFQIm4ZBysMYFb
UZgUWcFjm3uAmQpv0iOBn9ULzQpstKK2Cq1OTBbwKYMixfyicjomldca5QsTSD9T
jEdBEaU7p050T/3vnj06
=GSub
-----END PGP SIGNATURE-----

--PAKmkkBo0+rTwAqJ--

--===============0171264028410536084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0171264028410536084==--
