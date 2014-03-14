From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Staticise
 non-exported symbols
Date: Fri, 14 Mar 2014 10:23:38 +0000
Message-ID: <20140314102338.GS366@sirena.org.uk>
References: <1394732900-17182-1-git-send-email-broonie@kernel.org>
 <5322B93C.8080403@ti.com> <5322BE70.9030809@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2926373227312239982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 03DFE26518D
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 11:23:47 +0100 (CET)
In-Reply-To: <5322BE70.9030809@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2926373227312239982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZuF+CWsFPFxEfM2"
Content-Disposition: inline


--yZuF+CWsFPFxEfM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 09:31:44AM +0100, Lars-Peter Clausen wrote:
> On 03/14/2014 09:09 AM, Jyri Sarha wrote:

> >/me has added one more thing to his patch sending check list.

> What I typically try to do before submitting a patch is run

> make C=2 .../driver.o
> make C=2 CHECK=scripts/coccicheck .../driver.o
> make C=2 CHECK="smatch --full-path -p=kernel" .../driver.o

> that will typically catch these little mistakes. Also of course
> scripts/checkpatch.pl on the patch itself.

Make sure you're running against the latest development code when you do
this too.

--yZuF+CWsFPFxEfM2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTItinAAoJELSic+t+oim9h20P/3wwXNestgRyixXsp3LBWjQz
NpUxhY43xwPx+6Z4WRIuJO1ODEL8MH9kwxzJUaO056S5VxjvOeNQkNnPWw4nn++2
eiTslK+tmY66cmrskMtsRL2PINfXSNKScflnGLBvkOc1BwrTC7k330ItU2terj4h
bJGRY/fvRs/PTSFGkL9sdIkx0h2qZY3wr7IwPeqpQpz5ahSTSrj4sR9A3HPi7iPl
KaEoloTzYmzrYaTBE/clIoUdEmZUwsFWn9zQ5hVhAR9XHVAZhIlQli79pzyJ5EPn
5yKvQWlD7MAgjbjfKiSd4+ljFv5SBLB9PkyvajqJ+6Or4uLcbHO3ALc2LiAMa4IW
UOha+L5wzjxc4R9bVU0+8oH/1eDXGH/VQH3LbJlN5P7/Wkbmkflg7knjJaDZmZ1M
QCYYrfi8ZADjl2uV+MhxJxPHHwuKmZba4vCFDLuwH6ovJYwUjAX7j0Kc5+IidVX4
UO8vpEMz3q0bdz7kImBZAeQDw6iap2ONESbV9vAi8O/tagW61y33rOy1yr/7gJV2
zGZTs2yI/BiHsBbUw74B+ZjI5ZF5snIgwG3bqvmk6irdPp2BdcflCryVRnLmPUrF
iG0k9tl1KYdItLPd/zOJfkubxb3haahFeOiPc2D25LWT1WlvlVMe0NhFD8dIPfuY
SX03cqa6l8wydZVk8NSq
=nsHQ
-----END PGP SIGNATURE-----

--yZuF+CWsFPFxEfM2--

--===============2926373227312239982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2926373227312239982==--
