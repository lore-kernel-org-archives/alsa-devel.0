From: Robert Schmit <robo1508@yahoo.com>
Subject: arecord read error,
	input/output error in embedded linux project
Date: Tue, 11 Nov 2008 09:21:41 -0800 (PST)
Message-ID: <317451.56707.qm@web36802.mail.mud.yahoo.com>
Reply-To: robo1508@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36802.mail.mud.yahoo.com (web36802.mail.mud.yahoo.com
	[209.191.85.53]) by alsa0.perex.cz (Postfix) with SMTP id C24962440C
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 18:21:42 +0100 (CET)
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

I am working on resurrecting an embedded linux project started by someone e=
lse.=A0 The project is using an AT91SAM9260 processor on an AT91SAM9260-EK =
development board and I am currently trying to get audio playback and captu=
re working through an external W6811 codec chip.=A0 The previous developer =
had the audio working both ways but unfortunately I can only get playback t=
o work but not capture.=A0 During a capture operation, I can verify on a sc=
ope that the proper clocks and frame syncs are being delivered to the W6811=
 chip and furthermore I can see data on the PCM output line of the chip (wh=
ich is of course connected to an input pin on the AT91SAM9260 processor).=
=A0 So I'm almost certain that the problem is not hardware.

A machine/codec driver for the W6811 chip was written by the previous devel=
oper and is known to be correct and properly included in the kernel.=A0 The=
 ALSA version is 1.0.14 and is compiled into a 2.6.22.1 kernel.=A0 I am cur=
rently using the default alsa.conf file and am not using ~/.asoundrc or /et=
c/asound.conf.=A0 I am testing the audio using aplay and arecord.=A0 Specif=
ically, arecord is failing, after 10 seconds, as follows:


/usr/bin $ arecord -traw -fS8 -r8000 ulaw2.raw
Recording raw data 'ulaw2.raw' : Signed 8 bit, Rate 8000 Hz, Mono
arecord: pcm_read:1346: read error: Input/output error


An strace of the arecord execution provides the following at the point of e=
rror.=A0 The ioctl() call is what hangs for 10 seconds, then the error mess=
age is printed and the program immediately exits.

open("test_sample.raw", O_WRONLY|O_CREAT|O_LARGEFILE, 0644) =3D 3
ioctl(4, 0x800c4151, 0xbef15c24)=A0=A0=A0=A0=A0=A0=A0 =3D -1 EIO (Input/out=
put error)
write(2, "arecord", 7arecord)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 7
write(2, ": ", 2: )=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 2
write(2, "pcm_read", 8pcm_read)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 8
write(2, ":", 1:)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 1
write(2, "1346", 41346)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 4
write(2, ": ", 2: )=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 2
write(2, "read error: ", 12read error: )=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 12
write(2, "Input/output error", 18Input/output error)=A0=A0=A0=A0=A0 =3D 18
write(2, "\n", 1
)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1
exit(1)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D ?
Process 844 detached


Is it possible that there is an extra step towards properly configuring a c=
apture channel/stream that would explain why playback works but capture doe=
s not??=A0 If anybody has any ideas, I would be very grateful as I have bee=
n stuck on this for days now.=A0 I'm not sure what information would be hel=
pful, but I will try to describe some details of my sound configuration her=
e.=A0 THANKS!!

/dev/snd $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: GRHEKW6811 [GRH_EK_W6811], device 0: W6811 W6811-PCM-0 []
=A0 Subdevices: 1/1
=A0 Subdevice #0: subdevice #0


/dev/snd $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: GRHEKW6811 [GRH_EK_W6811], device 0: W6811 W6811-PCM-0 []
=A0 Subdevices: 1/1
=A0 Subdevice #0: subdevice #0


/dev/snd $ ls -l
crw-rw-rw-=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 116,=A0=A0 0 Dec 31=
 17:27 controlC0
crw-rw-rw-=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 116,=A0 24 Dec 31 1=
7:29 pcmC0D0c
crw-rw-rw-=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 116,=A0 16 Dec 31 1=
7:27 pcmC0D0p
crw-rw-rw-=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 116,=A0 33 Dec 31 1=
7:51 timer


/proc/asound $ ls
GRHEKW6811=A0 cards=A0=A0=A0=A0=A0=A0 pcm=A0=A0=A0=A0=A0=A0=A0=A0 version
card0=A0=A0=A0=A0=A0=A0 devices=A0=A0=A0=A0 timers


/proc/asound $ cat devices
=A0 0: [ 0]=A0=A0 : control
=A016: [ 0- 0]: digital audio playback
=A024: [ 0- 0]: digital audio capture
=A033:=A0=A0=A0=A0=A0=A0=A0 : timer


/proc/asound $ cat pcm
00-00: W6811 W6811-PCM-0 :=A0 : playback 1 : capture 1


/proc/asound $ cat cards
=A00 [GRHEKW6811=A0=A0=A0=A0 ]: W6811 - GRH_EK_W6811
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GRH_EK_W681=
1 (W6811)


/proc/asound $ cat timers =

G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE


      =
