From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: VT82C686 and MIDI fun
Date: Fri, 11 Feb 2005 15:53:35 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502111547410.15708-100000@studcom.urz.uni-halle.de>
References: <1107965895.8941.21.camel@secures>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1107965895.8941.21.camel@secures>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris White <chriswhite@gentoo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris White wrote:
> I'm on a ppc system (2.6.9 kernel) using alsa driver 1.0.8
> (latest), via82xx module (Via being the vendor, my model being in
> the subject line), and all a nice midi keyboard hooked up to the
> MIDI/Gameport with an adapater I got.  Now, I've tried the
> following without much success:
>
> 1) I did the `modprobe snd-via82xx mpu_port=0x330` command to set the
> mpu port, which is what it's documented as, /dev/midi does nothing
> 2) Ok, maybe my setup is jacked, so I tried hooking it up to my x86
> system, works like a charm

Can the MIDI port be configured in the BIOS setup?  What is set for
the interrupt (is it the same as the interrupt for the AC'97
controller)?

It would be nice to know if MIDI output worked.

You could try using it without interrupts by editing the file
alsa-kernel/pci/via82xx.c and, in the call to snd_mpu401_uart_new
(about line 1733), replacing "chip->irq" with "-1".

> 3) I looked over the documentation.. which tells me to work with
> snd-mpu401.. but I thought that was depricated by snd-mpu401-uart?

There is no snd-mpu401-uart driver.  The module of that name is used
as a library for other drivers because many sound cards have MPU-401
compatible MIDI ports.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
