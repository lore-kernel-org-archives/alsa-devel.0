From: =?ISO-8859-15?Q?Andr=E9_He=DFling?= <ahessling@gmx.de>
Subject: CMI9780 and ALSA volume control
Date: Sun, 11 Apr 2004 19:23:10 +0000
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040411192310.55fd44bf@rambo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I've recently bought a new PC from a german manufacteur called Aldi/Medion.=
 It has the CMI9780 chip on board which is fairly new and compatible to AC9=
7.
In my kernel 2.6.5-mm1 with ALSA 1.0.4rc2 I activated support for the Intel=
 controller (intel8x0) and it seemed to work just fine.
I get sound output and alsamixer has all important controls activated.
But the controls "Master" and "PCM" have no function. I can only mute/unmut=
e PCM. Master has absolutely no function.
Fortunately the output level is rather high and in XMMS I can use the softw=
are mixer of the ALSA plugin.

But it would be nice if I could control these things with alsamixer or such=
 a tool.

Any hints?

Thank you!

Here is an output of aadebug:
ALSA Audio Debug v0.0.7 - So Apr 11 19:07:27 GMT 2004
http://alsa.opensrc.org/?aadebug

Kernel ---------------------------------------------ALSA Audio Debug v0.0.7=
 - So Apr 11 19:07:27 GMT 2004
http://alsa.opensrc.org/?aadebug

Kernel ----------------------------------------------------
Linux merkur 2.6.5-mm1 #2 SMP Sun Apr 11 11:50:44 GMT 2004 i686 Intel(R) Pe=
ntium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Loaded Modules --------------------------------------------

Modules Conf ----------------------------------------------
# $Header: /home/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-modul=
es.conf-rc,v 1.1 2003/08/05 21:07:55 johnm Exp $
alias char-major-116 snd
alias char-major-14 soundcore
## You need to customise this section for your specific sound card(s)
## alias snd-card-0 snd-interwave
## alias snd-card-1 snd-ens1371
## alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss
alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
options snd cards_limit=3D1

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19=
:30 2004 UTC).
Compiled on Apr  9 2004 for kernel 2.6.5-mm1 (SMP).
0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfa801000, irq 17
  1:       : sequencer
  0: [0- 0]: ctl
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0p  pcmC0D2c  pcmC0D4p  timer
pcmC0D0c   pcmC0D1c  pcmC0D3c  seq

CPU -------------------------------------------------------
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz		: 2992.756
cpu MHz		: 2992.756

RAM -------------------------------------------------------
MemTotal:       515672 kB
SwapTotal:      755012 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub =
Interface (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5=
R) AC'97 Audio Controller (rev 02)
0000:02:02.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
-------
Linux rambo 2.6.5-mm1 #2 SMP Sun Apr 11 11:50:44 GMT 2004 i686 Intel(R) Pen=
tium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Loaded Modules --------------------------------------------

Modules Conf ----------------------------------------------
# $Header: /home/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-modul=
es.conf-rc,v 1.1 2003/08/05 21:07:55 johnm Exp $
alias char-major-116 snd
alias char-major-14 soundcore
## You need to customise this section for your specific sound card(s)
## alias snd-card-0 snd-interwave
## alias snd-card-1 snd-ens1371
## alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss
alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
options snd cards_limit=3D1

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19=
:30 2004 UTC).
Compiled on Apr  9 2004 for kernel 2.6.5-mm1 (SMP).
0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfa801000, irq 17
  1:       : sequencer
  0: [0- 0]: ctl
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0p  pcmC0D2c  pcmC0D4p  timer
pcmC0D0c   pcmC0D1c  pcmC0D3c  seq

CPU -------------------------------------------------------
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz		: 2992.756
cpu MHz		: 2992.756

RAM -------------------------------------------------------
MemTotal:       515672 kB
SwapTotal:      755012 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub =
Interface (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5=
R) AC'97 Audio Controller (rev 02)
0000:02:02.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
--=20
Regards,
  Andr=E9=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
