From: Pavel Roskin <proski@gnu.org>
Subject: EeePC 1005PE microphone is "stereo only",
	silent in mono
Date: Sun, 31 Jul 2011 23:39:45 -0400
Message-ID: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C96D103807
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 05:39:11 +0200 (CEST)
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

Hello!

I have discovered that the microphone on my ASUS EeePC 1005PE only  
works in stereo.  If recording in mono, the result is inaudible.  When  
I open the stereo recording in audacity, I see that the two channels  
are in counterphase.  If I convert stereo to mono in audacity, I get a  
straight line, and it's inaudible when played.

The driver itself requires stereo recording:

$ arecord --rate 44100 -D hw:0 -f S16_LE --channels 1 >test.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
arecord: set_params:1065: Channels count non available

However, pulse audio doesn't enforce it.  So it's possible to record a  
mono file through pulse audio, and it's inaudible.  Some programs  
simply assume a mono microphone and thus get no sound.

I can work it around by setting the level on one of the channels to  
100% and to 0% on the other in alsamixer.  However, the GNOME volume  
manager removes that imbalance when adjusting the input level.  I  
would prefer to have a robust solution.  Perhaps one of the channels  
should be inverted.  Or maybe the difference between the channels  
should be reported as mono input.  I don't really care about stereo  
input.

I'm using Linux 3.0 on Fedora 15.  I checked out and tested the master  
branch of sound-2.6.git, and it has the same problem.

It looks like the problem is known.  I found this comment in alc882_quirks.c:

/* DMIC fix
  * This laptop has a stereo digital microphone. The mics are only 1cm apart
  * which makes the stereo useless. However, either the mic or the ALC889
  * makes the signal become a difference/sum signal instead of standard
  * stereo, which is annoying. So instead we flip this bit which makes the
  * codec replicate the sum signal to both channels, turning it into a
  * normal mono mic.
  */

My laptop has ALC269, bit it also used the DMIC quirk:
SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005HA", ALC269_DMIC),

That's the detailed lspci output:

$ lspci -vvnn -s 00:1b.0
00:1b.0 Audio device [0403]: Intel Corporation N10/ICH 7 Family High  
Definition Audio Controller [8086:27d8] (rev 02)
         Subsystem: ASUSTeK Computer Inc. Device [1043:83ce]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast  
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 45
         Region 0: Memory at f7cf8000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: <access denied>
         Kernel driver in use: HDA Intel

I'm not using any module parameters.  No external devices are  
connected to the laptop.

-- 
Regards,
Pavel Roskin
