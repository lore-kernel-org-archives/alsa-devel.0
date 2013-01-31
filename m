From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ASoC: fsl: Fix multiple symbol definitions
Date: Thu, 31 Jan 2013 08:06:58 +0100
Message-ID: <20130131070658.GB31996@avionic-0098.mockup.avionic-design.de>
References: <1359577471-15029-1-git-send-email-thierry.reding@avionic-design.de>
 <20130131014214.GD2765@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130131014214.GD2765@S2101-09.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 09:42:17AM +0800, Shawn Guo wrote:
> On Wed, Jan 30, 2013 at 09:24:31PM +0100, Thierry Reding wrote:
> > Commit 25b8d31 (ASoC: fsl: fix multiple definition of init_module) fixed
> > a build error due to multiple symbol definitions when building as a
> > module. However, it causes the build to break when the driver is builtin
> > because the imx-pcm.o object is included multiple times. Solve the issue
> > by adding imx-pcm.o to each of the modules that require it, but only add
> > it to the kernel once when one or both drivers are builtin.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Thanks, Thierry.  The Kconfig is already complex.  To avoid having them
> even more complex, I have chosen to revert my patch and have a little
> surgery on the code [1] to make it match the Kconfig rational.
>=20
> Shawn
>=20
> [1] http://thread.gmane.org/gmane.linux.alsa.devel/105018

That does indeed look much better than fiddling with the Makefile. My
automated ARM builds of linux-next were failing for a few days because
of this, so I guess the fix (as well as the MMC one) just hadn't made it
into linux-next yet.

Thierry

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRChgSAAoJEN0jrNd/PrOhNmAP/i9n/hOsn8/wfh9qj2wAJfZp
YKODS1X0L2Q09MYfMPCvHpi86ZshiMuWMCWLT5WHFq5VxXTX3Fo86kTw+FMB3TW5
eq20uoqEPwaYlpdKTAsAJwNXlSJbizrgZZJzIP8eX0uIjg8YSNCS447HywRrg1mW
0CBCkoqlgifrrVtyXkZvyAplrL7dEWUhWdSSsicIudgg8BtGdMmI8ApJ/MYUCH5t
cm/8Z4l4WyoLIqCLvvUIXacm3JR2cGXpDc+bTkycTFYdoyxdPT3VnIuh7HjIkZx7
AGIc0t1KnWZFk6dOOF4uoHdTBYENkueOVBdBVZIY2LS4pfyYzFRRjS0dif2z7Kdf
L/7HPlQHp5d1mxadGs7vs8/7kA4JS8C7Val6WF6j25LduqHHjuQSyFK7J5GyXhTM
xggkmsClwL4yK5x2DVsgmG0No6Ng0KksbnzmHPDA7G2DRMEVg5uuD3WYkQlGI97E
dw9EnIRrXcyMBZFbPCydesk1v/39AE4hSi8xxM+0wMfUsg2DEniwkr3GZzysKyu5
F9GmKhsk69y8aGNolZixWm937CFsd7kpiEYn1RwJa60u4VQSkEXWpS0LHpfbu+VT
OlkyjcIqradPQ6mpWxjNRDfWN3EZEtITBaiF9RT9ZHJ8nJ8dvop9hEzqbQDLi01I
v4+1+ppMBhfMznplYOMm
=f90e
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
