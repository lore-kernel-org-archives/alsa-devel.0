From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Baytrail: Fix implicit
 declaration of function 'memcpy_fromio'
Date: Wed, 26 Feb 2014 23:47:27 +0900
Message-ID: <20140226144727.GB2394@sirena.org.uk>
References: <1393420341-31625-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1393421506-2411-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4420116832343769669=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9AD2656A3
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:47:35 +0100 (CET)
In-Reply-To: <1393421506-2411-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4420116832343769669==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 03:31:46PM +0200, Jarkko Nikula wrote:
> Some kernel configurations can cause following build error:
>=20
> sound/soc/intel/sst-baytrail-ipc.c: In function =E2=80=98sst_byt_get_dsp_=
position=E2=80=99:
> sound/soc/intel/sst-baytrail-ipc.c:744:2: error: implicit declaration of =
function =E2=80=98memcpy_fromio=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>   memcpy_fromio(&fw_tstamp,
>   ^
> cc1: some warnings being treated as errors

Applied, thanks.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDf58AAoJELSic+t+oim9/qUP/3zKFlYm/ti0zz8Q1BipJxqu
PZZY9IFKz6Y4VXuJztXtCLKZPryjHKZ8OVTi3EczJqDuXPQ3yA2e6lwye+s0NUwd
C2g3B1zMTBGdpHloDmAx/UScelEJ3Pq7R+v28kc/5x+Oe1RoVC1AHCIz8DyMjldT
S2+eBq0ad9qs+ASWmp9XED1/RdJFU+Jdj6e6PoJUlFeT4I/kiH+FjTQbQj74gRGx
YYvqrE8HhCSqTRfnps9E8x/he0voVeNZhe8eR+Ui2Kt7xr6o1rnQCdF54Aa4rRAo
aFfjR1FG5ibkeoFz6hOtN8AqS88uBxih0EBiQqys+MvFWHukBMLRGe+Pwr+aUJR5
uI84Ln0Fj2qO9Rj/LU9YdGLx7WZAIXxZDiiqEZTSyHfU0nAYUiJX8lJ+T014Fizm
aAFtbTKChDnZ1VdihDPinwt9C4lCd1i3RZVrqxbwfJ9OOA/iGvYQ/OVaV+9rbvte
NeUFCY9CLXwcYzWfcrPe4buHfXDgqhNx6ILY6jQSK9igKgxQeSMFxQlXCIYn65kW
tWpxKmA4FWuoldbGh4LA8FNl/YxnQkeYwwDBk+B71d2SNXj+c/4WxZ220FMD2k5X
cTaQvLsKhtAw2/bZ6a/+GOdwSSw6J8boCvRa9M97OkOU23IhO8XxD+cXGliTD2ZD
Njzb6VmOQFR/540w1sJk
=lOh9
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--===============4420116832343769669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4420116832343769669==--
