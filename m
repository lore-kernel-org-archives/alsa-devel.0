From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 1/7] ASoC: hda: Add skl dsp init and
 registering with SST IPC lib
Date: Sun, 26 Apr 2015 19:23:25 +0530
Message-ID: <20150426135325.GP2738@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-2-git-send-email-vinod.koul@intel.com>
 <20150424173657.GA22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4873358070995963894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 194952606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 15:56:15 +0200 (CEST)
In-Reply-To: <20150424173657.GA22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4873358070995963894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:36:57PM +0100, Mark Brown wrote:
> On Sun, Apr 19, 2015 at 02:27:27AM +0530, Vinod Koul wrote:
>=20
> >  config SND_SOC_I2S_SKL_MACH
> >          tristate "SOC Machine Audio driver for SKL Onboard I2S"
> > +	 select SND_HDA_DSP_LOADER
>=20
> Looking at what this is modifying it really looks like there's some
> other patch series I wanted to look at first?
Yes that was the SKL PCM driver series. I will repost that in this week
along with few more changes, so you can look at updated series.


>=20
> > diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
> > index 0cc2ac69a9ab..914ea05da6aa 100644
> > --- a/sound/soc/hda/hda_skl.h
> > +++ b/sound/soc/hda/hda_skl.h
> > @@ -1,15 +1,3 @@
> > -/*
> > - *  This program is free software; you can redistribute it and/or modi=
fy it
> > - *  under the terms of the GNU General Public License as published by =
the Free
> > - *  Software Foundation; either version 2 of the License, or (at your =
option)
> > - *  any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful, bu=
t WITHOUT
> > - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or
> > - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lice=
nse for
> > - *  more details.
> > - */
> > -
>=20
> Oh? =20
Terrible :(

Will try to see these dont creep in patches

Thanks
--=20
~Vinod

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPO3VAAoJEHwUBw8lI4NHDGsP/2LE8CJ8a7i33o64n1QUlVEL
pTSPvQ0y8yH867BEU/JIdT55gYIHbniy2xOxsXOu2VwFw84Y/GC9YFA3IRT9R49T
FvfDwVBkj+elKVUZo0cCXs4R8cP9GH0R3JXeFgu1TzTx86lMynB7afkeM0uSa4oo
C5kAKIiOHXREhicG/OS4S60vmzcbcou09EnherexTED7to2D5aer9uaIi33L3aP7
/nW0v6y4lLFlm0Jz02LYvfLG+CsE0UdieNoY1Ogh/CEG+Doct8W9+4iS88ttMoG8
mCBC3TiX8rlk7dsIg6qMtDqX+f7C3vNpsiglDMdnrQZLSQBVP1bywbsY3UhemJKm
88+a41iVq5wL6WLPxOZGWyv+Gx1REXZt7DjIGGv/2OzKU0rL3oiPNQzrL0muMJG3
jwJDs77Ir7rw8p0BmZJYhg1TnT8jRF5QpB63H2Ubb+BuDef5j2H7v12h8MjoZDsB
GFaGs/glbQLrqaPC6gyyqwHqha+vXVhx46qIKp6y4JIKFMP1JEKgjU+kn/2imBRR
6XGMo9dHYRBkZm+lrvgKDSz8bqDggzczOWkzGAr+DIhsnzTPHlqfS+un2tdwqdkC
CJ5O3nWpDjuPc+a5dqwp7EBk0zVD0kV/Tu0uMJ9gIpCmuBDdHCmdS9886oWxKwoq
Bl8ewVvEfBD0+SG8jHny
=EUu3
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--

--===============4873358070995963894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4873358070995963894==--
