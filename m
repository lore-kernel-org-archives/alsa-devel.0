From: Free Ekanayaka <free@centrotemporeale.it>
Subject: Re: PCMCIA and snd-hdsp
Date: Thu, 29 Aug 2002 02:35:18 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208290213140.723-100000@localhost>
References: <20020828162406.GB557@finnendahl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020828162406.GB557@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 28/08/02  Orm Finnendahl wrote...

> Am Mittwoch, den 28. August 2002 um 08:30:21 Uhr (-0400) schrieb Paul Davis:
>
> Yes and no. This is what happened:
>
> I compiled a new debian kernel package with a 2.4.19 kernel. My
> working kernel was 2.4.18-686 and in addition I had the original
> 2.4.18-bf2.4 (both available with debian). After I had compiled and
> installed the kernel, it didn't work until I had deinstalled and
> reinstalled the old 2.4.18-686 kernel and the appropriate pcmcia-cs
> and pcmcia-modules. After that, I recompiled the whole ALSA.
>
> Now the snd-hammerfall-mem install o.k. but snd-hdsp segfaults (and I
> have to reboot in order to get rid of the module).
>

Hi, i'm trying to convince the PCMCIA HDSP to work, and I have
more or less the same problem (I believe that's is pcmcia-cs side
but i dont have other cards to test, apart from the built in
wirless interface that is correctly recognized).

I have a custom 2.4.18 (ACPI and low latency patched) and latest
CVS alsa driver on Debian Woody and pcmcia 3.1.33-6 (i82365). The
laptop is Toshiba Tecra 9100.

Loading snd-hdsp provokes seg fault with basically the same log
as Orm Finnendahl's (see below).

Another strange thing is that, after inserting the card, lspci
doesnt work anymore:

~ # lspci
pcilib: Cannot open /proc/bus/pci/04/00.0
lspci: Unable to read 64 bytes of configuration space.
~ #

I dont think that the snd-hdsp modules itself crashes, after
trying to load it and getting the mentioned log, lsmod
gives:

snd-hdsp              214596   1  (initializing)
snd-hammerfall-mem      1824   0  [snd-hdsp]

and hdsp keeps initializing forever (moreover it cant be
removedn and it hangs the system when I try to shutdown)

Another thing detail is that cardctl ident gives more information
than cardinfo:

~ # cardctl ident
Socket 0:
  product info: "TOSHIBA", "Wireless LAN Card", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)
Socket 1:
  product info: "Martin Kirst", "Hammerfall DSP", "CardBus Audio
Card 1.00"
  PCI id: 0x10ee, 0x3fc5
Socket 2:
  no product info available

BUT if I use cardinfo, it detects that the Socket 1 is in use but
doesnt print any information about it.

I guess the problem is somewhat related in the IRQ routing or
assignment ..

> Aug 28 18:18:11 grisey kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000040
> Aug 28 18:18:11 grisey kernel:  printing eip:
> Aug 28 18:18:11 grisey kernel: d0a2741b
> Aug 28 18:18:11 grisey kernel: *pde = 00000000
> Aug 28 18:18:11 grisey kernel: Oops: 0002
> Aug 28 18:18:11 grisey kernel: CPU:    0
> Aug 28 18:18:11 grisey kernel: EIP:    0010:[ide-mod:ide_devfs_handle_Reb53c0a2+1796923/253010458]    Not tainted
> Aug 28 18:18:11 grisey kernel: EFLAGS: 00010246
> Aug 28 18:18:11 grisey kernel: eax: 00000000   ebx: cba581a8   ecx: cba58140   edx: 00000000
> Aug 28 18:18:11 grisey kernel: esi: fffffff0   edi: d0ae7480   ebp: cba581a8   esp: cba5debc
> Aug 28 18:18:11 grisey kernel: ds: 0018   es: 0018   ss: 0018
> Aug 28 18:18:11 grisey kernel: Process modprobe (pid: 547, stackpage=cba5d000)
> Aug 28 18:18:11 grisey kernel: Stack: cba58000 d0a2748c cba581a8 d0a05aa3 cba58000 cba58000 d0a27578 cba58000
> Aug 28 18:18:11 grisey kernel:        d0ae6f90 cf7aa41c d0ae7480 00000000 c017a12e cf7aa41c d0ae6f90 cf7aa41c
> Aug 28 18:18:11 grisey kernel:        d0ae7480 00000000 000c34ac c017a194 d0ae7480 cf7aa41c d0a24000 00000004
> Aug 28 18:18:11 grisey kernel: Call Trace: [ide-mod:ide_devfs_handle_Reb53c0a2+1797036/253010345] [ide-mod:ide_devfs_handle_Reb53c0a2+1659331/253148050] [ide-mod:ide_devfs_handle_Reb53c0a2+1797272/253010109] [ide-mod:ide_devfs_handle_Reb53c0a2+2582192/252225189] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925]
> Aug 28 18:18:11 grisey kernel:    [pci_announce_device+54/84] [ide-mod:ide_devfs_handle_Reb53c0a2+2582192/252225189] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [pci_register_driver+72/96] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [ide-mod:ide_devfs_handle_Reb53c0a2+1797340/253010041]
> Aug 28 18:18:11 grisey kernel:    [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [sys_init_module+1285/1448] [ide-mod:ide_devfs_handle_Reb53c0a2+1783680/253023701] [system_call+51/56]




-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
