From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: No speaker output with kernel 3.15 and later
Date: Mon, 07 Jul 2014 16:34:10 +0100
Message-ID: <1404747250.1983.1.camel@snewbury.org.uk>
References: <1404050996.31259.2.camel@snewbury.org.uk>
 <s5hr426sqbq.wl%tiwai@suse.de> <1404215372.2290.0.camel@snewbury.org.uk>
 <s5h61jh8fau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7826502026330152208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-10.server.virginmedia.net
 (know-smtprelay-omc-10.server.virginmedia.net [80.0.253.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9742652AD
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 17:34:22 +0200 (CEST)
In-Reply-To: <s5h61jh8fau.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7826502026330152208==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-M/diKV28UMjbAul9ijbg"


--=-M/diKV28UMjbAul9ijbg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-07-01 at 13:54 +0200, Takashi Iwai wrote:
> At Tue, 01 Jul 2014 12:49:32 +0100,
> Steven Newbury wrote:
> >  On Mon, 2014-06-30 at 11:24 +0200, Takashi Iwai wrote:
> > >  At Sun, 29 Jun 2014 15:09:56 +0100,
> > >  Steven Newbury wrote:
> > > >   I sent
> > > >  Takashi an email mentioning this regression a month ago, and
> > > >   it's
> > > >  taken me this long to send this email... :-$
> > > >   Since updating to
> > > >  kernel versions >=3D3.15 I've had no audio from my
> > > >   laptop speakers.
> > > >  Earlier versions worked fine.
> > > >   It's a CLEVO W270EUQ laptop.  The
> > > >  output mixer device is showing up,
> > > >   but no sound comes out at any
> > > >  volume level.
> > > >   As requested I've attached compressed alsa-info.sh
> > > >  output for both the
> > > >   working and non-working cases.
> > > >   I'm perfectly
> > > >  willing to test patches etc.
> > >  Hm, I see no significant difference between 3.14 and 3.15=20
> > > alsa-info.sh
> > >  outputs, and there's been very little change for VIA codecs=20
> > > between
> > >  these versions.  So, in short, I have no idea what went wrong.
> > >  Could you double-check whether it's really a kernel issue?
> > >  That is, switch between 3.14 and 3.15 and confirm the problem=20
> > > happens
> > >  only with 3.15.  Also, for testing the sound, try like
> > >          % aplay -Dplughw -vv foo.wav

> >  Checked again.
> >  3.16-rc2: silence
> >  3.14.3: works fine
> =20
> Then I'd suggest to bisect between 3.14 and 3.15.
> =20
> =20
Somewhat surprisingly I ended up here:

dcb32ecd9a533f47ab652c5c5680bc50a7a822cd is the first bad commit

commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd
Author: Anssi Hannula <anssi.hannula@iki.fi>
Date:   Tue Apr 8 12:36:42 2014 +0300

    ALSA: hda - Do not assign streams in reverse order
   =20
    Currently stream numbers are assigned in reverse order.
   =20
    Unfortunately commit 7546abfb8e1f9933b5 ("ALSA: hda - Increment
    default stream numbers for AMD HDMI controllers") assumed this was not
    the case (specifically, it had the "old cards had single device only"
    =3D> "extra unused stream numbers do not matter" assumption), causing
    non-working audio regressions for AMD Radeon HDMI users.
   =20
    Change the stream numbers to be assigned in forward order.
   =20
    The benefit is that regular audio playback will still work even if the
    assumed stream count is too high, downside is that a too high stream
    count may remain hidden.
   =20
    Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D77002
    Reported-by: Christian G=C3=BCdel <cg@dmesg.ch>
    Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
    Tested-by: Christian G=C3=BCdel <cg@dmesg.ch> # 3.14
    Cc: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 6ed3a982a9600333b07a42169db5173fa75b8618 b7ff28d00007f988221=
ba58c9d3f501fdb3a7583 M        sound


--=-M/diKV28UMjbAul9ijbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlO6vfIACgkQGcb56gMuC61Q8ACfaO5mt9czlHlyPtEJArLEO66x
xm4AoLqEIswTwsRWUCSt0Lq541IvPWlC
=DZkB
-----END PGP SIGNATURE-----

--=-M/diKV28UMjbAul9ijbg--


--===============7826502026330152208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7826502026330152208==--
