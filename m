From: "segfault" <segfault@email.it>
Subject: Re: [ANN] ALSA-native sfxload program
Date: Wed,  4 Feb 2004 09:42:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <HSJXI5$9C50A6DB9E51C95D441BC91DDEAE393E@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It seems that I'm the only guy who is trying to use an AWE64
without OSS=
 emulation.

I've tried "asfxload" with my AWE64 and it doesn't work. P=
robably
this is due to my ignorance since I've only a basic understandin=
g
of PCM playback and none about MIDI (with ALSA I mean).

The questio=
n is the following :
I load all the ALSA modules, both for the sequencer=
 and PCM.
In fact the ouput of "pmidi -l" gives:
-----------------
Por=
t Client name Port name
64:0 Rawmidi 0 - MPU-401 (UART) 0-0 MPU-401 (UAR=
T) 0-0
65:0 Emu8000 WaveTable Emu8000 Port 0
65:1 Emu8000 WaveTable Emu=
8000 Port 1
65:2 Emu8000 WaveTable Emu8000 Port 2
65:3 Emu8000 WaveTabl=
e Emu8000 Port 3
66:0 OPL3 FM synth OPL3 FM Port
-----------------
The=
n, when I try to load the soundfont with

./asfxload synthgm.sbk

I g=
et :
No Emux synth hwdep device is found.

I've verified that the only=
 hwdep activated on my PC is
an OPL3. Why the EMU8k synth hwdep device i=
s not active on
my comp. even after I've load all the relevant modules ?=


I didn't like to bother the devel ML with such kind of problems
but =
there is no documentation about "sound font loading without
OSS emulatio=
n".
-- 
Francesco Abbate




--
Email.it, the professional e-mail, gratis per te: http://www.email.it/f

Sponsor:
Stanco del tappetino mouse che hai??
Stampaci l'immagine che vuoi tu!

Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=3D2117&d=3D4-2


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
