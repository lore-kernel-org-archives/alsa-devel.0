From: Lorenzo Pivetta <lorenzo.pivetta@elettra.trieste.it>
Subject: Intel HDA & snd_azx
Date: Fri, 26 Nov 2004 16:19:58 +0100
Message-ID: <20041126161958.2ef6cd83.lorenzo.pivetta@elettra.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi all,

I'm trying to get ALSA sound support working on an Intel D915GEV board with
Intel HDA ICH6 integrated sound support.
I've dowloaded the CVS repository snapshot and build
all the modules without problems (debian 3.1, gcc 3.3.4, glib-2.0).
"modprobe snd_azx" is successful...

>lsmod
Module                  Size  Used by
snd_azx                28232  1 
snd_pcm                82564  1 snd_azx
snd_timer              21124  1 snd_pcm
snd                    46564  5 snd_azx,snd_pcm,snd_timer
soundcore               7648  1 snd
snd_page_alloc          7816  1 snd_pcm
...

...but calling alsamixer causes a OOPS:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f88e1a24
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: snd_azx snd_pcm snd_timer snd soundcore snd_page_alloc floppy vfat fat 8250 serial_core nfs lockd sunrpc parport_pc lp parport sk98lin piix ehci_hcd uhci_hcd usbcore ide_generic ide_cd ide_core cdrom
CPU:    0
EIP:    0060:[<f88e1a24>]    Not tainted VLI
EFLAGS: 00210282   (2.6.9) 
EIP is at snd_azx_cap_select_info+0x3a/0x4d [snd_azx]
eax: 00000000   ebx: f7dbda80   ecx: e6aaa000   edx: db8cde40
esi: 00000000   edi: db8cde98   ebp: c1105511   esp: db8cde20
ds: 007b   es: 007b   ss: 0068
Process alsamixer (pid: 20983, threadinfo=db8cc000 task=f5aaa910)
Stack: f7a08c00 f7a08d4c f89e4ce3 f7dbda80 db8cde40 00000110 00000000 f7db8564 
       00000004 00000002 00000000 00000000 74706143 20657275 72756f53 00006563 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<f89e4ce3>] snd_ctl_elem_info+0x79/0x1d9 [snd]
 [<f89e5c70>] snd_ctl_ioctl+0x263/0x3ae [snd]
 [<c01532cd>] __fput+0xc7/0x12f
 [<f89e5a0d>] snd_ctl_ioctl+0x0/0x3ae [snd]
 [<c016443f>] sys_ioctl+0x101/0x27a
 [<c0105c6f>] syscall_call+0x7/0xb
Code: 44 24 0c 8d 7a 58 8b 48 5c c7 42 48 01 00 00 00 c7 42 40 03 00 00 00 0f b6 81 3c 02 00 00 89 42 50 8b 42 54 8b b4 81 40 02 00 00 <ac> aa 84 c0 75 fa 8b 7c 24 04 31 c0 8b 34 24 83 c4 08 c3 83 ec

Any suggestion?
Tanks and regards,
Lorenzo

-- 
Ing. Lorenzo Pivetta   \ e-mail: lorenzo.pivetta@elettra.trieste.it
                        \ tel.:  040 - 3758361 - fax: 040 - 9380902
Sincrotrone Trieste SCpA \ url:  http://www.elettra.trieste.it


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
