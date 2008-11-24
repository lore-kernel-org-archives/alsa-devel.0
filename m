From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Medion MD96420. ALC883/ALC268 conflicts
Date: Mon, 24 Nov 2008 16:58:04 +0100
Message-ID: <200811241658.04771.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 33B1E103827
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 16:58:31 +0100 (CET)
Received: from [192.168.0.230] (213.36.0.26) by mail.libertysurf.net
	(7.3.118.8) id 492560CA0011AC38 for alsa-devel@alsa-project.org;
	Mon, 24 Nov 2008 17:56:45 +0100
Content-Disposition: inline
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

I've been helping GN out on the user list, to get his sound working. The sound 
is now working, but only by using the options line below.
options snd-hda-intel probe_mask=1. I see on the changelog for 1.0.18 > 
1.0.18a that Takashi added a quirk for a Medion MD96630 as below.

<quote>
- ALSA: hda - Add a quirk for MEDION MD96630 
Use model=lenovo-ms7195-dig for MEDION MD96630 laptop (17c0:4085) 
with ALC888 codec. 
Reference: Novell bnc#412548 
https://bugzilla.novell.com/show_bug.cgi?id=412528 
Signed-off-by: Takashi Iwai <tiwai@suse.de> 
Signed-off-by: Jaroslav Kysela <perex@perex.cz> 

<end quote>

Some details of his machine, OS, and other output below.

Medion MD96420. Model MIM 2300 Notebook PC

OS: Fedora 9, with alsadriver 1.0.16 upgraded to 1.0.18a

Desktop:  KDE 4.1

/sbin/lspci  (soundcard part)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
 Subsystem: Mitac Unknown device 8227
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B- DisINTx-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 22
 Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=16K]
 Capabilities: <access denied>
 Kernel driver in use: HDA Intel
 Kernel modules: snd-hda-intel

[graeme@flintstone ~]$ cat /proc/asound/cards
  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xfc200000 irq 22

[graeme@flintstone ~]$ grep ^Codec /proc/asound/card?/codec*
/proc/asound/card0/codec#0:Codec: Realtek ALC883
/proc/asound/card0/codec#1:Codec: LSI ID 1040
/proc/asound/card0/codec#2:Codec: Realtek ALC268

A bit of info from Graeme (aka GN), after asking him to try probe_mask=1.

<quote>
I tried the different probe-mask=?. Probe-mask=1 works OK but not the
others. model=lenovo-ms7195-dig doesn't work. Kmix shows varying
channels depending on the 'model' or 'probe-mask' used. probe-mask=1
gives the most channels. alsamixer now loads up OK but still no sound.
Shows as ALC883 with 'probe-mask=1' Starting Amarok elicits the xine
error dialogue window with  "xine was unable to initialize any audio
drivers"

UPDATE:

With 'probe-mask=1 and using Rhythmbox I can get sound out of the
speakers and the front headphone jack. Volume not very high out of the
speakers but is good from the headphones. Too much system activity or
keyboard activity (I'm writing this listening to Tchaikovsky and I can
hear interruptions from the keyboard at times) seems to interfere with
the audio stream. Also there is a lot of noise from the CD drive coming
through the earphones. Don't know how that is happening. Pulseaudio Vol
Cntl can be used as can the panel Vol. Cntl. and also alsamixer.
<end quote>

The last things I asked him to try, were to disable Pulseaudio, by removing 
the package alsa-plugins-pulseaudio, and to try the latest snapshot for the 
alsa driver.

Disabling pulseaudio has resulted in good sound levels from the speakers, but 
as he is away for a few days, he hasn't yet tried the latest snapshot of the 
alsa driver.

A few extra details. Without a model option all snd modules were loaded, but 
no card was detected. Using the option model=medion, resulted in the card 
being detected, but problems with alsamixer as below. model=mitac gives same 
results as below.

<quote from Graeme's reply on user list>
[graeme@flintstone ~]$ amixer
ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Headphone 
Playback Switch',0,2,0) appears twice or more
amixer: Mixer default load error: Invalid argument
[graeme@flintstone ~]$ alsamixer
ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Headphone 
Playback Switch',0,2,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument
<end quote>

Then I searched through the changelog, found the bug report about the codec 
conflicts, and suggested probe_mask=1, which has got the sound working.

I think I've gone about as far as I can now, which is why I'm posting this to 
the devel list.

Nigel.
