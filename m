From: Anders Torger <torger@ludd.luth.se>
Subject: HDSP signal lock problem
Date: Fri, 26 Sep 2003 21:20:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309262120.10382.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Thomas Charbonnel <thomas@undata.org>
List-Id: alsa-devel@alsa-project.org


With alsa-cvs (updated today), I have some problems with a RME HDSP card 
(PCI card). I want it to sync on incoming signal, so I have set the 
sample clock source to "AutoSync". I have a 44.1kHz input signal on 
ADAT2, and the driver says "Sync" on ADAT2, AutoSync Frequency 44100. 
Still, the card runs in Master at 48kHz. Should that be possible even?

When playing around with the settings using hdspconf (changing sample 
clock source and pref sync ref settings) I sometimes succeed in getting 
the System Clock to slave at the given input frequency, but only 
sometimes. I have not really found a pattern how to switch the settings 
in order to get it to lock.

Am I doing something wrong, or is the driver doing something wrong? It 
is not impossible that there is some clock loop in the system (although 
I doubt it), I am debugging a system a quarter of a globe away through 
ssh, and I don't know for sure how all the cables are connected.

/Anders Torger

------

volver1:~# cat /proc/asound/card0/hdsp
RME Hammerfall HDSP 9652 (Card #1)
Buffers: capture dec00000 playback de800000
IRQ: 20 Registers bus: 0xec000000 VM: 0xe0034000
Control register: 0x10160ce
Control2 register: 0x0
Status register: 0x2020004
Status2 register: 0xffff8141
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: AutoSync
Preferred Sync Reference: ADAT Sync
AutoSync Reference: ADAT2
AutoSync Frequency: 44100
System Clock Mode: Master
System Clock Frequency: 48000

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: No Lock
ADAT2: Sync
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
