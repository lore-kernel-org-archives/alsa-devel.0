From: peter plessas <plessas@mur.at>
Subject: [Fwd: Re: hdsploader on ppc]
Date: Mon, 21 Mar 2005 23:16:35 +0100
Message-ID: <423F47C3.40704@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Chis, dear list!

Thanks for the information, i did an upgrade to a 2.6.11-5 kernel, and
got alsa-drivers and -tools from the alsa-snapshots page, version
1.0.9rc1. I of course enabled the hotplug-fw-loader in the kernel.

after one reboot, the card worked, even when going to computer suspend
mode(!) and at re-inserting the card.
But after i had one computer crash (i was unplugging the powersupply off
the mutiface, the hotplug_fw loader is unable to load the card at
boot-time, giving:
--------------------------------------------------------------------
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0001:10:1a.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0001:10:1a.0, mfunc 0x00000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 58
Socket status: 30000069
PCI: Enabling device 0001:11:00.0 (0080 -> 0082)
ieee1394: Initialized config rom entry `ip1394'
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:775:
Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:656:
Hammerfall-DSP: loading firmware
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:694:
Hammerfall-DSP: finished firmware loading
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:775:
Hammerfall-DSP: wait for FIFO status <= 127 failed after 5000 iterations
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:4852:
Hammerfall-DSP: Error setting default values
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:4948:
Hammerfall-DSP: error creating alsa devices
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:5059:
Hammerfall-DSP: couldn't get firmware from userspace. try using hdsploader
ALSA
/usr/local/src/alsa-driver-1.0.9rc1/alsa-kernel/pci/rme9652/hdsp.c:5066:
Hammerfall-DSP: card initialization pending : waiting for firmware
RME Hammerfall DSP: probe of 0001:11:00.0 failed with error -16
-------------------------------------------------------------------

lspci sees the card, manually running hdsploader gives:

user@gonzo:/usr/local/src$ hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : PowerMac Screamer Rev 0

(not seeing the card)

i am fairly stuck here, any help would be appreciated!

thanks!

Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
