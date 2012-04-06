From: Sql Sql <firebirdsql@yahoo.com>
Subject: Alsa support for conexant
Date: Thu, 5 Apr 2012 17:30:11 -0700 (PDT)
Message-ID: <1333672211.33483.YahooMailNeo@web124703.mail.ne1.yahoo.com>
Reply-To: Sql Sql <firebirdsql@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm38-vm7.bullet.mail.ne1.yahoo.com
	(nm38-vm7.bullet.mail.ne1.yahoo.com [98.138.229.151])
	by alsa0.perex.cz (Postfix) with SMTP id 7B3CE103FDD
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 02:30:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have a Lenovo Thinkpad T400 with a mini dock which has SPDIF output. It i=
s running Debian Squeeze.


When I run alsamixer, I can see the soundcard detected is:
Conexant CX20561

When I run aplay -l:

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
=A0 Subdevices: 1/1
=A0 Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: Conexant Digital [Conexant Digital]
=A0 Subdevices: 1/1
=A0 Subdevice #0: subdevice #0

However, I can't get it to output through SPDIF. =

I tried:
aplay -Dplug:iec958 /usr/share/sounds/alsa/Front_Center.wav=A0 =3D no sound


I tried:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =

pcm.!default {
type plug
slave {
pcm "front:CARD=3DIntel"
}
}

(restarted alsautils), it still doesn't work.

I tried adding:
options snd-hda-intel model=3Dlenovo-x200
options snd-hda-intel model=3Dlenovo
options snd-hda-intel model=3Dlaptop
options snd-hda-intel model=3Dthinkpad
and then alsa force reload
None of these work.

Is there anyway I can get it to output through SPDIF? My other computer tha=
t has SPDIF outputs fine using the custom asound.conf so why isn't it worki=
ng for the lenovo? BTW, I confirmed the SPDIF is not defective=A0 by bootin=
g into Windows and testing it.
