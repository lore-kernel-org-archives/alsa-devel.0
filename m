From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Fri, 06 Sep 2002 03:31:53 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D77A319.3010703@boosthardware.com>
References: <Pine.LNX.4.21.0209042052440.726-100000@summer.quitte>	<3D7763E6.1090601@boosthardware.com> <s5hu1l4lalp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>That was it. Thanks.
>>
>>Yes this code works. I don't know what that means though?
> 
> 
> ok, then it means that something in prepare() does initialize
> something (hmm, too ambiguous :), not the fact that you send the data
> to the device.
> 
> but please make sure that this trick works after fresh reboot, too
> (and/or after the usb device power-off).  it's just to be sure...
> 

Yes to both

> 
> 
>>I have also found a serious kernel oops which is caused when starting 
>>jack with this card. It also fscked my user profile in mozilla so I have 
>>lost all my emails from teh past 6 months.
> 
> 
> oh, that's too bad.
> 
> please let me know if you catch an oops trace.
> 

Here's what I get from ksymoops

----
Warning (compare_maps): ksyms_base symbol 
vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map. 
Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000020
c01e52e4
*pde = 00000000
CPU:    0
EIP:    0010:[<c01e52e4>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: cf21cc84   ebx: cf21c480    ecx: d7efd3fc      edx: cf21c484
esi: 00000000   ed1: 00000097     ebp: cf21cc84       esp: c0287f38
Warning (Oops_set_regs): garbage 'ed1: 00000097     ebp: cf21cc84 
esp: c0287f38' at end of register line ignored
ds: 0018        es: 0018       ss:0018
Process swapper (pid: 0, stackpage=c0287000)
Stack:  00000292 d7efd3fc 00000000 0000cc00 d7efd380 c0287fac c01e535b5 
d7efd380
         d7efd380 d7eede80 04000001 0000000b c0109e8a 0000000b d7efd380 
c0287fac
         c0287fac 0000000b c02bee80 d7eede80 c010a018 0000000b c0287fac 
d7eede80
Call Trace: [<c01e53b5>] [<c0109e8a>] [<c010a018>] [<c0106f10>] [<c0106f10>]
    [<c010c108>] [<c0106f10>] [<c0106f36>] {<c0106fc2>] [<c0105000>]
Code: c7 46 20 98 ff ff ff 8b 43 10 8b 1b 80 b8 00 00 00 8b 48


 >>EIP; c01e52e4 <uhci_remove_pending_qhs+44/90>   <=====

 >>eax; cf21cc84 <_end+ef35f08/187112e4>
 >>ebx; cf21c480 <_end+ef35704/187112e4>
 >>ecx; d7efd3fc <_end+17c16680/187112e4>
 >>edx; cf21c484 <_end+ef35708/187112e4>

Trace; c01e53b5 <uhci_interrupt+85/f0>
Trace; c0109e8a <handle_IRQ_event+3a/80>
Trace; c010a018 <do_IRQ+58/b0>
Trace; c0106f10 <default_idle+0/30>
Trace; c0106f10 <default_idle+0/30>
Trace; c010c108 <call_do_IRQ+5/d>
Trace; c0106f10 <default_idle+0/30>
Trace; c0106f36 <default_idle+26/30>

Code;  c01e52e4 <uhci_remove_pending_qhs+44/90>
00000000 <_EIP>:
Code;  c01e52e4 <uhci_remove_pending_qhs+44/90>   <=====
    0:   c7 46 20 98 ff ff ff      movl   $0xffffff98,0x20(%esi)   <=====
Code;  c01e52eb <uhci_remove_pending_qhs+4b/90>
    7:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c01e52ee <uhci_remove_pending_qhs+4e/90>
    a:   8b 1b                     mov    (%ebx),%ebx
Code;  c01e52f0 <uhci_remove_pending_qhs+50/90>
    c:   80 b8 00 00 00 8b 48      cmpb   $0x48,0x8b000000(%eax)

  <0>Kernel panic:Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.
----

Interestingly I have just seen a thread on usb-devel about various 
lockups in the usb  code so it might be related.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
