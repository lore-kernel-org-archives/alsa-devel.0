From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 17:30:27 +0200
Message-ID: <1239809427.4809.7.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5087773017559974247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BF2824498
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:31:04 +0200 (CEST)
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


--===============5087773017559974247==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-BqhYlymNR9+i76rlBHdr"


--=-BqhYlymNR9+i76rlBHdr
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

Will do, give me a bit.

> > Mind you -- mbp3 isn't really the correct thing for my machine, the
> > microphone also seems to be bad when using it -- but I haven't gotten
> > around to writing a proper description or trying to find it even.
>=20
> Hm, could you be a bit more specific?  "seems to be bad" is relatively
> subjective expression :)

Sorry... Well, I can't seem to record at all right now for some reason,
but here are a few things that are wrong:
 1) master mute has no effect (I think that actually worked before?)
 2) the "Speaker" control has no effect (mute/unmute)
 3) need to set channel control to 6 to get sound at all
 4) speaker volume is line-out * pcm * master
 5) cannot automatically detect codec, need to load with model=3Dmbp3

And the last time I could record sound it was all choppy and sounded
clipped.

johannes

--=-BqhYlymNR9+i76rlBHdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5f2RAAoJEKVg1VMiehFYXfkQAJALS/1hH3l5aJU4niimlbSW
oMgfODBFJgolG0+Sjmd7+nmr+5M8D8mlpnkL1m1Dblx/+12NoIhe4g88nTOrTswE
wGbEZMzjT2QmNJ6sFpYIF9miFEevZbXI/ofbyhqU70+kIhgMeLBxRAYjxJk+Cr7r
LeT39c1bedxJxSLG0c/V01bjHriRtago+qKoOqoCI4ue8ywbuig3JcpNjkw748HS
TH7WtInumWmgbz30b9iHHvYF6jHCDteNNXmxS3hiDev6vFFHWn1UhPlZuizzIso6
O/6QL800EdczOcSB5s8wu0wQj+8CYxBHI7glxzZvOHIPzpzUXrjyJZmNCfwzkGlp
suu5qRHRRv4lHSeFrPKn1TGK0jF1TVPdXmMhCsROOPZSwbgWH65PkG7qoPAx0i/U
qxbwAbijVQV1UUrbx0/3dSuVbb6Q2TWPIdF9mTJbrpTw9mudr9vLI17T4Ug1DIgo
JJM2grK1LXCSiPaOJ302sQUNNyDus0tlOhFcDUQV/0cjqaYFnvXxqnUPFhiV7SFp
b66KdSs47VgCpvjP+Zfly4Si3CL+qYpC0EC2D5R8i1C+evyuiT8TbKOvqv1KtpaF
orkxQf1BxdcSZi6MCcg+bI1Xh1qM7iupLyRJbCQDvKUGHkDZNlIblyqXObmoZHwY
grQ2qHqnmV18OMo/98YG
=LUNi
-----END PGP SIGNATURE-----

--=-BqhYlymNR9+i76rlBHdr--


--===============5087773017559974247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5087773017559974247==--
