From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix pointer
	scaling
Date: Sun, 21 Feb 2016 08:34:57 +0530
Message-ID: <20160221030456.GO19598@localhost>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
 <20160219153345.GO18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2209849420181528575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B8D26054D
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 04:01:05 +0100 (CET)
In-Reply-To: <20160219153345.GO18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Alan <gnomes@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============2209849420181528575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 12:33:45AM +0900, Mark Brown wrote:
> On Fri, Feb 19, 2016 at 11:42:32AM +0530, Vinod Koul wrote:
> > From: Alan <gnomes@lxorguk.ukuu.org.uk>
> >=20
> > skl_tplg_tlv_control_set does pointer maths on data but forgets that da=
ta
> > is not uint8_t so the maths is already scaled in the pointer type.
> >=20
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
>=20
> Please ensure that the name and signoff match up.  I'm fairly sure that
> both are for the same person here but it's not something I should have
> to think about and it is important to ensure that we have signoffs for
> everything.

Ah, sure will do. I think Alan wanted the SOB from his empyer ID. Alan how
do you want me to fix this :) I will send this

--=20
~Vinod

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWySlYAAoJEHwUBw8lI4NHj+AP/A3n5NIx1aEAVqfHD8ZscAng
cIM9FVoEEk3kA5rbfceQ1FVrrOQUhiRjmzqN5jsoqMQBcrfXhO30G9D8dtOWvpT1
Kb2612GakWaegM7k3bR4zrNvC6PNPlGpuigmM/RsHRcLRLL1+VWxz07z2yx1+xdo
miC9REkX8NXjJ8f4QfUllp2uB8bS5Pfgpn+85PrQdSJOgTQc7NHO5wnCzNT9/JOW
u9GAJkPRnE30c4TPeyTuqCrX66qZFnG4tTTNX1KdHXWrV9xCT/gkKgQhpr96tANv
bkPM372nDp9GUx7Jy0M6VrI3W/S626drKFRdoiK9rqxr7LExJBMWRBuFHMO5uVb1
jhalqijPTl+dSQZY016zSmKVNilJDxNv+qUPrvv1AVZ0y4QeaR+vKdOyIqSO3wfP
LTxYXA2DDmc2Gm6iJ+lv3P1Wg+TD3YZokeqx0PJ3WjsAdkLWxGb33s66MpX3CUZq
EMTHEBJ2tAW09pJa/A9VwBcC8IWH5sAI8ly0RfuLO427ml4bUzUnAvi2SahiBuR9
0eRFzC2YCr0dJPmGMp/Swr+ZSIUaBCu494IniX0xA+F/mg1idjn7Mj/us4feSUDe
5vqN9EbxLcT+cIIFDr0uoYK9sXEfYULOiZJFnvXoUBAqAXyQY4fJZ3vH75LdK3ll
SvzB+ayO6suKPA4TocXx
=FNlS
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--

--===============2209849420181528575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2209849420181528575==--
