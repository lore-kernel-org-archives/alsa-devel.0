From: noreply@alsa-project.org
Subject: [ALSA - driver 0000320]: FL is FL+FR and FR is FR+FL
Date: Wed, 30 Jun 2004 09:00:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <22dc0bb4eb73e7e2b93757be68496920@bugtrack.alsa-project.org>
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


A BUGNOTE has been added to this bug.
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
Status:                     assigned
Distribution:               Homebrew
Kernel Version:             2.6.6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-01-2004 10:12 CEST
Last Modified:              06-30-2004 09:00 CEST
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
