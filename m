From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with several Creative Labs soundcards,
	possibly more?
Date: Sat, 22 Oct 2005 13:12:26 -0400
Message-ID: <1130001146.7717.7.camel@mindpipe>
References: <a5a496a90510190840v7f7d2345s133b06eaad0a4719@mail.gmail.com>
	 <a5a496a90510191156i24c69e17yc35184577090f9f5@mail.gmail.com>
	 <4356C414.9060008@superbug.co.uk>
	 <a5a496a90510191414n651099e8x9d9952638ce84729@mail.gmail.com>
	 <4356C875.5030607@superbug.co.uk>
	 <a5a496a90510191845w55200b77y927dc92470b15784@mail.gmail.com>
	 <a5a496a90510211519y15711764ode0a2fe4053695d8@mail.gmail.com>
	 <1129939134.4724.26.camel@mindpipe>
	 <a5a496a90510211958s1252b5fds1e91c699c3bfe7dc@mail.gmail.com>
	 <1129957778.6385.3.camel@mindpipe>
	 <a5a496a90510220024n490d6564t23125c52986b322c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <a5a496a90510220024n490d6564t23125c52986b322c@mail.gmail.com>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Nazo <nazosan@gmail.com>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Also, please don't top post, and please don't remove alsa-user and
alsa-devel from the cc: list.

I still think it's a kernel problem because you have bleeding edge
hardware (Athlon64) with relatively unknown specs (Nforce chipset).

