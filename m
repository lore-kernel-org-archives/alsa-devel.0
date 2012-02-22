From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 22 Feb 2012 18:54:38 +0000
Message-ID: <20120222183249.GB3265@opensource.wolfsonmicro.com>
References: <20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de>
	<20120213192309.GG3494@opensource.wolfsonmicro.com>
	<s5hk43e24la.wl%tiwai@suse.de>
	<20120222171843.GA3265@opensource.wolfsonmicro.com>
	<s5hehtm22me.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5683493512403193008=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADDA6104122
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 19:54:40 +0100 (CET)
In-Reply-To: <s5hehtm22me.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============5683493512403193008==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2012 at 06:34:49PM +0100, Takashi Iwai wrote:

> First of all, we don't agree yet which naming rule to be applied.
> Since your patch assumes the case B, i.e. constant names corresponding
> only to the key type (HEADPHONE, etc), it's incompatible with the
> current implementation in HD-audio.

As I've *repeatedly* said the idea was to prefix the name once we'd got
stuff merged into the same file (which means ripping out the HDA
specific code) but if we're going to have to completely rework the ABI
before you'll consider trying to fix things up in kernel then there's no
point bothering.

> In other words, if I merge your patch now, the only solution for
> HD-audio side for the time being is to disable
> CONFIG_SND_HDA_INPUT_JACK.  That's why I hesitate to merge it now.

Well, that whole config option just shouldn't be there in the first
place but that's another story...

> And, it's why I prefer defining the naming rule at first, thus
> refining the implementation not to conflict with the existing one.

It seems like it's a bit late to worry about the naming scheme to that
extent given that the existing ABI has already managed to get into one
kernel release and looks like it's also going to get into 3.4 as well.

Right now the only tractable fix I can see is to implement something
approximating the HDA ABI in ASoC but that just makes things even worse
=66rom a maintability point of view.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRTaEAAoJEBus8iNuMP3dopMQAImNu6BZb9avdwMifZYpY/ml
q4GCnADaB0J1MNChyB25IbdrnFBjJcCjwlFb5Obg2DOLX+A9igktNj7k2ROvkz0Q
CN6goM1kNk6gxeXqILgGUqmllzyZu9kcmdGMWE0kywYzTGyIBlxou3DkwbeKM/k9
2oBvlS9dYbHm5FYBj5MlLCOBtntqLAXdrHbymmaW4Km2+c0WMA7OCFJCJgoQvu5G
/pufFfXerqPVWchUD9pIdzq1Hl7vWTLweIISVFu+t+eOxsYvvzCnAZuc7Mf9/nmn
J2a7K4yG5SxiEi9tNwy7/455mbiySY3e3tPh30jjXMBPB7TJjcXnOUm4eL98kycI
6lhGouUarhW0ccL7gVgbkbPNL86SbOf10WwyBW9FMkSFmklQv2zUDmM1FRhQbHe9
brIFvO8761mWTeOxO2bv0ke241bpXyFiaDRPei0pyP9lH9rgQG27J9CZmbvXJL9a
guhke1b81Ss3aUyjvH6jW+NnIcC1EM6E1KDPz3FHRfu5kSw3nvFpIQvv3UZUYMp3
+GaHD2GYejmSgN0v++Tng7CmLYsR1Nfn/bci98/8hhkHyS/Pckrk+n5IkAy3ixCx
Sqq2Yh3J1P1b4VsDGpBQt4unLE3sCFtoFdDLYVuNgS8713DuOFfvH/0hmC2qZWhI
XSNFCQPMFJ2aFxCG5ZUW
=wRE7
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============5683493512403193008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5683493512403193008==--
