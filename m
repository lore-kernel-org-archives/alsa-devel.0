From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001137]: Oops when using ALSA with kernel 2.6.12-rc5-mm1
Date: Sat, 28 May 2005 22:22:25 +0200
Message-ID: <0f997bc8aecde2cef5555d129ee0a4f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3E0611E2
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 22:22:26 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1137> 
======================================================================
Reported By:                bero
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1137
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-28-2005 14:29 CEST
Last Modified:              05-28-2005 22:22 CEST
======================================================================
Summary:                    Oops when using ALSA with kernel 2.6.12-rc5-mm1
Description: 
Unable to handle kernel NULL pointer dereference at virtual address
000000a4
 printing eip:
e0ead873
*pde = 00000000
Oops: 0002 [https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
Modules linked in: eeprom i2c_sensor radeon drm i2c_algo_bit i2c_core
intel_agp agpgart snd_intel8x0 snd_via82xx
 gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device sn
d soundcore psmouse binfmt_misc pcmcia firmware_class yenta_socket
rsrc_nonstatic pcmcia_core 8139too mii af_pac
ket sr_mod ide_cd cdrom ohci1394 ieee1394 sd_mod usbhid usb_storage
scsi_mod ehci_hcd uhci_hcd usbcore video the
rmal processor hotkey fan container button battery ac rtc
CPU:    0
EIP:    0060:[<e0ead873>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-0.rc5.1ark)
EIP is at snd_pcm_mmap_data_close+0xa/0x11 [snd_pcm]
eax: 00000000   ebx: d8bac880   ecx: d85dfd50   edx: e0ead869
esi: db2216a0   edi: db2216a0   ebp: b7eed000   esp: dbc94f54
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 1723, threadinfo=dbc94000 task=da70b030)
Stack: c0148c21 db2216a0 de875580 00000000 00000000 c0149ed6 db2216a0
000800fb
       d8bac880 fffffff0 de875584 d977bb70 d977bb7c b7efd000 d977bb70
de875580
       de8755b0 080970a0 dbc94000 c014a759 de875580 b7eed000 00010000
b7eed000
Call Trace:
 [<c0148c21>] remove_vm_struct+0x63/0x65
 [<c0149ed6>] do_munmap+0x1cf/0x22c
 [<c014a759>] sys_munmap+0x49/0x69
 [<c0102d7f>] sysenter_past_esp+0x54/0x75
Code: 8d 05 a0 0a ec e0 e8 a9 4d 41 df e9 17 ff ff ff 8b 44 24 04 8b 40 50
8b 40 60 ff 80 a4 00 00 00 c3 8b 44 2
4 04 8b 40 50 8b 40 60 <ff> 88 a4 00 00 00 c3 83 ec 1c b9 48 00 00 00 89
7c 24 14 89 6c

======================================================================

----------------------------------------------------------------------
 rlrevell - 05-28-05 22:22 
----------------------------------------------------------------------
Not an ALSA bug, but an upstream -mm bug.  Please see the kernel mailing
list or alsa-devel for the solution.  Or wait for -mm2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 14:29 bero           New Issue                                    
05-28-05 22:22 rlrevell       Note Added: 0004777                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
