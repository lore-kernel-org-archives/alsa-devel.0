From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: RE: Oops in latest CVS
Date: Sun, 30 Nov 2003 11:28:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311301628.hAUGS4bV010629@ronispc.chem.mcgill.ca>
Reply-To: david.ronis@mcgill.ca
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

--text follows this line--

I've been complaining for several months about Oops's, lockups, etc.,
on my Sony Viao Z5050S laptop.  Sometimes I would simply freeze,
sometimes I got an oops (several of which have been posted), and last
week, I actually got some sound, albeit very corrupted.

Last night I did a CVS update, rebuilt and installed, and promptly
froze when I tried to use sound.  (I have things set up to have the
modules loaded and unloaded automatically).  I was in X (gnome), and a
second USB mouse installed, and a PCMCI modem card plugged in.

After unplugging all the add-in devices and rebooting, I decided to
give alsa another try, hoping at least to get the poor-quality sound I
had in the last version or perhaps an oops.  To my suprise it worked
PERFECTLY!  What was different, is that I tried alsa before plugging
any of the other devices in and before starting X.  Moreover, once
alsa's modules were installed, everything else could be installed and
the system seems stable.

Could the problem may have something to do with the fact that IRQ9
is shared on this machine?  Here's what /proc/interrupts says:

  9:      72787          XT-PIC  Ricoh Co Ltd RL5c475, eth0, usb-uhci, NM256AV

I've copied the output of lshw below.  You'll notice lots of things use IRQ9.

Any suggestions?

David

------------------------------------------------------------------------

    description: Computer
  *-core
       physical id: 0
     *-memory
          description: System memory
          physical id: 1
          size: 191MB
     *-cpu
          product: Celeron (Mendocino)
          vendor: Intel Corp.
          physical id: 2
          version: 6.6.10
          size: 331MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
        *-cache:0
             description: L1 cache
             physical id: 0
             size: 32KB
        *-cache:1
             description: L2 cache
             physical id: 1
             size: 128KB
     *-pci
          description: Host bridge
          product: 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled)
          vendor: Intel Corp.
          physical id: 0
          bus info: pci@00:00.0
          version: 03
          clock: 33MHz
        *-network
             description: Ethernet controller
             product: 82557/8/9 [Ethernet Pro 100]
             vendor: Intel Corp.
             physical id: 6
             bus info: pci@00:06.0
             version: 08
             clock: 33MHz
             capabilities: bus_master cap_list
             configuration: driver=eepro100
             resources: iomemory:fecff000-fecfffff ioport:fcc0-fcff iomemory:fed00000-fedfffff irq:9
        *-bridge:0 UNCLAIMED
             description: Bridge
             product: 82371AB/EB/MB PIIX4 ISA
             vendor: Intel Corp.
             physical id: 7
             bus info: pci@00:07.0
             version: 02
             clock: 33MHz
             capabilities: bridge bus_master
        *-ide
             description: IDE interface
             product: 82371AB/EB/MB PIIX4 IDE
             vendor: Intel Corp.
             physical id: 7.1
             bus info: pci@00:07.1
             version: 01
             clock: 33MHz
             capabilities: ide bus_master
             configuration: driver=PIIX
             resources: ioport:fcb0-fcbf
           *-ide:0
                description: Channel 0
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 33MHz
              *-disk
                   product: TOSHIBA MK4018GAS
                   physical id: 0
                   bus info: ide@0:master
                   logical name: /dev/hda
                   capacity: 37GB
           *-ide:1
                description: Channel 1
                physical id: 1
                bus info: ide@1
                logical name: ide1
                clock: 33MHz
              *-disk
                   product: MEMORYSTICK 4M 8K
                   physical id: 0
                   bus info: ide@1:master
                   logical name: /dev/hdc
                   capacity: 3952KB
        *-usb
             description: USB Controller (UHCI)
             product: 82371AB/EB/MB PIIX4 USB
             vendor: Intel Corp.
             physical id: 7.2
             bus info: pci@00:07.2
             version: 01
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=usb-uhci
             resources: ioport:fc60-fc7f irq:9
        *-bridge:1 UNCLAIMED
             description: Bridge
             product: 82371AB/EB/MB PIIX4 ACPI
             vendor: Intel Corp.
             physical id: 7.3
             bus info: pci@00:07.3
             version: 02
             clock: 33MHz
             capabilities: bridge
             resources: irq:9
        *-display UNCLAIMED
             description: VGA compatible controller (VGA)
             product: NM2200 [MagicGraph 256AV]
             vendor: Neomagic Corporation
             physical id: 8
             bus info: pci@00:08.0
             version: 12
             size: 16MB
             clock: 33MHz
             capabilities: vga bus_master cap_list
             resources: iomemory:fd000000-fdffffff iomemory:fe400000-fe7fffff iomemory:feb00000-febfffff irq:9
        *-multimedia
             description: Multimedia audio controller
             product: NM2200 [MagicMedia 256AV Audio]
             vendor: Neomagic Corporation
             physical id: 8.1
             bus info: pci@00:08.1
             version: 12
             clock: 33MHz
             capabilities: cap_list
             configuration: driver=NeoMagic
             resources: iomemory:fe000000-fe3fffff iomemory:fea00000-feafffff irq:9
        *-firewire UNCLAIMED
             description: FireWire (IEEE 1394) (Generic)
             product: CXD1947Q i.LINK Controller
             vendor: Sony Corporation
             physical id: 9
             bus info: pci@00:09.0
             version: 01
             clock: 33MHz
             capabilities: generic cap_list
             resources: iomemory:fecfec00-fecfedff
        *-pcmcia
             description: CardBus bridge
             product: RL5c475
             vendor: Ricoh Co Ltd
             physical id: a
             bus info: pci@00:0a.0
             version: 00
             clock: 33MHz
             capabilities: pcmcia bus_master cap_list
             configuration: driver=cardbus
             resources: iomemory:10000000-10000fff iomemory:b00401000-b00400fff irq:9
           *-pccard
                description: Serial or Modem
                physical id: 0
                slot: Socket 0
              *-serial
                   physical id: 0
                   logical name: /dev/ttyS1
                   configuration: driver=serial_cs
        *-communication UNCLAIMED
             description: Communication controller
             product: HCF 56k Data/Fax Modem
             vendor: Rockwell International
             physical id: b
             bus info: pci@00:0b.0
             version: 01
             clock: 33MHz
             capabilities: cap_list
             resources: iomemory:fece0000-feceffff irq:9


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
