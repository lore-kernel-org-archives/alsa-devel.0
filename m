From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 09:17:09 +0100
Message-ID: <20120502081709.GA4075@opensource.wolfsonmicro.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
	<4FA0EBF7.2090903@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6247583494139526012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA686243C5
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 10:17:11 +0200 (CEST)
In-Reply-To: <4FA0EBF7.2090903@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6247583494139526012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2012 at 10:10:31AM +0200, Ola Lilja wrote:
> On 04/30/2012 12:04 PM, Mark Brown wrote:

> > The code I'm referring to is this:

> > which is definitely compile time.  It's not the factoring stuff out,
> > it's the way it's been done.  Library code like Tegra uses isn't a
> > problem but this sort of arrangement does cause problems.

> OK, the thought with this was to be able to activate/deactivate the individual
> codec-drivers since we have several separate codecs on our Ux500-platform (Note
> that in this patch-set there is not patches for the other two codec-drivers).
> Since we already knows at compile-time if any of these three codecs are present
> we did it this ways, being able to add them separately in menuconfig.

This really isn't the idiom mainline is looking for, you should be able
to build a kernel which will boot on multiple boards.  There's a reason
why you don't see this sort of ifdef in other code...

> How could we solve this? All three codec-drivers has dependancies to other stuff
> being activated in menuconfig.

Like I say, library style code like Tegra has is totally fine if there's
stuff that can usefully be shared.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoO19AAoJEBus8iNuMP3dDyEP/3kNNXwbKYx9Sehu767JzfSj
rhyWNsklhOXCLYe2fH6cGoTyScI1/3vzawIRYFK/0fF2ymPVjiAIk0/OW5gYoqce
QFrGEVp7VR1Ar0wZXKqH/hPbkh9zaZZvEE6r2xCq/lPPiJDAFEgyB6JztBTNCo/L
t/MqBnP3DC2FDZu95XtMq6pnBd8v8nJcXwo9Zm2en5QmCkzvHbnbWVJanE6QlZx0
8IJqosRTPM1R2W4nXJCyheG/uM7TMgc9ZJwrPQG0+a/HXpv5+TkyFygxIsLid3jn
OCDE47PkQAdLydgPKkMld6+jNBdWkfvr8LP63ZAC8VE9asmhvnmGeWq9Ps7e8UDQ
LdCcsPxx+oVf93iZDy1VjYGum43aFPySPMAhruk0g5Ydv1zgVsiHKxyplH8D2E/F
/PSmNu8+ci3cETfl1nYN5TTUdCpD+1fNEdv2Ees4kX05bUI8erB916YaflN+h7az
hqdAHI+J5XKFTjggXtS3RdojrcEMp50bhHhA541yBtQODBDe8nzAw0NJIPXqi09O
mmkAJQcrDOjXbCEdW62UNTF5biTJDF+RWH0RJuT2PRwX+CxWpMRDIaJGE0mSxH1C
VbFjVS5cLVvGT/xwcw5MCRmHnuRtJPSG2CyEC2WfaopsqU1Jqs/FN/1YpWMcfjCZ
bWM8kRqVo+/HxjrCHMcm
=zNfv
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============6247583494139526012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6247583494139526012==--
