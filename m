From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Date: Sat, 27 Dec 2003 16:33:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1072535590.12308.250.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>
	 <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>
	 <1072527874.12308.100.camel@nosferatu.lan>
	 <1072530488.2906.1.camel@wires.home.biz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dn4FlXbteVKNVArPTiyt"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1072530488.2906.1.camel@wires.home.biz>
To: Edward Tandi <ed@efix.biz>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, perex@suse.cz, alsa-devel@lists.sourceforge.net, Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>, Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>, Stan Bubrouski <stan@ccs.neu.edu>
List-Id: alsa-devel@alsa-project.org


--=-dn4FlXbteVKNVArPTiyt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 15:08, Edward Tandi wrote:
> On Sat, 2003-12-27 at 12:24, Martin Schlemmer wrote:
> > On Sat, 2003-12-27 at 13:44, Edward Tandi wrote:
> > > On Sat, 2003-12-27 at 11:11, Martin Schlemmer wrote:
> > > > On Sat, 2003-12-27 at 09:50, Martin J. Bligh wrote:
> > > > > Something appears to have broken OSS sound emulation between=20
> > > > > test2 and test3. Best I can tell (despite the appearance of the B=
K logs),=20
> > > > > that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
> > > > > understands the sound architecture better than I can fix this?
> > > > >=20
> > > >=20
> > > > I wont say I understand it, but a quick look seems the major change=
 is
> > > > the addition of the 'whole-frag' and 'no-silence' opts.  You might =
try
> > > > the following to revert what 'no-silence' change at least does:
> > > >=20
> > > > --
> > > >  # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
> > > >  # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
> > > > --
> > >=20
> > > Thanks, that fixes it for me. I too have been seeing terrible problem=
s
> > > with XMMS since the early 2.6 pre- kernels.
> > >=20
> > > Because it only happens in XMMS I thought it was one of those
> > > application bugs brought out by scheduler changes. I now use Zinf BTW
> > > -It's better for large music collections (although not as stable or
> > > flash).
> > >=20
> >=20
> > Can you check which one actually fixes it ?
>=20
> Yes, its the 'whole-frag' line.
>=20

Well, I can't say I can see why. In snd_pcm_oss_write1 where the change
for whole-frag was, I cannot see a race or such.  The only possible
causes I can see, is that:
1) xmms's scheduling gets screwed due to the short writes
2) some drivers may have issues with getting short writes all the time.

Only problem with 2), is that Zinf works fine for you, so I guess the
only thing to assume is that either Zinf do not use OSS, but ALSA
interface, or that 1) is indeed the correct answer.  What version of
XMMS do you use btw?


--=20
Martin Schlemmer

--=-dn4FlXbteVKNVArPTiyt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7ZgmqburzKaJYLYRAtxAAJ9JcBeiDOE8mrwaX6TPvTLUQ89O7gCfcJ2W
eQ8YbjDpOw1GLxHdjY9w8Ew=
=2HfR
-----END PGP SIGNATURE-----

--=-dn4FlXbteVKNVArPTiyt--
