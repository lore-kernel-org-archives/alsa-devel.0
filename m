From: Anders Torger <torger@ludd.luth.se>
Subject: RME Hammerfall HDSP 9652: no configurations available
Date: Fri, 18 Jul 2003 21:18:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307182118.27990.torger@ludd.luth.se>
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
List-Id: alsa-devel@alsa-project.org


I'm trying out the HDSP driver from CVS (checked out today), on a RME  
HDSP 9652 PCI card, but I don't manage to get it to run, with my basic 
test

# aplay -D hw -f S32_LE -c 26 -r 48000 /dev/zero

Playing raw data '/dev/zero' : Signed 32 bit Little Endian, Rate 48000 
Hz, Channels 26
aplay: set_params:787: Broken configuration for this PCM: no 
configurations available

The firmware is loaded using hdsploader. Running aplay on another sound 
card on the machine works.

Any ideas why this happens? It seems like snd_pcm_hw_params_any returns 
no parameters at all. That is strange, since when I put in some debug 
logs in the driver it seems like the driver returns a proper 
parameters.

/Anders Torger

---------------

# cat /proc/asound/card0/hdsp

RME Hammerfall HDSP 9652 (Card #1)
Buffers: capture dea00000 playback de600000
IRQ: 20 Registers bus: 0xec000000 VM: 0xe0033000
Control register: 0x10080de
Control2 register: 0x800
Status register: 0x3c40008
Status2 register: 0xffff8061
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

Sample Clock Source: Internal 48 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: ADAT1
AutoSync Frequency: 48000
System Clock Mode: Master
System Clock Frequency: 48000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: Sync
ADAT2: No Lock
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
