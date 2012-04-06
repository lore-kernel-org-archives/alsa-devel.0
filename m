From: Sql Sql <firebirdsql@yahoo.com>
Subject: Re: Alsa support for conexant
Date: Fri, 6 Apr 2012 12:36:57 -0700 (PDT)
Message-ID: <1333741017.50435.YahooMailNeo@web124703.mail.ne1.yahoo.com>
References: <1333672211.33483.YahooMailNeo@web124703.mail.ne1.yahoo.com>
	<4F7EF90A.7020702@linux.intel.com>
Reply-To: Sql Sql <firebirdsql@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm26-vm1.bullet.mail.ne1.yahoo.com
	(nm26-vm1.bullet.mail.ne1.yahoo.com [98.138.91.61])
	by alsa0.perex.cz (Postfix) with SMTP id 6DAB6104540
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 21:36:59 +0200 (CEST)
In-Reply-To: <4F7EF90A.7020702@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the response, =


I did =

cat /proc/asound/card0/codec#0 =



and got the following output: (I have bolded the relevant information)


Codec: Conexant CX20561 (Hermosa)
Address: 0
Function Id: 0x1
Vendor Id: 0x14f15051
Subsystem Id: 0x17aa211c
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
=A0=A0=A0 rates [0x160]: 44100 48000 96000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D4, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
=A0 IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
=A0 IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
=A0 IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
=A0 IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
=A0 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D0
=A0 Amp-Out vals:=A0 [0x1f 0x1f]
=A0 Converter: stream=3D0, channel=3D0
=A0 PCM:
=A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x1]: PCM
=A0 Power: setting=3DD0, actual=3DD0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
=A0 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D0
=A0 Amp-Out vals:=A0 [0x4a 0x4a]
=A0 Converter: stream=3D0, channel=3D0
=A0 PCM:
=A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x1]: PCM
=A0 Power: setting=3DD0, actual=3DD0
Node 0x12 [Audio Output] wcaps 0x211: Stereo Digital
=A0 Converter: stream=3D0, channel=3D0
=A0 Digital:
=A0 Digital category: 0x0
=A0 PCM:
=A0=A0=A0 rates [0x160]: 44100 48000 96000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x5]: PCM AC3
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
=A0 Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
=A0 Amp-Out vals:=A0 [0x00]
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
=A0 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D0
=A0 Amp-In vals:=A0 [0x44 0x44] [0x44 0x44]
=A0 Converter: stream=3D0, channel=3D0
=A0 SDI-Select: 0
=A0 PCM:
=A0=A0=A0 rates [0x160]: 44100 48000 96000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x1]: PCM
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 2
=A0=A0=A0=A0 0x1d* 0x17
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
=A0 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D0
=A0 Amp-In vals:=A0 [0x44 0x44]
=A0 Converter: stream=3D0, channel=3D0
=A0 SDI-Select: 0
=A0 PCM:
=A0=A0=A0 rates [0x160]: 44100 48000 96000
=A0=A0=A0 bits [0xe]: 16 20 24
=A0=A0=A0 formats [0x1]: PCM
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 1
=A0=A0=A0=A0 0x18
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
=A0 Pincap 0x0000001c: OUT HP Detect
=A0 Pin Default 0x022140f0: [Jack] HP Out at Ext Front
=A0=A0=A0 Conn =3D 1/8, Color =3D Green
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0 Pin-ctls: 0xc0: OUT HP
=A0 Unsolicited: tag=3D37, enabled=3D1
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 2
=A0=A0=A0=A0 0x10* 0x11
Node 0x17 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
=A0 Amp-In vals:=A0 [0x03 0x03]
=A0 Pincap 0x00001224: IN Detect
=A0=A0=A0 Vref caps: 50 80
=A0 Pin Default 0x61a190f0: [N/A] Mic at Sep Rear
=A0=A0=A0 Conn =3D 1/8, Color =3D Pink
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0 Pin-ctls: 0x24: IN VREF_80
=A0 Unsolicited: tag=3D38, enabled=3D1
=A0 Power: setting=3DD0, actual=3DD0
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
=A0 Amp-In vals:=A0 [0x03 0x03]
=A0 Pincap 0x00001224: IN Detect
=A0=A0=A0 Vref caps: 50 80
=A0 Pin Default 0x02a190f0: [Jack] Mic at Ext Front
=A0=A0=A0 Conn =3D 1/8, Color =3D Pink
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0 Pin-ctls: 0x24: IN VREF_80
=A0 Unsolicited: tag=3D39, enabled=3D1
=A0 Power: setting=3DD0, actual=3DD0
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
=A0 Pincap 0x00000014: OUT Detect
=A0 Pin Default 0x40f000f0: [N/A] Other at Ext N/A
=A0=A0=A0 Conn =3D Unknown, Color =3D Unknown
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0 Pin-ctls: 0x40: OUT
=A0 Unsolicited: tag=3D37, enabled=3D1
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 2
=A0=A0=A0=A0 0x10* 0x11
Node 0x1a [Pin Complex] wcaps 0x400501: Stereo
=A0 Pincap 0x00010010: OUT EAPD
=A0 EAPD 0x2: EAPD
=A0 Pin Default 0x901701f0: [Fixed] Speaker at Int N/A
=A0=A0=A0 Conn =3D Analog, Color =3D Unknown
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0=A0=A0 Misc =3D NO_PRESENCE
=A0 Pin-ctls: 0x00:
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 2
=A0=A0=A0=A0 0x10* 0x11
Node 0x1b [Pin Complex] wcaps 0x400500: Mono
=A0 Pincap 0x00010010: OUT EAPD
=A0 EAPD 0x2: EAPD
=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=A0=A0=A0 Conn =3D Unknown, Color =3D Unknown
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0=A0=A0 Misc =3D NO_PRESENCE
=A0 Pin-ctls: 0x40: OUT
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 2
=A0=A0=A0=A0 0x10* 0x11
Node 0x1c [Pin Complex] wcaps 0x400701: Stereo Digital
=A0 Pincap 0x00000010: OUT
=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=A0=A0=A0 Conn =3D Unknown, Color =3D Unknown
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0=A0=A0 Misc =3D NO_PRESENCE
=A0 Pin-ctls: 0x00:
=A0 Power: setting=3DD0, actual=3DD0
=A0 Connection: 1
=A0=A0=A0=A0 0x12
Node 0x1d [Pin Complex] wcaps 0x40040b: Stereo Amp-In
=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x2f, mute=3D0
=A0 Amp-In vals:=A0 [0x03 0x03]
=A0 Pincap 0x00000020: IN
=A0 Pin Default 0x90a601f0: [Fixed] Mic at Int N/A
=A0=A0=A0 Conn =3D Digital, Color =3D Unknown
=A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
=A0=A0=A0 Misc =3D NO_PRESENCE
=A0 Pin-ctls: 0x20: IN
=A0 Power: setting=3DD0, actual=3DD0
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono



It looks like it is already enabled and set to OUT. =



How do I enable the pin with a one line verb? Do I write option connexant 5=
051 to modprobe.d/alsabase.conf?





________________________________
 From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org =

Sent: Friday, April 6, 2012 10:09 AM
Subject: Re: [alsa-devel] Alsa support for conexant
 =


> Is there anyway I can get it to output through SPDIF? My other computer t=
hat has SPDIF outputs fine using the custom asound.conf so why isn't it wor=
king for the lenovo? BTW, I confirmed the SPDIF is not defective=A0 by boot=
ing into Windows and testing it.

Can you check if the SPDIF pin is actually enabled (look at =

/proc/asound/cardxx/codec#xx) as OUT. I had a similar problem a long =

time ago on a Lenovo W500, enabling the pin with a one-line verb for the =

connexant 5051 solved the problem.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
