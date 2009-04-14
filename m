From: Mackenzie Morgan <macoafi@gmail.com>
Subject: Re: hda-intel channels hibernate bug
Date: Tue, 14 Apr 2009 11:45:58 -0400
Message-ID: <200904141145.59252.macoafi@gmail.com>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3034302934990132245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f130.google.com (mail-qy0-f130.google.com
	[209.85.221.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D9BC243C6
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 17:46:03 +0200 (CEST)
Received: by qyk36 with SMTP id 36so822753qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 08:46:02 -0700 (PDT)
In-Reply-To: <1239716613.22047.2.camel@johannes.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3034302934990132245==
Content-Type: multipart/signed;
  boundary="nextPart1360169.LAvD5D3ois";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1360169.LAvD5D3ois
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 April 2009 9:43:33 am Johannes Berg wrote:
> On Tue, 2009-04-14 at 15:40 +0200, Takashi Iwai wrote:
>=20
> > >  Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> > >    Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> > > -  Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > > +  Amp-In vals:  [0x80 0x80] [0x00 0x00]
> > >    Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
> > >    Amp-Out vals:  [0x25 0x25]
> > >    Connection: 2
> >=20
> > So the widget 0x0d is muted.  Maybe the channel mode control
> > doesn't do caching the value properly...
>=20
> No idea :)
>=20
> > Could you give the raw alsa-info.sh output?
>=20
> Sure, below (before hibernating).
>=20
> Mind you -- mbp3 isn't really the correct thing for my machine, the
> microphone also seems to be bad when using it -- but I haven't gotten
> around to writing a proper description or trying to find it even.

Maybe being the wrong quirk means its being initialized wrong.  I think you=
=20
said originally that a proper quirk for it hadn't been written yet though,=
=20
yeah?

=2D-=20
Mackenzie Morgan
http://ubuntulinuxtipstricks.blogspot.com
apt-get moo

--nextPart1360169.LAvD5D3ois
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknkr7cACgkQojm3DbyNMmkuwACgtzTmXuZQAA8oPgeYDJowD/Lg
TlcAoIJcTRIE8+aishmjZJF5GbWf3n4Q
=7MNJ
-----END PGP SIGNATURE-----

--nextPart1360169.LAvD5D3ois--

--===============3034302934990132245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3034302934990132245==--
