From: Ivan Middleton <ivan_middleton@yahoo.com>
Subject: problems with external MIDI port
Date: Mon, 28 Oct 2002 18:17:46 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021029021746.10403.qmail@web13401.mail.yahoo.com>
Reply-To: ivan_middleton@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a follow-up to my postings of a few weeks ago.  I recently
submitted the following as bug #629284:

After just a few minutes of using a program (Linux Pipe Organ,
http://orgue.com/linux_organ/index-e.shtml) which reads from the
external MIDI port, the ALSA mpu401 driver barfs:

Oct 26 20:22:43 localhost kernel: ALSA
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:168: cmd: 0xff failed at
0x330 (status = 0xff, data = 0xff)
Oct 26 20:22:43 localhost kernel: ALSA
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:168: cmd: 0x3f failed at
0x330 (status = 0xff, data = 0xff)

The aforementioned program communicates heavily with another program
(Timidity) over the ALSA sequencer interface, and I believe this may be
related somehow to the problem, since in the absence of these programs
I
can read from the external MIDI port as long as I want. When the error
occurs, the sequencer interface (and everything else) seems to continue
working fine; only the external port can't be read from anymore. I'm
using 0.9.0rc5, and here's my soundcard:

0 [card0 ]: SB AWE - Sound Blaster 16
Sound Blaster 16 at 0x220, irq 5, dma 1&5

Any help with how to proceed debugging this further would be greatly
appreciated.  Thanks,

Ivan


__________________________________________________
Do you Yahoo!?
Y! Web Hosting - Let the expert host your web site
http://webhosting.yahoo.com/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
