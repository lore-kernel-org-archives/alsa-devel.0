From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000567]: S/PDIF control missing in mixer
Date: Wed, 20 Oct 2004 21:32:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1c08cbbbe412961c8a7945d24aebe805@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7FE9D321
	for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2004 21:32:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D567>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Issue History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
10-05-04 17:47 pmatil         New Issue                                  =
 =20
10-05-04 17:47 pmatil         Distribution              =3D> Debian GNU/L=
inux
10-05-04 17:47 pmatil         Kernel Version            =3D> 2.4.22      =
   =20
10-06-04 11:13 tiwai          Note Added: 0002018                        =
 =20
10-07-04 18:06 pmatil         File Added: asound.state                   =
 =20
10-07-04 18:20 pmatil         File Added: codec97#0                      =
 =20
10-07-04 18:23 pmatil         Note Added: 0002037                        =
 =20
10-11-04 14:07 tiwai          Note Added: 0002077                        =
 =20
10-11-04 14:08 tiwai          File Added: cs4298-spdif.diff              =
     =20
10-13-04 13:05 pmatil         Note Added: 0002122                        =
 =20
10-13-04 15:50 tiwai          Note Added: 0002123                        =
 =20
10-14-04 13:11 pmatil         File Added: prev_+reg                      =
 =20
10-14-04 13:11 pmatil         File Added: current_+reg                   =
 =20
10-14-04 13:13 pmatil         Note Added: 0002143                        =
 =20
10-14-04 13:14 pmatil         Note Edited: 0002143                       =
 =20
10-14-04 14:27 tiwai          Note Added: 0002145                        =
 =20
10-14-04 14:39 tiwai          Note Added: 0002146                        =
 =20
10-14-04 16:20 pmatil         Note Added: 0002153                        =
 =20
10-14-04 16:31 tiwai          Note Added: 0002155                        =
 =20
10-14-04 18:08 pmatil         Note Added: 0002157                        =
 =20
10-15-04 13:53 pmatil         Note Edited: 0002157                       =
 =20
10-18-04 17:44 tiwai          Note Added: 0002196                        =
 =20
10-20-04 21:32 pmatil         Note Added: 0002219                        =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
