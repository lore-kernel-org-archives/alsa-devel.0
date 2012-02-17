From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
 between DAIs and DAPM
Date: Thu, 16 Feb 2012 21:43:40 -0800
Message-ID: <20120217054339.GB1231@opensource.wolfsonmicro.com>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
	<20120215162412.GG2996@opensource.wolfsonmicro.com>
	<1329399358.28852.19.camel@odin>
	<20120216175955.GE3383@opensource.wolfsonmicro.com>
	<1329457253.24656.7.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2202090166312786751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5671A1039FA
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:43:46 +0100 (CET)
In-Reply-To: <1329457253.24656.7.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2202090166312786751==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2012 at 11:10:53AM +0530, Vinod Koul wrote:
> On Thu, 2012-02-16 at 09:59 -0800, Mark Brown wrote:

> > We actually need to do that anyway for the CODEC<->CODEC links, I've got
> > use cases where there are multiple independant streams going over the
> > same DAI on different channels (eg, stereo pair on 0 and 1, another
> > stereo pair on 2 and 3).

> Is this a TDM DAI you are referring to?=20

They can be, they can also be grouped together to make multi-channel
links.  It's entirely flexible to software on the devices I'm thinking
of.

> > I *think* can get something working quickly that doesn't fill in the
> > blanks for CODEC-CODEC links, though the conference is looking quite
> > interesting today.  I'll try to send something later.

> On conference, when are we planing our next ASoC conference?

Not at present.  It would probably have been colocated with ELC but
that didn't happen.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPejpAAoJEBus8iNuMP3dlvUP/RbLHgrzhkFeNyAPqVPyqU+1
P4nMMdjsHE+JKiH871yyEztEMFh7o7HlSPTrxx1EIGQXufdYr+Ipr68uZPNTu8Ey
kgQwA8d1xzxJfDmgYG+aelcAceBrm3qhbvo7LyMyk5Ifus7r2uck4mWbqqy9k1Kn
ylxJHw3eJhkzWiTFTbDBI7p6XSBAxgDMm0SCGuXlxtxj51rb32vLSsLoS0PlXCIW
Fgqo0umXy2bRhDJbVK0bt6SzGMjaV/MLp1jADxT8xq5EgY0RJD4b+zcEmc7IcTGg
qvSp0ufdjb3fE2cy7Sv5HrbJSOoqzrij+F5hjCPacFMM/N4f884j+MneavrSaOdb
WUau6BEOHqgAgXRXtIu0kFvVGshi1PPDa7X6/VH/V/520W1bPCAPk/3bLIC0hdcq
dHwXnvnknLjNfcWPUDUyFh7edQB4gDBpMABm/oJSq6FhiKcNWlFSm1rpTTfP88sZ
OtMCl+finS+ifBs7KH+LBt5p/lL/jCWa2cnhQc71cesJxtU0tRM9QCt6tR2j9oJf
FfmZVNk/Q/1HV4YdUdMIDtD5nGXj/VjnWd5wwHYuXr3iObKCfC+FuKYGpuzyi1dY
RV+g+PtR4xWCKWXXpV1TqwgKc5ESNZpzaXAJOmZaszdhgBE8GbAHp4P9y2zSbn1x
07z7eQQu3if0kGTVGDTE
=tuN3
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

--===============2202090166312786751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2202090166312786751==--
