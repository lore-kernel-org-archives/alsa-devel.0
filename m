From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Audigy 2 support - update
Date: Sat, 24 May 2003 21:14:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECFD2BC.1000307@superbug.demon.co.uk>
References: <20030523051240.GA10831@www.angiotech.com>	<1053675028.18540.70.camel@rivendell.home.local>	<yw1xznlevz8l.fsf@zaphod.guide>	<1053747556.6906.4.camel@rivendell.home.local>	<20030524165935.GB17884@www.angiotech.com> <86el2ouqq4.fsf@tea.thpoon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <86el2ouqq4.fsf@tea.thpoon.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: agenkin-dated-1055009935.e7788b@thpoon.com
Cc: Stephen Hassard <steve@hassard.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Arcady Genkin wrote:
> Stephen Hassard <steve@hassard.net> writes:
> 
> 
>>On that note, does anyone know if you can purchase a digital IO
>>module for the Audigy2 separate from the Platinum package? I
>>wouldn't mind finding one that sits over a PCI slot in my chassis. I
>>don't like cables that hang out the front of my case.
> 
> 
> Have a look at Audigy2 Platinum EX.  Essentially, it's the same as the
> regular platinum (i.e. it comes with an internal PCI card), but
> instead of the LiveDrive there is an external module full of I/O
> connectors.
> 
> I have the Audigy2 Platinum Ex, which I purchased for the same reason
> as you.  However, I still could not get Alsa's emu10k1 driver to work
> with it (neither the recent CVS version, nor the 0.9.3 series). :(  I
> get the following error.  SB's emu10k1 driver works, though.
> 
> ,----[ modprobe output ]
> | ice alsa-driver # modprobe snd-emu10k1
> | /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: \
> |   init_module: No such device
> | Hint: insmod errors can be caused by incorrect module parameters, \
> |   including invalid IO or IRQ parameters.
> |       You may find more information in syslog or the output from dmesg
> | /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
> |   /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o failed
> | /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
> |   snd-emu10k1 failed
> `----
> 
> ,----[ dmesg output ]
> | PCI: Found IRQ 11 for device 02:05.0
> | PCI: Sharing IRQ 11 with 00:1f.3
> | PCI: Sharing IRQ 11 with 02:01.0
> | ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2089: AC'97 0:0 does not respond - RESET
> | EMU10K1/Audigy soundcard not found or device busy
> `----
To fix this try: -
lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:10.0 Multimedia video controller: Internext Compression Inc iTVC15 
MPEG-2 Encoder (rev 01)
00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:12.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 06)
00:14.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
01:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256 
SDR] (rev 10)

Notice that 00:12.0 is my SB Live.
Then do: -
lspci -n
00:00.0 Class 0600: 8086:7190 (rev 03)
00:01.0 Class 0604: 8086:7191 (rev 03)
00:07.0 Class 0601: 8086:7110 (rev 02)
00:07.1 Class 0101: 8086:7111 (rev 01)
00:07.2 Class 0c03: 8086:7112 (rev 01)
00:07.3 Class 0680: 8086:7113 (rev 02)
00:10.0 Class 0400: 4444:0803 (rev 01)
00:12.0 Class 0401: 1102:0002 (rev 06)
00:12.1 Class 0980: 1102:7002 (rev 06)
00:14.0 Class 0200: 8086:1229 (rev 08)
01:00.0 Class 0300: 10de:0100 (rev 10)

Notice that 00:12.0 is Class 0401: 1102:0002 (The numbers will be 
different for the Audigy 2)

Now, edit /alsacvs/alsa-kernel/pci/emu10k1/emu10k1.c line 81 onwards: -
static struct pci_device_id snd_emu10k1_ids[] __devinitdata = {
         { 0x1102, 0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* 
EMU10K1 */
         { 0x1102, 0x0006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },    /* Dell 
OEM version (EMU10K1) */
         { 0x1102, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },    /* 
Audigy */
         { 0, }
};


As you can see, 0x1102, 0x0002 is my SB Live.
Add a extra line for your Audigy 2 platinum ex.

and recompile, and see if that helps.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