On Sat, 2005-10-22 at 02:24 -0500, Nazo wrote:
> Firstly, the reason I really wonder if it's a kernel bug is the fact
> that it's shown up in so many different kernels.  That said, if you
> honestly think I should report it, can you tell me how to do so?  I've
> never even thought about reporting a kernel bug before, so have no
> idea where even to go.
> 
> Anyway, bad news.  I was trying to compile another kernel and messed
> up one thing so that when I booted it I was forced to do a hard reset.
>  Linux prevents lockups and other such problems like a dream, but, the
> moment a problem occurs it handles it so terribly it's not even funny.
>  Simply put, it no longer boots the normal kernel either due to severe
> filesystem damage and the repairs are beyond the scope of what I know
> to do, so I'd have to simply reinstall again (I swear my luck with
> linux is horrible.)  This takes a while and I'd rather not do it
> tonight.  If you really need me to I will, but, I wondered if maybe
> the results from GeeXBoX would do?  It doesn't do the hardware loop
> thing, but, this is the first place I get no sound (and, if it's a
> seperate issue then this just goes right back to the fact that that's
> the issue I REALLY want to fix.)  So, here are the outputs from
> GeeXBoX:
> 
> Ok, first of all, the interrupts.  It probably doesn't do any good,
> but, I thought I'd paste them.  The only difference I saw between the
> before and after was the second number (which I presume is something
> more along the lines of how much information it has been used for?)
>            CPU0
>   0:     214447    IO-APIC-edge  timer
>   1:       1021    IO-APIC-edge  i8042
>   8:       8552    IO-APIC-edge  rtc
>   9:          1   IO-APIC-level  acpi
>  14:      30997    IO-APIC-edge  ide0
>  15:        696    IO-APIC-edge  ide1
>  16:      20396   IO-APIC-level  eth0
>  17:          3   IO-APIC-level  ohci1394
>  18:          3   IO-APIC-level  ehci_hcd:usb1
>  19:          0   IO-APIC-level  ohci_hcd:usb2
>  20:         50   IO-APIC-level  ohci_hcd:usb3
>  21:        326   IO-APIC-level  EMU10K1
> NMI:          0
> LOC:     214348
> ERR:          0
> MIS:          0
> 
> And dmesg (apparently part got cut off, sorry, but, it got cut off
> before getting to the sound relate stuff):
> e driver v2.3
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> usb 3-1: new low speed USB device using ohci_hcd and address 2
> input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
> usb-0000:00:02.1-1
> usb 3-2: new full speed USB device using ohci_hcd and address 3
> usbcore: registered new driver xpad
> drivers/usb/input/xpad.c: X-Box pad driver:v0.0.5
> pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver
> usbcore: registered new driver pegasus
> drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2 (2004/08/27)
> usbcore: registered new driver rtl8150
> gameport: EMU10K1 is pci0000:02:09.1/gameport0, io 0xc400, speed 1217kHz
> Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
> 12:20:13 2005 UTC).
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [APC2] -> GSI 17 (level,
> low) -> IRQ 21
> Installing spdif_bug patch: Audigy 2 ZS [SB0350]
> ALSA device list:
>   #0: Audigy 2 ZS [SB0350] (rev.4, serial:0x20021102) at 0xc000, irq 21
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.3)
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6 (1400 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
> powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
> cpu_init done, current fid 0xc, vid 0x6
> Using IPI Shortcut mode
> ACPI wakeup devices:
> HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI
> ACPI: (supports S0 S1 S3 S4 S5)
> RAMDISK: Compressed image found at block 0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 300k freed
> ReiserFS: hda1: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda1
> VFS: Can't find ext3 filesystem on dev hda1.
> VFS: Can't find an ext2 filesystem on dev hda1.
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c01510815d7]
> ReiserFS: hda2: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda2
> VFS: Can't find ext3 filesystem on dev hda2.
> VFS: Can't find an ext2 filesystem on dev hda2.
> attempt to access beyond end of device
> hda3: rw=0, want=18, limit=2
> ReiserFS: hda3: warning: sh-2006: read_super_block: bread failed (dev
> hda3, block 8, size 1024)
> attempt to access beyond end of device
> hda3: rw=0, want=130, limit=2
> ReiserFS: hda3: warning: sh-2006: read_super_block: bread failed (dev
> hda3, block 64, size 1024)
> ReiserFS: hda3: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda3
> attempt to access beyond end of device
> hda3: rw=0, want=4, limit=2
> EXT3-fs: unable to read superblock
> attempt to access beyond end of device
> hda3: rw=0, want=4, limit=2
> EXT2-fs: unable to read superblock
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev hda3.
> attempt to access beyond end of device
> hda3: rw=0, want=66, limit=2
> isofs_fill_super: bread failed, dev=hda3, iso_blknum=16, block=32
> attempt to access beyond end of device
> hda3: rw=0, want=3, limit=2
> HFS+-fs: unable to find HFS+ superblock
> attempt to access beyond end of device
> hda3: rw=0, want=3, limit=2
> VFS: Can't find a HFS filesystem on dev hda3.
> NTFS-fs error (device hda3): read_ntfs_boot_sector(): Primary boot
> sector is invalid.
> NTFS-fs error (device hda3): read_ntfs_boot_sector(): Mount option
> errors=recover not used. Aborting without trying to recover.
> NTFS-fs error (device hda3): ntfs_fill_super(): Not an NTFS volume.
> You didn't specify the type of your ufs filesystem
> 
> mount -t ufs -o
> ufstype=sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|netxstep-cd|openstep
> ...
> 
> >>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is ufstype=old
> attempt to access beyond end of device
> hda3: rw=0, want=18, limit=2
> attempt to access beyond end of device
> hda3: rw=0, want=68, limit=2
> attempt to access beyond end of device
> hda3: rw=0, want=1252, limit=2
> attempt to access beyond end of device
> hda3: rw=0, want=1028, limit=2
> UDF-fs: No partition found (1)
> ReiserFS: hda5: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda5
> VFS: Can't find ext3 filesystem on dev hda5.
> VFS: Can't find an ext2 filesystem on dev hda5.
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev hda5.
> Unable to identify CD-ROM format.
> HFS+-fs: unable to find HFS+ superblock
> VFS: Can't find a HFS filesystem on dev hda5.
> NTFS volume version 3.1.
> ReiserFS: hda6: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda6
> ext3: No journal on filesystem on hda6
> ReiserFS: hda7: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda7
> VFS: Can't find ext3 filesystem on dev hda7.
> VFS: Can't find an ext2 filesystem on dev hda7.
> FAT: invalid media value (0x7c)
> VFS: Can't find a valid FAT filesystem on dev hda7.
> Unable to identify CD-ROM format.
> HFS+-fs: unable to find HFS+ superblock
> VFS: Can't find a HFS filesystem on dev hda7.
> NTFS-fs warning (device hda7): is_boot_sector_ntfs(): Invalid boot
> sector checksum.
> NTFS-fs error (device hda7): read_ntfs_boot_sector(): Primary boot
> sector is invalid.
> NTFS-fs error (device hda7): read_ntfs_boot_sector(): Mount option
> errors=recover not used. Aborting without trying to recover.
> NTFS-fs error (device hda7): ntfs_fill_super(): Not an NTFS volume.
> You didn't specify the type of your ufs filesystem
> 
> mount -t ufs -o
> ufstype=sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|netxstep-cd|openstep
> ...
> 
> >>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is ufstype=old
> ufs_read_super: bad magic number
> UDF-fs: No VRS found
> ReiserFS: hdc: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hdc
> VFS: Can't find ext3 filesystem on dev hdc.
> VFS: Can't find an ext2 filesystem on dev hdc.
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev hdc.
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISO 9660 Extensions: RRIP_1991A
> usbcore: registered new driver rtusb
> InterWave soundcard not found or device busy
> Sound Blaster 16 soundcard not found or device busy
> In case, if you have AWE card, try snd-sbawe module
> Sound Blaster 16 soundcard not found or device busy
> In case, if you have AWE card, try snd-sbawe module
> lirc_dev: IR Remote Control driver registered, at major 61
> 
> lirc_atiusb: USB remote driver for LIRC v0.4
> lirc_atiusb: Paul Miller <pmiller9@users.sourceforge.net>
> usbcore: registered new driver lirc_atiusb
>  CIFS VFS: No response buffer
>  CIFS VFS: cifs_mount failed w/return code = -112
> ReiserFS: hda2: warning: sh-2021: reiserfs_fill_super: can not find
> reiserfs on hda2
> VFS: Can't find ext3 filesystem on dev hda2.
> VFS: Can't find an ext2 filesystem on dev hda2.
> atkbd.c: Unknown key pressed (translated set 2, code 0xbc on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e03c <keycode>' to make it known.
> atkbd.c: Unknown key released (translated set 2, code 0xbc on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e03c <keycode>' to make it known.
> atkbd.c: Unknown key pressed (translated set 2, code 0xbb on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
> atkbd.c: Unknown key released (translated set 2, code 0xbb on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
> 
> 
> 
> On 10/22/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > Please don't top post.
> >
> > On Fri, 2005-10-21 at 21:58 -0500, Nazo wrote:
> > > If I boot with pci=noacpi, the normal mandriva kernel hangs just after
> > > it says hit I for interactive setup.  The vanilla one starts up, but,
> > > when I try to play an audio file, I have the same problem.  Bear in
> > > mind when saying the problem lies with the kernel that I've seen this
> > > issue on several different kernel versions.
> > >
> > > As for my motherboard, it's a Gigabyte 9NDA3J.  The chipset is the
> > > nForce 3 Ultra (which I believe is basically just a nForce 3 250 with
> > > the only change being the socket type, but, I'm not 100% sure.)  I
> > > think I saw some things using the 250 driver for the motherboard
> > > rather than saying ultra, but, like I said, I think this is probably
> > > ok.
> > >
> >
> > OK, it still sounds like a kernel problem.  The IRQ handling code in the
> > emu10k1 driver is quite simple and almost certainly free of bugs.  OTOH,
> > I see TONS of reports like this on LKML, and it's always an ACPI issue.
> >
> > Unless someone on alsa-devel has a better idea, I think you need to
> > report this on the kernel bugzilla.
> >
> > Can you check /proc/interrupts and see if the number of interrupts for
> > your soundcard increases when you play sounds?  Also please post the
> > output of "dmesg" after rebooting the machine and trying to play a
> > sound.
> >
> > Lee
> >
> > > On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > > On Fri, 2005-10-21 at 17:19 -0500, Nazo wrote:
> > > > > When I got it to sucessfully boot, and tried to play something, it
> > > > > played one frame over and over in a loop (kind of like what happens
> > > > > when the system locks up in the middle of a game or something.)  When
> > > > > the application was closed and another different sound file was
> > > > > attempted, it gave an IO error and no sound came out at all.  Based on
> > > > > the way it kind of acted like the hardware locked up or something, my
> > > > > first guess would be maybe something along the lines of an IRQ
> > > > > conflict or somesuch?  That's just a guess though.  Anyway, he thought
> > > > > it might be useful if I provided some extra info, so I've added them
> > > > > to the bottom of the message:
> > > > >
> > > >
> > > > OK, this is a classic sign that interrupts are not being acknowledged
> > > > properly.  It's not a problem with the ALSA drivers but with the kernel.
> > > > Probably an ACPI issue.
> > > >
> > > > What is the make and model of your motherboard?
> > > >
> > > > Does it work if you boot with "pci=noacpi"?
> > > >
> > > > Lee
> > > >
> > > >
> > > >
> > >
> >
> >
> 



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
