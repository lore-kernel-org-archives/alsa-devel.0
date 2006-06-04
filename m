From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002184]: nspluginviewer (only?) causes
	oops sometimes
Date: Sun, 4 Jun 2006 02:24:06 +0200
Message-ID: <9f8b494d6f2b0fc94b7d5f1f438ceeb5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27BF3152
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jun 2006 02:24:07 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2184> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2184
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             06-04-2006 02:24 CEST
Last Modified:              06-04-2006 02:24 CEST
======================================================================
Summary:                    nspluginviewer (only?) causes oops sometimes
Description: 
After this crash can't restart alsasound modules/services, only reboot.
Here dmesg output

Unable to handle kernel paging request at virtual address f8eaa1a8
 printing eip:
f9475689
*pde = 1ff5b067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: snd_rtctimer snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_pcm_oss snd_mixer_oss rfcomm hidp l2cap arc4
ieee80211_crypt_wep ohci_hcd e100 mii ohci1394 ieee1394 yenta_socket
rsrc_nonstatic pcmcia_core ipw3945 ieee80211 ieee80211_crypt
firmware_class nvidia i2c_i801 i2c_core ehci_hcd hci_usb bluetooth
uhci_hcd snd_hda_intel snd_hda_codec snd_pcm snd_timer snd snd_page_alloc
rtc usbcore realtime joydev
CPU:    0
EIP:    0060:[<f9475689>]    Tainted: PF     VLI
EFLAGS: 00010287   (2.6.16-gentoo-r6 #3)
EIP is at resample_expand+0x15b/0x1b9 [snd_pcm_oss]
eax: f8eaa1a8   ebx: 00000000   ecx: 00000800   edx: 00000000
esi: 000001ef   edi: 00000002   ebp: e0283ec4   esp: e0283e88
ds: 007b   es: 007b   ss: 0068
Process nspluginviewer (pid: 7184, threadinfo=e0282000 task=e2a19560)
Stack: <0>00000b9b bfa1beb0 e6f73f04 d8d2e334 d8d2e320 00000002 00000000
f8eaa1a8
       f8e9d844 00000000 00000000 00000132 00001806 00000400 d8d2e2c0
e0283eec
       f9475998 d8d2e2c0 e6f73e00 e6f73f00 00000400 00001806 d8d2e2c0
00000400
Call Trace:
 [<f9475998>] rate_transfer+0x32/0x3c [snd_pcm_oss]
 [<f94742d8>] snd_pcm_plug_write_transfer+0x80/0xb1 [snd_pcm_oss]
 [<f9471099>] snd_pcm_oss_write2+0x7a/0xc1 [snd_pcm_oss]
 [<f9471246>] snd_pcm_oss_write1+0x166/0x1b5 [snd_pcm_oss]
 [<c016211f>] vfs_write+0xa5/0x13c
 [<c0162254>] sys_write+0x3b/0x63
 [<c0102d23>] sysenter_past_esp+0x54/0x75
Code: af 45 f0 99 f7 f9 8b 55 ec 01 c2 81 fa 00 80 ff ff 7d 07 ba 00 80 ff
ff eb 0e 81 fa 00 80 00 00 b8 ff 7f 00 00 0f 4d d0 8b 45 e0 <66> 89 10 8b
55 d4 8d 04 78 89 45 e0 8b 45 c4 8b 12 01 55 f0 ff

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-04-06 02:24 fdoffizi01     New Issue                                    
06-04-06 02:24 fdoffizi01     Distribution              => Gentoo          
06-04-06 02:24 fdoffizi01     Kernel Version            => 2.6.16          
======================================================================
