From: Ben Parnell <xod@starmen.net>
Subject: M-Audio Sonica
Date: Sun, 29 Dec 2002 22:58:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212292258.42424.xod@starmen.net>
Reply-To: lezindox@starmen.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've hacked together a small firmware loader for the M-Audio Sonica.  Aft=
er=20
loading, it seems to work as a normal USB audio device.

http://xod.starmen.net/sonica.tar.gz

I looked at Clemens Ladisch's(non-functioning, for me at least) firmware=20
loader for some help, and used a usb sniffer.

The loader does cause a kernel panic for me, but that's *probably* becaus=
e my=20
system isn't set up properly...or it could be because my code is junk.  I=
=20
know very little about the USB protocol. :/
 After I reboot, I can use the device normally, though.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
