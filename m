From: Mark J Roberts <mjr@znex.org>
Subject: Re: MIDI input broken with ECS P4S5A/DX+ motherboard and generic MPU-401 driver. (Output works fine, though.)
Date: Wed, 29 Jan 2003 15:27:58 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030129212758.GA205@znex>
References: <20030128203917.GA485@znex> <Pine.LNX.4.44.0301291115150.1402-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301291115150.1402-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela:
> You've pointed to the reason: hardware does not generate input interrupts.
> Try to disable the IRQ (snd-mpu401=1,,,0x300,-1).

I had to set the index field there to "1" or "-1" in order to get
the MPU-401 recognized at bootup. (I have another sound card in
this box too, maybe that's why.)

As I said, I've already tried disabling the IRQ, and I get the same
behavior. I just did it again to make sure - this time I'm running
2.4.49 with merged-in 2.5.59 alsa code. (Matrox framebuffer...)

I boot up and see this:

Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17 19:01:13 2002 UTC).
PCI: Found IRQ 5 for device 00:0c.0
PCI: Sharing IRQ 5 with 00:08.0
ALSA device list:
  #0: MPU-401 UART at 0x300, polled
  #1: Sound Blaster Audigy at 0xc800, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0

But still no luck trying to read anything:

$ cat /dev/snd/midiC0D0 &

$ cat /proc/asound/UART/midi0
MPU-401 (UART)

Output 0
  Tx bytes     : 20
Input 0
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
