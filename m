From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: No speaker output with kernel 3.15 and later
Date: Mon, 07 Jul 2014 17:05:43 +0100
Message-ID: <1404749138.20227.0.camel@snewbury.org.uk>
References: <1404050996.31259.2.camel@snewbury.org.uk>
 <s5hr426sqbq.wl%tiwai@suse.de> <1404215372.2290.0.camel@snewbury.org.uk>
 <s5h61jh8fau.wl%tiwai@suse.de> <1404747250.1983.1.camel@snewbury.org.uk>
 <s5h38edqiqz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4051780016354462561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-10.server.virginmedia.net
 (know-smtprelay-omc-10.server.virginmedia.net [80.0.253.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 45AFC2652AD
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 18:07:11 +0200 (CEST)
In-Reply-To: <s5h38edqiqz.wl%tiwai@suse.de>
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


--===============4051780016354462561==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-g0h7FGbtfwaMSFKXNX9A"


--=-g0h7FGbtfwaMSFKXNX9A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

On Mon, 2014-07-07 at 17:41 +0200, Takashi Iwai wrote:

   > At Mon, 07 Jul 2014 16:34:10 +0100,

   > Steven Newbury wrote:

   > >  On Tue, 2014-07-01 at 13:54 +0200, Takashi Iwai wrote:

   > > >  At Tue, 01 Jul 2014 12:49:32 +0100,

   > > >  Steven Newbury wrote:

   > > > >   On Mon, 2014-06-30 at 11:24 +0200, Takashi Iwai wrote:

   > > > > >   At Sun, 29 Jun 2014 15:09:56 +0100,

   > > > > >   Steven Newbury wrote:

   > > > > > >    I sent

   > > > > > >   Takashi an email mentioning this regression a month ago,
   > > > > > > and

   > > > > > >    it's

   > > > > > >   taken me this long to send this email... :-$

   > > > > > >    Since updating to

   > > > > > >   kernel versions >=3.15 I've had no audio from my

   > > > > > >    laptop speakers.

   > > > > > >   Earlier versions worked fine.

   > > > > > >    It's a CLEVO W270EUQ laptop.  The

   > > > > > >   output mixer device is showing up,

   > > > > > >    but no sound comes out at any

   > > > > > >   volume level.

   > > > > > >    As requested I've attached compressed alsa-info.sh

   > > > > > >   output for both the

   > > > > > >    working and non-working cases.

   > > > > > >    I'm perfectly

   > > > > > >   willing to test patches etc.

   > > > > >   Hm, I see no significant difference between 3.14 and 3.15

   > > > > >  alsa-info.sh

   > > > > >   outputs, and there's been very little change for VIA codecs

   > > > > >  between

   > > > > >   these versions.  So, in short, I have no idea what went
   > > > > > wrong.

   > > > > >   Could you double-check whether it's really a kernel issue?

   > > > > >   That is, switch between 3.14 and 3.15 and confirm the
   > > > > > problem

   > > > > >  happens

   > > > > >   only with 3.15.  Also, for testing the sound, try like

   > > > > >           % aplay -Dplughw -vv foo.wav

   > > > >   Checked again.

   > > > >   3.16-rc2: silence

   > > > >   3.14.3: works fine

   > > >  Then I'd suggest to bisect between 3.14 and 3.15.

   > >  Somewhat surprisingly I ended up here:

   > >  dcb32ecd9a533f47ab652c5c5680bc50a7a822cd is the first bad commit

   > >  commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd

   > >  Author: Anssi Hannula <anssi.hannula@iki.fi>

   > >  Date:   Tue Apr 8 12:36:42 2014 +0300

   > >      ALSA: hda - Do not assign streams in reverse order

   > >      Currently stream numbers are assigned in reverse order.

   > >      Unfortunately commit 7546abfb8e1f9933b5 ("ALSA: hda -
   > > Increment

   > >      default stream numbers for AMD HDMI controllers") assumed
   > > this was not

   > >      the case (specifically, it had the "old cards had single
   > > device only"

   > >      => "extra unused stream numbers do not matter" assumption),
   > > causing

   > >      non-working audio regressions for AMD Radeon HDMI users.

   > >      Change the stream numbers to be assigned in forward order.

   > >      The benefit is that regular audio playback will still work
   > > even if the

   > >      assumed stream count is too high, downside is that a too high
   > > stream

   > >      count may remain hidden.

   > >      Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=77002

   > >      Reported-by: Christian GÃ¼del <cg@dmesg.ch>

   > >      Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>

   > >      Tested-by: Christian GÃ¼del <cg@dmesg.ch> # 3.14

   > >      Cc: Alex Deucher <alexander.deucher@amd.com>

   > >      Signed-off-by: Takashi Iwai <tiwai@suse.de>

   > >  :040000 040000 6ed3a982a9600333b07a42169db5173fa75b8618
   > > b7ff28d00007f988221ba58c9d3f501fdb3a7583 M        sound

   >

   > Interesting.  Does reverting this commit fix the issue?

   > Just run "git revert dcb32ecd9a533f47ab652c5c5680bc50a7a822cd", and

   > test it.

   >

   I just did this on top of my rebased local git tree off linus/master
   and indeed reverting does make the speakers work again.*

   >

   >

   > thanks,

   >

   > Takashi

   â€‹

--=-g0h7FGbtfwaMSFKXNX9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlO6xVcACgkQGcb56gMuC63uUQCgoApBLs00U7pzOCZypBxmPpx+
zoAAn0LiUOCi1r7pKHcd90OMoy6RIuaW
=1G2M
-----END PGP SIGNATURE-----

--=-g0h7FGbtfwaMSFKXNX9A--


--===============4051780016354462561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4051780016354462561==--
