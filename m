From: noreply@alsa-project.org
Subject: [ALSA - driver 0000194]: Prodigy 192 -  Eprom incorrect size?
Date: Fri, 18 Jun 2004 17:45:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <f7df32c8e692f0409fc5a4e852cbe4a3@bugtrack.alsa-project.org>
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0194
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                jvlake
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     194
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     confirmed
Distribution:               RedHat 9 _ 2.4.20.8
Kernel Version:             RedHat9 _ 2.4.20.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             04-07-2004 06:06 CEST
Last Modified:              06-18-2004 17:45 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Prodigy 192 -  Eprom incorrect size?
Description:=20
after compiling the driver and rebooting i get a message that the eprom i=
s
the wrong size for my card (on startup) needless to say, I also get no
sound. I am assuming this is because this card is not a 'prodigy 7.1' but
a 'prodigy 192' even though both cards are made by Audiotrak are 24/192kh=
z
& 7.1. to look at the cards they are almost identical. is there anyway I
can get the driver to work?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 jvlake - 04-07-2004 06:09 CEST=20
----------------------------------------------------------------------
oops, that would be ICE1724 not 1712, never mind same error either way.

----------------------------------------------------------------------
 perex - 04-07-2004 19:54 CEST=20
----------------------------------------------------------------------
Only Prodigy 7.1 card is supported at this time.

----------------------------------------------------------------------
 tiwai - 04-16-2004 16:00 CEST=20
----------------------------------------------------------------------
the board has apparently no EEPROM as well as prodigy 7.1.
you have to provide the EEPROM image.

at your own risk, you can try to change the subvendor value to the
corresponding one in prodigy.c, so that the driver believes that's
prodigy 7.1.

----------------------------------------------------------------------
 Apostolos Dimitromanolakis - 06-18-2004 17:45 CEST=20
----------------------------------------------------------------------
Hmm.. If this card uses the same chips as the Prodigy that would be easy =
to
modify the driver. Can you send a picture of the top of the board ?

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
04-07-04 06:06 jvlake         New Bug                                    =
 =20
04-07-04 06:06 jvlake         Distribution              =3D> RedHat 9 _ 2=
.4.20.8
04-07-04 06:06 jvlake         Kernel Version            =3D> RedHat9 _ 2.=
4.20.8
04-07-04 06:09 jvlake         Bugnote Added: 0000760                     =
 =20
04-07-04 06:10 jvlake         Bug Monitored: jvlake                      =
 =20
04-07-04 19:47 perex          Category                 PCI - ice1712 =3D>=
 PCI -
ice1724
04-07-04 19:53 perex          Severity                 major =3D> feature=
   =20
04-07-04 19:53 perex          Status                   new =3D> confirmed=
   =20
04-07-04 19:54 perex          Bugnote Added: 0000763                     =
 =20
04-16-04 16:00 tiwai          Bugnote Added: 0000838                     =
 =20
06-18-04 17:45 Apostolos DimitromanolakisBugnote Added: 0001319          =
      =20
    =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
