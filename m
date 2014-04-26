From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-ssi: Allow to use driver with
 generic audio card
Date: Sat, 26 Apr 2014 18:22:38 +0100
Message-ID: <20140426172238.GW12304@sirena.org.uk>
References: <1398523756-9740-1-git-send-email-shc_work@mail.ru>
 <20140426165519.GT12304@sirena.org.uk>
 <1398531726.382350493@f372.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0887607955094862663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F0E6260862
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 19:22:54 +0200 (CEST)
In-Reply-To: <1398531726.382350493@f372.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0887607955094862663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jodMLjoLfgSNsO+D"
Content-Disposition: inline


--jodMLjoLfgSNsO+D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2014 at 09:02:06PM +0400, Alexander Shiyan wrote:
> Sat, 26 Apr 2014 17:55:19 +0100 =D0=BE=D1=82 Mark Brown <broonie@kernel.o=
rg>:
> > On Sat, Apr 26, 2014 at 06:49:16PM +0400, Alexander Shiyan wrote:

> > These are cases where we can do configuration but an invalid
> > configuration has been provided and we have spotted an error.  Ignoring
> > that should cause runtime problems - I guess it isn't for you though so
> > there may be something else going on?

> > Especially for cases like DAI format we should probably enhance the
> > framework so that these devices can set a variable in their struct
> > saying what they do support but for now we don't do that.

> Other solution to this problem is to check ret !=3D EPROBE_DEFER
> in the generic sound card. All other cases should be treated as
> good for setup parameters. Is this better?

I wouldn't expect to be getting -EPROBE_DEFER outside of the probe path?
Can we take a step back here, please - what's the problem you're seeing?

--jodMLjoLfgSNsO+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTW+tbAAoJELSic+t+oim9JUIP/iPkTXTFUAu5lE5inR8UWK5w
bWvE7dMSPxaRMzTY5cUy6eD8utjEp0IKKLl3SdwZmthJfp/OO2PcKHjynaHL967h
iFXZfo+N8xNSmyDDiPHxYYuvrMn6T1ayu/xYBLFTjzTc2zlbIjblotHiQ2eXSJa3
lAY8Jq3uyAsHwl4Nfzu0ur2XkT4ZTtFAf7Gr41ixodX5qOD0Mhvm8omxGd2ENG3U
KuovnywLirGhzI91GHwh/KyEk3b0hMvl0Q5dCYp874m/n4+pZNjvC/KAtbjeJ1qK
0YjVIxnbjawMTtINSFbEpNw9Ae3pSCqf7jPQPH356xQw9dY7UR3lXxPKx2klpNYQ
8g02Z1AZq4ipbJF27o08V2DHm4AZG2+tnqnmpnZ6wKR6KywqPmhDsA/MvFUylu4y
OjWb2B28JsL0/y5YFGRvUODezX/3rqb7nqWuJxm3wpNINUmOlSwsIdlMTStvtw0s
ivMuWrPUPyA7K8uMMCbIOdefJXAsYr8A25JKCjpZWmUdGUN7L5cWD6165EtqlZvr
5SzcSh+ZthyDI8sHN96UYhkLGKWhy0pRUoHM/ThTqQbPh8EN+dn1vVKp0WEYNqm+
gQ+4V9hNif/0VpyIuN7uI8hobZOJOTK/R7tKZFFeleKW+c7xH+rC1nzksHoxKrb6
XJfkr4gQ+rUT2l42v4UR
=Wj20
-----END PGP SIGNATURE-----

--jodMLjoLfgSNsO+D--

--===============0887607955094862663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0887607955094862663==--
