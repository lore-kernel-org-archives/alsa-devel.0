From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 17:40:02 +0200
Message-ID: <1239810002.6981.2.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0254710279895475843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 62EBC244AB
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:40:35 +0200 (CEST)
In-Reply-To: <s5h63h60zwf.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0254710279895475843==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Tpb5rh7rQwylrJQvR5vF"


--=-Tpb5rh7rQwylrJQvR5vF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 16:12 +0200, Takashi Iwai wrote:
> At Tue, 14 Apr 2009 15:43:33 +0200,
> Johannes Berg wrote:
> >=20
> > On Tue, 2009-04-14 at 15:40 +0200, Takashi Iwai wrote:
> >=20
> > > >  Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> > > >    Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D=
1
> > > > -  Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > > > +  Amp-In vals:  [0x80 0x80] [0x00 0x00]
> > > >    Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=
=3D0
> > > >    Amp-Out vals:  [0x25 0x25]
> > > >    Connection: 2
> > >=20
> > > So the widget 0x0d is muted.  Maybe the channel mode control
> > > doesn't do caching the value properly...
> >=20
> > No idea :)
> >=20
> > > Could you give the raw alsa-info.sh output?
> >=20
> > Sure, below (before hibernating).
>=20
> Thanks.  Could you try the patch below?

Yes, this helps, thanks. Mind you, if I play music with mplayer _while_
hibernating, I get a horrible buzzing when waking up and mplayer says:

[AO_ALSA] alsa-lib: pcm_hw.c:727:(snd_pcm_hw_resume)
SNDRV_PCM_IOCTL_RESUME failed: Function not implemented

Needed to kill mplayer but the channels control is remembered properly.

johannes

--=-Tpb5rh7rQwylrJQvR5vF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5f/PAAoJEKVg1VMiehFYmdEP/0A/hZG2D/o5CzVzRP2lG9SF
jqIA96DDIt9TeNkw9gcydFVVBePxCvyVJKZdiIQb+v2B/WO1r4M5eNeD5zht/AqL
UTlaTioBoh8g/1L3Z9YZh8752jlROw+4mbikvj03+SU+O+Hln/k7GOm28vFd01IL
oQdNqPZVrmtyDWs7MHOFnym8P9NGDjO7dz18qNcwwXqdLgexyJAR56Fpe9Jaccr3
JaRubNI/2xsvI6JWbHz/xHORbPBz5nMmvYptEmc7CMB0UTo0t2xJmBACHrQxtHRl
PLJPT/s/+zLSGviXTX8KGqe2Bno7AjEOYPDk4kOu//7hUSqBZqtSDeAf+nSJLlzh
bDN0P6rk5qu49teK8H6uZynfFN+i+Ar+33L3+NBlIdxZzsN+Yk/v0jB5hyTADbFr
BP8aZ1/SFAm1GRlnFmATrougCuNnzeicrS/E/kkHjKlB+vJK6kB68z0ymtOtxbsC
C+IcT1a6QwqGi9RIZqMFP/78lXzvHaAsUosORUIfAJKssz2TaYKwNVUPW4koUyDN
8aVpm7WTNLaJ+ByRvmZpXpGasknrAhR/wosLBg/t/ZL46Eci4Zr2sU2/9jpDiihn
EvppcFbMcz55+iBoYwyLaZipinXjNxrmmg35k801pIeIyqf7ediyBHW1uNrP0kth
KORjVh2Ms7juv8GuEck3
=i3GR
-----END PGP SIGNATURE-----

--=-Tpb5rh7rQwylrJQvR5vF--


--===============0254710279895475843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0254710279895475843==--
