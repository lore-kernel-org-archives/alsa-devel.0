From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: YMFPCI No midi record.
Date: Tue, 01 Apr 2003 11:49:13 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304011143550.8372-100000@studcom.urz.uni-halle.de>
References: <200303302024.15366.donald@sequel.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200303302024.15366.donald@sequel.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Donald M Burns <donald@sequel.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Donald M Burns wrote:
> I've just downloaded and installed ALSA 0.9.2 complete with OSS emulation.
> I'm using an Addonics Sound Vision SV550 which is based on the Yamaha
> YMF724F chip, and running Red Hat 7.3.
>
> Whilest all is OK with the PCM and OPL3 bits the MIDI record function does not
> work. [...]
> I had a similar problem with old OSS driver (ymfpci.c) and tracked it down to
> the fact that only ISA interrupts for the midi were supported by the driver.
> This means that the driver is OK  for midi on motherboard mounted chips but
> cannot work with PCI cards as there is no way to route an ISA interrupt across
> the PCI bus. I came up with a simple patch which fixed it in the end.
>
> I was wondering if we had the same problem with ALSA driver.

snd_card_ymfpci_probe() contains the following code:

	...
	// this bit is for legacy mpu irqs
	// legacy_ctrl |= 0x10; /* MPU401 irq enable */
	legacy_ctrl2 |= 1 << 15; /* IMOD */
	...
	if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_YMFPCI,
				       mpu_port[dev], 0,
				       pci->irq, 0, &chip->rawmidi)) < 0) {
		printk(KERN_WARNING "ymfpci: cannot initialize MPU401 at 0x%lx, skipping...\n", mpu_port[dev]);
		mpu_port[dev] = 0;
		// only for legacy mpu irqs
		// legacy_ctrl &= ~0x10; /* disable MPU401 irq */
		// pci_write_config_word(pci, PCIR_DSXG_LEGACY, legacy_ctrl);
	}
	...

This code apparently assumes that the MIDI port uses the PCI interrupt
line. I don't have a ymfpci card, so I don't know if this assumption is
correct, or what the "IMOD" bit does.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
