From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 2 Mar 2012 11:45:30 +0000
Message-ID: <20120302114530.GD3230@opensource.wolfsonmicro.com>
References: <s5hhay89pq0.wl%tiwai@suse.de> <4F506816.1050201@canonical.com>
	<s5hobsfsc9j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8274196997222726906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF48224336
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 12:45:32 +0100 (CET)
In-Reply-To: <s5hobsfsc9j.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============8274196997222726906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2012 at 08:16:56AM +0100, Takashi Iwai wrote:
> David Henningsson wrote:

> > Also, in the sound/soc there seem to be plenty of hits for 'Line Output=
'=20
> > which could be changed to 'Line Out', mostly for consistency. Something=
=20
> > for Mark?

> I think we should standardize "Line Out" mixer control name at first,
> e.g. updating the outdated ControlNames.txt document.
> Anyway I'll leave ASoC part as is for now.

There's also a lot of LINEOUTn and so on.  I've no intention of worrying
about this stuff too much for ASoC, the name based routing is mostly
nonsensical there anyway and it's very common for the thing connected to
the line output to actually be another thing such as a speaker so acting
on the fact that it's a line output might be actively wrong at the user
level.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPULLTAAoJEBus8iNuMP3dq2YP/jLJzxI1/SYoUHVmDL//uerh
jx7yMDE5zIJMklFSt2LqSEwrxk9wHsQPJaL4Sr8gtURcBFR10IxmK8mDl9JGHgrH
6rarK4edTpszTk0rS+sPCp6M7Kb6b7V8qp9/9SCd3Zoq9GL1YxdZr/VLDbCYaScd
t5a+Hie8W/xtiWbKXcBJesZ/+hdngA3Gh3Wje4aBGmDYPVQAW/+e4xNq2+Etf33f
wgpDeHJVGNHIZIQzV/35R/0L6MGUrRBIaIbUfBTICF/KwTQzo5LTANWGwhVMaSew
OII2PqROWFL1iP2RQVS7MWf8EZFGXzk3V4epe0ZEAv/8YS5BWOJEfcj/HdrrsrLZ
jkOnTEYRXVC2bd9awws5g54YzqqsxOUFLe8Qok8EmrL2B5f0pWfsKB5d/NePQaAO
eN/TU+23eTR7wZrYDkQPmIzvUq9SYgISko1EoGas//qM6z75/LH+mASkiNNhSlyD
vzV97tFacpx770ggshJ3ucNvmuq3NaXqLJI10LRJhXpCUWSJDQ+SeCK6hTtb4sEA
nMpWt26tQdIrLP81DUCLj12GgmPROQLQpWxdZIwtRnJO+4EoZLA7VS7lH/vszGx1
6D2BlAwP0OdEA528H5OFKm0bNmVqPpKiaaT2G6ix/1ago7g0Q4aZkUUN25YssafM
EvTupzjvqQnBqIY/O53v
=FkLE
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============8274196997222726906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8274196997222726906==--
