From: reeteshchandran@yahoo.com
Subject: Alsa driver issue with udev events
Date: Wed, 8 Apr 2009 14:48:53 -0700 (PDT)
Message-ID: <403230.83878.qm@web30002.mail.mud.yahoo.com>
Reply-To: reeteshchandran@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web30002.mail.mud.yahoo.com (web30002.mail.mud.yahoo.com
	[209.191.69.19]) by alsa0.perex.cz (Postfix) with SMTP id DE2DC103852
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 23:48:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,
=A0
I am using Alsa driver 1.0.12RC1 on ARM platform. I have a=A0volume control=
 application=A0using=A0SALSA (small alsa) running.=A0The app has the contro=
l device open (/dev/snd/controlC0).=A0I have another=A0application listenin=
g to udev events, something like udev monitor. The device in description is=
 USB headset. =

=A0
The problem is when I unplug the device. When I unplug, I am not getting al=
l udev remove events. I get only 3 remove events from /class/sound/mixer, /=
class/sound/dsp and /class/sound/audio. But I dont get the remove events fo=
r the USB device layer. As a result I am not able to detect that the device=
 has been removed. =

=A0
This problem exists only if the app has the control device open. I closed t=
he control device and I get all unplug events correctly. =

=A0
Has anyone else seen this problem ? Any pointers as to where to start looki=
ng ?
=A0
Thanks and regards,
Reetesh


      =
