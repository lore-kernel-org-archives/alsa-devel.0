From: Jesse Chappell <jesse@essej.net>
Subject: Re: hdsp driver status
Date: Wed, 09 Jul 2003 00:24:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <616961442ecc34a5866fa42a79757331@essej.net>
References: <34975.81.51.161.173.1057484037.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <34975.81.51.161.173.1057484037.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote on Sun, 06-Jul-2003:

 > >
 > >> I ran hdsploader the first time and it failed. I ran it a second time
 > >> and the red light on the Multiface went out, [...]
 > >
 > > For the record, this is incorrect. I run it once and the red light goes
 > > out. I have a feeling the error message is incorrect, because the "card"
 > > seems to work now. hdsploader seems to not be robust in the face of
 > > running twice against the same card. Again, thank you.
 > >
 > 
 > Thanks for your report. I'm glad the card gets of some use for rev 11
 > multiface users, but note that this is more of a workaround than the real
 > solution. I really suspect something is broken when using the old firmware
 > with rev 11 cards.
 > Can you please send me the output of dmesg just after you run hdsploader
 > and it returns an error, and report precisely the status of the card
 > before and after hdsploader is run (red light on/off, sound working or
 > not) ?
 
OK, I too tried your patch (I have cardbus/multiface rev 0xb)
and the red light *did* go out but gave the following error
message:

 hdsploader - firmware loader for RME Hammerfall DSP cards
 Looking for HDSP + Multiface or Digiface cards :
 Card 0 : Intel 82801CA-ICH3 at 0x1c00, irq 9
 Card 1 : RME Hammerfall DSP at 0x31000000, irq 9
 Upload firmware for card hw:1
 Hwdep ioctl error on card hw:1 : Input/output error.

Here is what dmesg reports:

ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed after 30 iterations
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3804: initializing firmware upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed after 5000 iterations
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:543: timeout at end of firmware loading

However, due to that timeout, initialization didn't complete and
there is nothing in /proc/asound/card1/ except id.

I then ran it again:
$ hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : Intel 82801CA-ICH3 at 0x1c00, irq 9
Card 1 : RME Hammerfall DSP at 0x31000000, irq 9
Upload firmware for card hw:1
Firmware uploaded for card hw:1

dmesg reports (the extra debugging line was added by me to the
kernel driver):
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3804: initializing firmware upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3969: got past proc init stuff
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3037: sending all inputs and playback streams to line outs.

At this point everything looks good in /proc/asound/card1/hdsp:

$ cat /proc/asound/card1/hdsp
RME Hammerfall DSP + Multiface (Card #2)
Buffers: capture c0e00000 playback c0c00000
IRQ: 9 Registers bus: 0x31000000 VM: 0xf0a32000
Control register: 0x10080de
Status register: 0x12000000
Status2 register: 0xffff0703
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 5

Sample Clock Source: Internal 48 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: None
AutoSync Frequency: 0
System Clock Mode: Master
System Clock Frequency: 48000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

==============================================================

I can use amixer to set up things as per usual, and jack starts
normally.  However, I get no sound whatsoever.  

Loading the firmware via Windows, rebooting, and setting up the card
identically with amixer *does* yield sound.

So it looks like some critical parts for proper communication
to the multiface need the proper firmware to work with the rev
0xb interface. 

Back to trying to load the proper rev11 firmware, it looks like
some part of the communication protocol must have changed, or
the multiface_firmware_rev11.dat is corrupt.  I wonder if there
is any way to verify it.  

jlc


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
