From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Oops in 2.5.46 (snd-usb-audio)
Date: Tue, 5 Nov 2002 10:06:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211051006.46069.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

The usb subsystem has been pretty unstable lately, so this oops
may not be the fault of snd-usb-audio.

Duncan.

drivers/usb/core/usb.c: deregistering driver snd-usb-audio
Unable to handle kernel paging request at virtual address cc8b4278
 printing eip:
cc8b4278
*pde = 0be81067
*pte = 00000000
Oops: 0000
r128 snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd usbtest uhci-hcd usbcore nls_iso8859-1 nls_cp437 vfat fat rtc  
CPU:    0
EIP:    0060:[<cc8b4278>]    Not tainted
EFLAGS: 00010286
EIP is at E __insmod_snd-timer_S.data_L216+0xb038/0xd8 [snd-timer]
eax: cc8b4278   ebx: cbd5e1a0   ecx: cc8a9258   edx: cc8a9244
esi: cbd5e280   edi: cbd5e1a0   ebp: cc8a9258   esp: cb4f9f60
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 844, threadinfo=cb4f8000 task=cb6b60a0)
Stack: cc8a6db2 cbd5e1a0 cc8a9258 cc8a6f63 cbd5e1a0 cbd5e178 cc8a6000 ca0e2000 
       cc8a6000 cc8a7e20 cbd5e1a0 fffffff0 c01176c7 fffffff0 cc8a6000 ca0e2000 
       bfffed98 c0116af0 cc8a6000 00000000 cb4f8000 00000001 bfffed98 bfffed98 
Call Trace:
 [<cc8a6db2>] snd_timer_free+0x12/0x24 [snd-timer]
 [<cc8a9258>] register_mutex+0x0/0x14 [snd-timer]
 [<cc8a6f63>] snd_timer_unregister+0x93/0x9c [snd-timer]
 [<cc8a7e20>] cleanup_module+0x28/0x62 [snd-timer]
 [<c01176c7>] free_module+0x17/0xc0
 [<c0116af0>] sys_delete_module+0x11c/0x274
 [<c0108857>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <3>drivers not released (1)


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
