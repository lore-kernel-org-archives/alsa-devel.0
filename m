From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000523]: Unable to get SPDIF output on Biostar IDEQ minipc
Date: Thu, 21 Oct 2004 15:25:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <866b89990a35624a3feac8e774650f81@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 442D3340
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2004 15:25:02 +0200 (MEST)
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


A NOTE has been added to this issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D523>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Issue History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
09-22-04 22:48 pharm          New Issue                                  =
 =20
09-22-04 22:48 pharm          Distribution              =3D> Debian unsta=
ble=20
09-22-04 22:48 pharm          Kernel Version            =3D> 2.4.27-1-k7 =
with alsa
1.0.6a (1.0.7rc1 doesn't work either)
09-23-04 18:25 tiwai          Note Added: 0001829                        =
 =20
09-23-04 18:26 tiwai          File Added: cm9761-add.dif                 =
  =20
09-23-04 22:09 pharm          Note Added: 0001851                        =
 =20
09-24-04 09:28 pharm          Issue Monitored: pharm                     =
 =20
09-24-04 12:03 tiwai          Note Added: 0001869                        =
 =20
09-24-04 12:28 pharm          Note Added: 0001877                        =
 =20
09-24-04 13:34 pharm          Note Added: 0001882                        =
 =20
09-24-04 14:33 tiwai          Note Added: 0001886                        =
 =20
09-24-04 15:29 tiwai          Note Added: 0001890                        =
 =20
09-24-04 15:29 tiwai          File Added: cm9761-add-take2.dif           =
      =20
=20
09-24-04 15:57 pharm          Note Added: 0001892                        =
 =20
09-24-04 16:05 tiwai          Note Added: 0001893                        =
 =20
09-24-04 16:05 tiwai          File Added: cm9761-add-take3.dif           =
      =20
=20
09-24-04 16:31 pharm          Note Added: 0001894                        =
 =20
09-24-04 16:43 pharm          Note Added: 0001895                        =
 =20
09-24-04 17:08 tiwai          Note Added: 0001896                        =
 =20
09-24-04 17:08 tiwai          File Added: cm9761-add-take4.dif           =
      =20
=20
09-24-04 17:23 pharm          File Added: 1.0.7rc1-ac97#0-0              =
     =20
09-24-04 17:24 pharm          File Added: 1.0.7rc1-ac97#0-0+regs         =
      =20
  =20
09-24-04 17:32 pharm          File Added: take4-ac97#0-0                 =
  =20
09-24-04 17:32 pharm          File Added: take4-ac97#0-0+regs            =
      =20

09-24-04 17:33 pharm          Note Added: 0001897                        =
 =20
09-24-04 17:39 tiwai          Note Added: 0001898                        =
 =20
09-24-04 17:41 pharm          Note Added: 0001899                        =
 =20
09-24-04 17:45 tiwai          Note Added: 0001900                        =
 =20
09-24-04 17:58 pharm          Note Added: 0001901                        =
 =20
09-24-04 18:06 tiwai          Note Added: 0001902                        =
 =20
09-27-04 09:56 pharm          Note Added: 0001933                        =
 =20
09-27-04 15:16 tiwai          Note Added: 0001939                        =
 =20
09-27-04 15:17 tiwai          File Added: cm9761-add-take5.dif           =
      =20
=20
10-12-04 14:59 tiwai          Note Added: 0002102                        =
 =20
10-12-04 15:10 pharm          Note Added: 0002105                        =
 =20
10-13-04 23:46 pharm          Note Added: 0002135                        =
 =20
10-14-04 12:46 tiwai          Note Added: 0002142                        =
 =20
10-21-04 15:14 pharm          Note Added: 0002220                        =
 =20
10-21-04 15:25 pharm          Note Added: 0002221                        =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
