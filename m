From: Rune Nilsen <rune@9ls1.com>
Subject: Re: No sound on hda-intel/stac9221a1 Dell XPS M2010
Date: Fri, 8 Dec 2006 01:48:41 +0100
Message-ID: <200612080148.41492.rune@9ls1.com>
References: <200612080140.43454.rune@9ls1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612080140.43454.rune@9ls1.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 08 December 2006 01:40, Rune Nilsen wrote:
> There is no sound from the built-in speakers, 7.1 analog output or
> headphones with todays 1.0.14rc1. With ATrpm's 1.0.13-56.fc6 there was
> sound from headphones (only), but  "cat /proc/asound/card0/codec#0 crashed
> the kernel module. I tried models ref, 3stack and 5stack.

Dmesg stuff for the different models:

PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: 
model 'ref' is selected
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: 
autoconfig: line_outs=4 (0xa/0xf/0xb/0xc/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    
hp_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: 
mic=0x0, fmic=0x0, line=0xe, fline=0
x0, cd=0x0, aux=0x0
ACPI: PCI interrupt for device 0000:00:1b.0 disabled

PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: 
model '3stack' is selected
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: 
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: 
mic=0xb, fmic=0x15, line=0xc, fline=
0x0, cd=0x0, aux=0x0
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:556: 
hda_intel: azx_get_res
ponse timeout, switching to polling mode...
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: 
model '5stack' is selected
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: 
autoconfig: line_outs=3 (0xd/0xb/0xf/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: 
mic=0xe, fmic=0x15, line=0xc, fline=
0x0, cd=0x0, aux=0x0
ALSA /root/alsa/rc1/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:556: 
hda_intel: azx_get_res
ponse timeout, switching to polling mode...

-- 
Rune Nilsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
