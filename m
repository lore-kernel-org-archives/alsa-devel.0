From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Sun, 15 Dec 2013 19:21:16 +0530
Message-ID: <20131215135116.GR29580@intel.com>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3551985920273718310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C1DE261AED
 for <alsa-devel@alsa-project.org>; Sun, 15 Dec 2013 15:50:04 +0100 (CET)
In-Reply-To: <20131212104347.GH11044@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Nenghua Cao <nhcao@marvell.com>, Henry zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============3551985920273718310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 10:43:47AM +0000, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 04:06:59PM +0800, Nenghua Cao wrote:
> > From: nhcao <nhcao@marvell.com>
> >=20
> >     DPCM can dynamically alter the FE to BE PCM links at runtime based
> > on mixer setting updates. DAPM has provided common get/put function for
> > mixer/mux. But these function doesn't call soc_dpcm_runtime_update()
> > func to update pcm links. This patch defines a DPCM DPCM kcontrol. For
> > this control, the common get/put function will update FE to BE links
> > dynamically. This patch has no impact to the current code.
>=20
> Why shouldn't we just add the DPCM update to the standard controls -
> what's the benefit in defining a new set of controls?
Precisely my thoughts too, I think that would be a better approach!

--
~Vinod

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSrbPUAAoJEHwUBw8lI4NHwMsP/0GWTe+Wi/xeQjUqxljdCfSQ
0fCt6dMhev2M6sVRV2lYqgvFNmQrOU/xUc5flYDpdV+LxqauVEDtjwkuR83ovv8m
a8UxRfC7mlIHosqov2yZYoPBj4mNyvrPucusbhr+vm9QFIp1nasHO7LV7w1WvZ9N
2fxs5yv9itpMtDZkm/LwRhW9MQ+53p2xi9eWMPfFFbcioXLH91LL9PIWpR5H9+0b
R+MKFPpDakIW3cgTVDVDGf2m/S/I5nipqpJ4C/wG7lgtolLPESNpYv2kWay/s5Ss
p9VGeM5/+kZcMOpOcgPBWVPGWPWgOspVF/e3TOnqLTJBhZSqJKD+qWHjTixIYrzn
cLUmBHNbbIBq0kiKNzJdQBzJMAiXIwMgDpSGFfseFTKNp6+N9fJcsmnLtyHNgUlg
zMsuDNksgWIf4DsFp2qvk2gg5zwvRC3DCl0B3v7CSgApveqQMLJQfHjgqZqytZaS
cQjYuv+S2ScBeGeXMON/9lYq8vCluBDZPohFHlXApfcauey1f3D1rxOUHZSa2TpL
K5uZdzPkcxhhh5V15DdaasAq8GZsQdI7l6U129e0jGU8sJjpdctOKlTE/TMUOcmQ
6dIqSnfTRCMIqHV3hhZq6dWc9UUEDogdYwCUSbsNhTkKi9+Hj0ebUKNXQVqrvRWX
Y4nSkQnDgteo5kC7izNq
=kFkw
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

--===============3551985920273718310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3551985920273718310==--
