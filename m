From: noreply@alsa-project.org
Subject: [ALSA - driver 0000334]: EMU10K1, capturing audio is impossible
Date: Mon, 28 Jun 2004 09:15:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <f2810cb0430ded19934368d4bf56a515@bugtrack.alsa-project.org>
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


The following bug has been ASSIGNED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug=
_id=3D0000334
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                netslayer
Assigned To:                pzad
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     334
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.7rc love-sources
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-13-2004 23:30 CEST
Last Modified:              06-28-2004 09:15 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    EMU10K1, capturing audio is impossible
Description:=20
I have an Audigy (EMU10K2 -- on EMU10K1 drivers). It has worked perfectly
in 0.9.8, and in 1.0.x I can playback audio fine, but capturing seems
impossible.

In 0.9.8 I was able to select a capture source in alsamixer by selecting
it with the space bar. The source had "---" areas above it that meant it
had the capture ability. In 1.0.x that whole functionality is gone, and I
see no more way to capture audio.=20

I have all my sources up to 100%, and when I plug in an audio to source
into LINE IN on the Audigy, I hear nor can record anything. If I unmute
LINE IN in alsamixer, then I hear pass through audio, which I don't want.
I want to be able to record it, but not hear it through a pass through.=20

I know several people with this problem, and I myself have a few of these
cards dedicated to MythTV PVR boxes, and this problem makes it impossible
to upgrade ALSA... It's been 6 months since I tried this, and since nobod=
y
reported it, I thought I would.=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 netslayer - 06-14-2004 01:38 CEST=20
----------------------------------------------------------------------
Just to clarify, I figured out that recording audio off of LINE IN does
work. However, there is no way of recording audio with LINE muted, so as
not to hear the pass through. I want to be able to record, just like in
0.9.8 from the LINE IN, without having to actually listen to the pass
through audio when it is unmuted.

----------------------------------------------------------------------
 pzad - 06-14-2004 08:19 CEST=20
----------------------------------------------------------------------
ALSA 0.9.8 uses as ADC AC97, ALSA 1.0.x uses philips ADC (windows drivers
uses philips ADC too and works similiar to alsa 1.0.x).
If you want capture Line In:
-unmute and set Line In volume
-unmute and set volume for Analog Mix Capture Volume
-mute (set volume to 0) for Analog Mix Playback Volume, if don't waqnt to
listen line in while recording.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
06-13-04 23:30 netslayer      New Bug                                    =
 =20
06-13-04 23:30 netslayer      Distribution              =3D> Gentoo      =
   =20
06-13-04 23:30 netslayer      Kernel Version            =3D> 2.6.7rc love=
-sources
06-14-04 01:38 netslayer      Bugnote Added: 0001305                     =
 =20
06-14-04 08:19 pzad           Bugnote Added: 0001306                     =
 =20
06-28-04 09:15 pzad           Status                   new =3D> assigned =
   =20
06-28-04 09:15 pzad           Assigned To               =3D> pzad        =
   =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
