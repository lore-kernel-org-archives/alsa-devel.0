From: "Mary Y." <blessedwithsarah@comcast.net>
Subject: azx driver and CMI9880L
Date: Fri, 20 Aug 2004 15:31:50 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408201531.50338.blessedwithsarah@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I have a CMI9880L card (Which, in Windows, is called "C-Media Azalia" which, 
from what I read, complies with Intel's Azalia specifications. I don't know 
much about soundcards at all, so I'm sorry if I don't understand and that 
driver won't work with the CMI hardware after all. 

But I found this in alsa cvs log:

====================== 
Update of /cvsroot/alsa/alsa-driver/pci/azx
 In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv29210
 
 Modified Files:
        codec_enum.c 
 Log Message:
 From C.L. Tien:
 
 Fixed the inifinte loop in the probing of c-media 9880 codec.
====================== 

Here is the audio section from lspci:
====================== 
0000:00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 03)
        Subsystem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d3800000 (64-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [70] #10 [0091]
====================== 

I'm using alsa cvs, just downloaded today, now that sourceforge is back up.

I loaded the modules snd-azx

lsmod:
======================                                          
Module                  Size  Used by
eth1394                19720  0
ohci1394               32004  0
ieee1394               94264  2 eth1394,ohci1394
snd_azx                31928  0
snd_pcm               104068  1 snd_azx
snd_timer              28164  1 snd_pcm
snd                    64260  3 snd_azx,snd_pcm,snd_timer
snd_page_alloc         11016  1 snd_pcm
====================== 
When I try alsamixer for the first time after a reboot, trying to change the 
master volume in alsamixer causes a segfault. There are just two channels, 
but Andy Kopp at Intel (one of the people who wrote the Azalia driver) told 
me that is normal because the driver implements limited audio functionality. 

Master is at 100 and Capture is at 0. I can change the volume of Capture OK. 

Here is the message of the segfault:

======================
Unable to handle kernel NULL pointer dereference at virtual address 00000054
 printing eip:
e0bbfb4b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: eth1394 ohci1394 ieee1394 snd_azx snd_pcm snd_timer snd 
snd_page_alloc
CPU:    1
EIP:    0060:[<e0bbfb4b>]    Not tainted
EFLAGS: 00210246   (2.6.8)
EIP is at snd_azx_mast_vol_out_callback_put+0x36/0xfd [snd_azx]
eax: 00000000   ebx: dff9a194   ecx: d2a69414   edx: 00000040
esi: d33c5f26   edi: d33c5f25   ebp: ded2ec14   esp: d33c5f00
ds: 007b   es: 007b   ss: 0068
Process alsamixer (pid: 6781, threadinfo=d33c5000 task=df60d8b0)
Stack: 00000000 d2a69414 c024f3b0 d2a69414 bfffd220 000002c4 d2a69414 00200246
       c024f468 403f9414 df684414 d2a69414 df684560 00000002 e0bd8397 dff9a194
       d2a69414 000002c4 dff9a194 00000000 fffffff3 00000000 ffffffe7 bfffd220
Call Trace:
 [<c024f3b0>] __copy_from_user_ll+0x68/0x6c
 [<c024f468>] copy_from_user+0x52/0x7e
 [<e0bd8397>] snd_ctl_elem_write+0x1b9/0x208 [snd]
 [<e0bd8ff4>] snd_ctl_ioctl+0x38b/0x4ba [snd]
 [<c0172550>] sys_ioctl+0x113/0x27f
 [<c0106117>] syscall_call+0x7/0xb
Code: 0f b6 50 54 89 54 24 20 8b 48 58 89 4c 24 1c 8b 40 5c 89 44
======================

After it segfaults, all audio applications hang, including alsamixer. If they 
are in a terminal you can't get rid of them even with a Ctrl+C.

Oh BTW, the card works fine in Windows... so it's not connected wrong or 
anything like that.

Anyone know what might be wrong? Am I being really dumb and using the wrong 
driver? Or something.. I've been trying for weeks, with the alsa RC and 
everything, not just the CVS - they both give me this problem.

Thanks in advance.

Mary


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
