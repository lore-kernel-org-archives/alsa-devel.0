From: noreply@alsa-project.org
Subject: [ALSA - driver 0000320]: FL is FL+FR and FR is FR+FL
Date: Thu, 1 Jul 2004 09:43:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <cf478d736da6bfde6134bb73874f28b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug=
_id=3D0000320
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Voluspa
Assigned To:                pzad
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     320
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Homebrew
Kernel Version:             2.6.6
Resolution:                 not a bug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-01-2004 10:12 CEST
Last Modified:              07-01-2004 09:43 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    FL is FL+FR and FR is FR+FL
Description:=20
Card: Sound Blaster Live!
Chip: SigmaTel STAC9758/59

Between 1.0.5rc1 and 1.0.5a the Front Left and Front Right signals are
combined, which creates real crappy sound:

Front Left speaker =3D Front Left + Front Right
Front Right speaker =3D Front Right + Front Left

Checking the new "Surround Mix" in alsamixer gets even more confusing:

Front Left speaker =3D Front Left + Front Right + Center
Front Right speaker =3D Front Right + Front Left + LFE

There are no differences between the 1.0.5rc1 and 1.0.5a in the
proc/asound/card0/codec97#0/ac97#0-0+regs

Btw, the alsamixer options are getting really out of hand...
Eg a new option called just "Front" (I keep it off since I can't hear any
difference).

Mvh
Mats Johannesson

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 pzad - 06-08-2004 08:40 CEST=20
----------------------------------------------------------------------
I think this AC97 codec problem.

----------------------------------------------------------------------
 pzad - 06-23-2004 15:21 CEST=20
----------------------------------------------------------------------
Could you attach asound.state or amixer output.
And I think, that ac97 register were changed, but there are not in proc
output, because these are in diffrent pages.

----------------------------------------------------------------------
 Voluspa - 06-24-2004 10:48 CEST=20
----------------------------------------------------------------------
OK, rechecked and the /proc-registers are set the same in 1.0.5rc1 and
1.0.5a. Installed 1.0.5a without loading the rc1 asound.state, and
handcrafted a new with alsamixer. Having set all options equal to rc1, th=
e
asound.state file indeed shows some differences.

Uploading asound.state-1.0.5rc1, asound.state-1.0.5a and the diff
asound.state-diff-1.0.5rc1-1.0.5a

----------------------------------------------------------------------
 pzad - 06-30-2004 09:00 CEST=20
----------------------------------------------------------------------
Could you try this patch ? It is already in alsa CVS.

http://sourceforge.net/mailarchive/forum.php?thread_id=3D5027384&forum_id=
=3D33141

----------------------------------------------------------------------
 Voluspa - 06-30-2004 15:36 CEST=20
----------------------------------------------------------------------
I'm glad that the code review you did amounted to _some_ kind of bugfix
after
me having sent you on a wild goose chase, Peter. This bug report can be
closed, 'cos it's (probably) no bug at all. Sorry... Here's what
happened:

During the development of the STAC9758/59, I kept alsa-driver-1.0.4
updated
by patching in the relevant file changes (no CVS pulls, just manual
changes).
Last date was May 14. The _perceived_ breakage happened between that date
and
1.0.5rc1 - not 1.0.5a as I believed.

1.0.4 + patches had /proc/asound/card0/codec97#0/ac97#0-0+regs
[...]
0:20 =3D 2000
0:22 =3D 0000

The bit in register 20 means "3D EFFECT ENABLED", but the "33" value I
had
set with the alsamixer tool didn't take effect (would show up as 0004 in
register 22).

1.0.5rc1 had /proc/asound/card0/codec97#0/ac97#0-0+regs
[...]
0:20 =3D 2000
0:22 =3D 0004

And we see the "LINE_OUT SEPARATION RATIO; (LOW)" of "3D stereo
enhancement
function, SigmaTel Surround 3D (SS3D), built into the AC'97 component".

If mixing Front Left and Front Right signals is part of how a 3D effect
is
achieved, then this is no bug. But using a 5.1 speaker system I can only
say
that the effect sounds terrible... So, in the future I keep "3D Control -
Switch [Off]".

Now using alsa-driver-1.0.5a plus the CVS patch you referred to, and all'=
s
well.

Once again, sorry about the fuzz.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
06-01-04 10:12 Voluspa        New Bug                                    =
 =20
06-01-04 10:12 Voluspa        Distribution              =3D> Homebrew    =
   =20
06-01-04 10:12 Voluspa        Kernel Version            =3D> 2.6.6       =
   =20
06-08-04 08:40 pzad           Bugnote Added: 0001294                     =
 =20
06-23-04 15:21 pzad           Bugnote Added: 0001335                     =
 =20
06-24-04 10:47 Voluspa        File Added: asound.state-1.0.5rc1          =
      =20
 =20
06-24-04 10:48 Voluspa        Bugnote Added: 0001336                     =
 =20
06-24-04 10:48 Voluspa        File Added: asound.state-1.0.5a            =
      =20

06-24-04 10:49 Voluspa        File Added: asound.state-diff-1.0.5rc1-1.0.=
5a    =20
             =20
06-28-04 09:14 pzad           Assigned To               =3D> pzad        =
   =20
06-28-04 09:14 pzad           Status                   new =3D> assigned =
   =20
06-30-04 09:00 pzad           Bugnote Added: 0001348                     =
 =20
06-30-04 15:36 Voluspa        Bugnote Added: 0001349                     =
 =20
07-01-04 09:43 pzad           Resolution               open =3D> not a bu=
g  =20
07-01-04 09:43 pzad           Status                   assigned =3D> reso=
lved
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
