From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Fri, 9 Mar 2012 12:12:38 +0000
Message-ID: <20120309121237.GG3273@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<4F5910EE.8090408@freescale.com>
	<20120309011914.GF2499@S2101-09.ap.freescale.net>
	<4F5966DC.6090201@freescale.com>
	<20120309071347.GM2499@S2101-09.ap.freescale.net>
	<CAAQ0ZWQHm+SZgDA6x93=Q9CxAqz6uVu1F2UPBc=zafrhT71D1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2666428099574427948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F319C10B990
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:12:41 +0100 (CET)
In-Reply-To: <CAAQ0ZWQHm+SZgDA6x93=Q9CxAqz6uVu1F2UPBc=zafrhT71D1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>, lrg@ti.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============2666428099574427948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 03:28:22PM +0800, Shawn Guo wrote:
> On 9 March 2012 15:13, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Fri, Mar 09, 2012 at 02:11:41AM +0000, Tabi Timur-B04825 wrote:
> >> Shawn Guo wrote:
> >> > Are you testing the patch set on top of the SHA below, which I
> >> > mentioned in the cover letter?
> >> >
> >> > =A0 =A03030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm=
/linux/kernel/git/broonie/sound into topic/asoc)

Adding Liam who I just noticed isn't on the CCs.

> >> It appears the problem is with for-3.4 itself. =A0I'm running git-bise=
ct now
> >> to narrow it down.
> >>
> > My bisect tells that the offending commit is:
> >
> > =A096acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component=
 mutex)
> >
> > But I do not understand why yet.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ INFO: possible recursive locking detected ]
> 3.3.0-rc4+ #159 Not tainted
> ---------------------------------------------
> aplay/395 is trying to acquire lock:
>  (&codec->mutex){+.+...}, at: [<802f7414>] soc_widget_update_bits_locked+=
0x88/0x
> 1a0
>=20
> but task is already holding lock:
>  (&codec->mutex){+.+...}, at: [<802f9df4>] snd_soc_dapm_stream_event+0x38=
/0xc0

Ick, right.  We need to create that separate I/O mutex I think...
Perhaps we should punt the locking change until 3.5 too, there's no
non-CODEC DAPM in 3.4?

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfOuAAoJEBus8iNuMP3dQBsP/AvbLVB/80r6sNLjAM/A3PiO
RSM+Q/n0104jArkwfi5osnMOvNpXvVojvENJRcO79i8fvdf/MjtjiWWQlIpfK8G/
pdKvU1ToFpqxQhfjG/UffhRroGlXR/KKrpKzQAkG3o2lrZZvjdvE28CVxhku305i
XZD0/UdC7Ex6jv4DctgSYs2BUuvO30JjDo+Ms3fgZgAVMRfuAqiQubPQY8Dk2UcY
J0Cz6orNWbVGuyEA9SRMfvZRCjxRqtNdX6Hg2bN1eMhDnL8qnZCoP30RbhA+LWEl
Rjwe/BuV3iiY+f1mC4i/D/gaut/HEVRrlvStQXRoLaKgsnM+kU66SV0w3YfbMuI6
e5CxWnp+GIuaZRzHDJROrDR9sQ9Pfk3HW4gfKxD/mHm2+7LQwROIRaBxKi3pf02B
LIZCd7/P/X0N8x6na02/F1nYFoWhn86fYJV+4aZ7KqGT5ZJelGvnguTwQBQfSO71
q/cbYz2x2JYWp1A2XStyei90VNY5pB0X53A/70Nb668oBn9Q28MPaMjGSr7CfDjh
ZEbkHqVYIaH/2O+Cg2y/Hs9y7V8H+B7d72HEkmyoj+oTwgOlsw7Eugs63/GnLQXc
NapCxbaOHpanJI+c+HTeljRev32GXY85Q9L40BYNNCyZf5qNQwBnDnMQFrol8vcz
rTHa5NE/AbsF6lsNmKwk
=Dlxl
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--

--===============2666428099574427948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2666428099574427948==--
