From: Justin Cormack <justin@street-vision.com>
Subject: Re: RME HDSP9652
Date: 28 Nov 2002 14:39:41 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038494386.20379.31.camel@lotte>
References: <200211281337.gASDbvf00556@tench.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211281337.gASDbvf00556@tench.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2002-11-28 at 13:42, Paul Davis wrote:
> >I have just got a couple of the new RME Hammerfall HDSP9652 cards, and
> >find that they are not supported by the snd-hdsp driver yet. The card is
> >basically the same hardware as the other hdsp cards but with the io
> >integrated on the card.
> >
> >I would guess that it will need a different firmware and another type in
> >HDSP_Type, plus the channel info.  Does anyone know how to get the
> >formware from RME (who to contact)?
> 
> all i need is the PCI ID from you. i've already spoken to RME about
> the card, and the claim is that it will with the existing h-dsp
> driver. the only thing that won't work are the RMS meters. the
> existing driver, however, doesn't recognize the PCI ID and so it
> doesn't work.
> 

Its the same PCI ID, but insmod segfaults...

[root@marlin root]# lspci -v -s 04:02.0 -n
04:02.0 Class 0401: 10ee:3fc5 (rev 64)
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at e8300000 (32-bit, non-prefetchable) [size=64K]

[root@marlin root]# lspci -v -s 04:02.0
04:02.0 Multimedia audio controller: Xilinx, Inc. RME Hammerfall DSP
(rev 64)
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at e8300000 (32-bit, non-prefetchable) [size=64K]




ksymoops output:

ksymoops 2.4.5 on i686 2.4.20-rc4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc4/ (default)
     -m /boot/System.map-2.4.20-rc4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address
00000040
f8a0643d
*pde = 00000000
Oops: 0002
CPU:    2
EIP:    0010:[<f8a0643d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f48781a8   ecx: c19ad080   edx: 00000000
esi: ffffffed   edi: c19ce400   ebp: f48781a8   esp: f4a33e94
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 782, stackpage=f4a33000)
Stack: ffffffed c19ce400 f4878000 f8975c7a f48781a8 00000002 c19ce400
f4878000
       f8a065fe f4878000 f48781a8 00000000 000010e8 400676b0 f8a38620
f8a38b20
       c19ce400 00000000 c01efc05 c19ce400 f8a38620 c19ce400 f8a38b20
00000000
Call Trace:    [<f8975c7a>] [<f8a065fe>] [<f8a38620>] [<f8a38b20>]
[<c01efc05>]
  [<f8a38620>] [<f8a38b20>] [<c01efcac>] [<f8a38b20>] [<f8a06653>]
[<f8a38b20>]
  [<c011e004>] [<f8a02060>] [<f8a07604>] [<f8a02060>] [<c010774f>]
Code: 89 50 40 8b 83 c4 00 00 00 85 c0 78 0c 89 04 24 89 5c 24 04


>>EIP; f8a0643d <[snd-hdsp]snd_hdsp_free+1d/90>   <=====

>>ebx; f48781a8 <_end+34516cf0/384aaba8>
>>ecx; c19ad080 <_end+164bbc8/384aaba8>
>>esi; ffffffed <END_OF_CODE+75c74a2/????>
>>edi; c19ce400 <_end+166cf48/384aaba8>
>>ebp; f48781a8 <_end+34516cf0/384aaba8>
>>esp; f4a33e94 <_end+346d29dc/384aaba8>

Trace; f8975c7a <[snd]snd_card_free+12a/1d0>
Trace; f8a065fe <[snd-hdsp]snd_hdsp_probe+12e/140>
Trace; f8a38620 <[snd-hdsp]snd_hdsp_ids+0/38>
Trace; f8a38b20 <[snd-hdsp]driver+0/27>
Trace; c01efc05 <pci_announce_device+35/80>
Trace; f8a38620 <[snd-hdsp]snd_hdsp_ids+0/38>
Trace; f8a38b20 <[snd-hdsp]driver+0/27>
Trace; c01efcac <pci_register_driver+5c/60>
Trace; f8a38b20 <[snd-hdsp]driver+0/27>
Trace; f8a06653 <[snd-hdsp]alsa_card_hdsp_init+13/60>
Trace; f8a38b20 <[snd-hdsp]driver+0/27>
Trace; c011e004 <sys_init_module+4f4/660>
Trace; f8a02060 <[snd-hdsp]hdsp_hw_pointer+0/40>
Trace; f8a07604 <[snd-hdsp]__module_license+9d1/1dcd>
Trace; f8a02060 <[snd-hdsp]hdsp_hw_pointer+0/40>
Trace; c010774f <system_call+33/38>

Code;  f8a0643d <[snd-hdsp]snd_hdsp_free+1d/90>
00000000 <_EIP>:
Code;  f8a0643d <[snd-hdsp]snd_hdsp_free+1d/90>   <=====
   0:   89 50 40                  mov    %edx,0x40(%eax)   <=====
Code;  f8a06440 <[snd-hdsp]snd_hdsp_free+20/90>
   3:   8b 83 c4 00 00 00         mov    0xc4(%ebx),%eax
Code;  f8a06446 <[snd-hdsp]snd_hdsp_free+26/90>
   9:   85 c0                     test   %eax,%eax
Code;  f8a06448 <[snd-hdsp]snd_hdsp_free+28/90>
   b:   78 0c                     js     19 <_EIP+0x19>
Code;  f8a0644a <[snd-hdsp]snd_hdsp_free+2a/90>
   d:   89 04 24                  mov    %eax,(%esp,1)
Code;  f8a0644d <[snd-hdsp]snd_hdsp_free+2d/90>
  10:   89 5c 24 04               mov    %ebx,0x4(%esp,1)


1 warning issued.  Results may not be reliable.




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
