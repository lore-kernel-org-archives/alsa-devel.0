From: Mark J Roberts <mjr@znex.org>
Subject: MIDI input broken with ECS P4S5A/DX+ motherboard and generic MPU-401 driver. (Output works fine, though.)
Date: Tue, 28 Jan 2003 14:39:17 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030128203917.GA485@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

[ An evil list-moderator bot ate the first version of this. ]

I'm running kernel 2.5.49, built with the generic MPU-401 MIDI
driver, and booted with the "snd-mpu401=1,-1,,0x300,10" option,
which corresponds to IO port 0x300 and IRQ 10.

I've configured my BIOS to enable the on-board MIDI interface, and
set it to port 0x300 and IRQ 10.

"pmidi -p 64:0 whatever.mid" works fine and the box at the other end
of the MIDI cable makes noises as it should.

But I've found no way to read any input. (I believe "cat
/proc/snd/midiC0D0 should be able to read a raw MIDI stream,
correct?)

# cat /proc/asound/UART/midi0
MPU-401 (UART)

Output 0
  Tx bytes     : 5986
Input 0
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0

dmesg snippet:

Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
PCI: Found IRQ 5 for device 00:0c.0
PCI: Sharing IRQ 5 with 00:08.0
ALSA device list:
  #0: MPU-401 UART at 0x300, IRQ 10
  #1: Sound Blaster Audigy at 0xc800, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0

I've tried setting IRQ to "-1", to enable polling mode, with no
effect. I've upgraded mpu401/ etc to alsa cvs, also with no effect.
I've tried the intel i8x0 driver (had to configure the port to 0x300
before it'd recognize the MIDI interface), also with no improvement.

I see zero interrupts in /proc/interrupts:

 10:          0          XT-PIC  MPU401 UART

So, any ideas?


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
