From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: The volume buttons on Lenovo Thinkpad X61S (was:
 Re: [Alsa-user] Console beep on Lenovo Thinkpad X61S)
Date: Fri, 26 Mar 2010 17:18:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003261612020.3925__10370.9943629385$1269620822$gmane$org@eeebox2.perex-int.cz>
References: <m31vgd2v3h.fsf@fox.lamasti.net> <4B84FE55.3090101@gmail.com>
	<alpine.LNX.2.00.1002241129480.28127@eeebox2.perex-int.cz>
	<4B962374.4060204@gmail.com> <m3aau0u7fn.fsf@fox.lamasti.net>
	<alpine.LNX.2.00.1003220856510.3925@eeebox2.perex-int.cz>
	<m3ljdku4oy.fsf@fox.lamasti.net>
	<alpine.LNX.2.00.1003220944570.3925@eeebox2.perex-int.cz>
	<m38w9kmycc.fsf@fox.lamasti.net> <m3r5ncipz4.fsf@fox.lamasti.net>
	<alpine.LNX.2.00.1003221219180.3925@eeebox2.perex-int.cz>
	<m3aau0a7y1.fsf@fox.lamasti.net>
	<alpine.LNX.2.00.1003221301270.3925@eeebox2.perex-int.cz>
	<m339zs34ib.fsf@fox.lamasti.net> <4BA88C15.1040806@gmail.com>
	<alpine.LNX.2.00.1003231056470.3925@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.1003261047210.3925@eeebox2.perex-int.cz>
	<m34ok3b3yj.fsf@fox.lamasti.net>
	<m3vdcjgp5w.fsf_-_@fox.lamasti.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1075513777-1269620302=:3925"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CC76110384A
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 17:18:22 +0100 (CET)
In-Reply-To: <m3vdcjgp5w.fsf_-_@fox.lamasti.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Lars_Bj=C3=B8rndal?= <lars.bjorndal@broadpark.no>
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1075513777-1269620302=:3925
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 26 Mar 2010, Lars Bj=C3=B8rndal wrote:

> The volume buttons up, down and mute, doesn't work from within the
> console. How could that be fixed? Please note that I use Fedora 12,
> and I don't use X.

It's a bit different thing. The ACPI events are translated as key-press=20
events to the /dev/input/event* interface. So you need an application=20
(daemon) watching for these key-press events and modifying the volume=20
using the ALSA mixer interface. The GUI programs do this.

Here is a short program in python reading input events and translating=20
them to amixer calls:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/usr/bin/python
import struct
import os

# use 'evtest' program to determine right /dev/input device and code
acpievents =3D "/dev/input/event1"
fmt =3D 'iihhi'
fd =3D open(acpievents, "rb")
event =3D fd.read(16)
while event:
   (time1, time2, type, code, value) =3D struct.unpack(fmt, event)
   if type =3D=3D 1:
     if code =3D=3D 115:=09# keypress VOLUMEUP
       os.system("amixer -q -c 0 set PCM 10%+")
     elif code =3D=3D 114:=09# keypress VOLUMEDOWN
       os.system("amixer -q -c 0 set PCM 10%-")
   event =3D fd.read(16)
fd.close()
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1075513777-1269620302=:3925
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1075513777-1269620302=:3925--
