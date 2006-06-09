From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002197]: Kernel Oops playing on
	M-Audio Revolution 5.1
Date: Fri, 9 Jun 2006 05:17:21 +0200
Message-ID: <3dac0e9de5d19f00c7fb5ba3490daec0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 677E2175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 05:17:21 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2197> 
======================================================================
Reported By:                admeralthrawn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2197
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.16 with gentoo patchset (r9)
======================================================================
Date Submitted:             06-09-2006 04:43 CEST
Last Modified:              06-09-2006 05:17 CEST
======================================================================
Summary:                    Kernel Oops playing on M-Audio Revolution 5.1
Description: 
First time I play sound I get a kernel oops.  dmesg output:

Unable to handle kernel NULL pointer dereference at 00000000000000b0 RIP:
<ffffffff880a0c6d>{:snd_ice1724:snd_vt1724_playback_pro_open+29}
PGD 793cf067 PUD 793ce067 PMD 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: nvidia smbfs snd_seq snd_pcm_oss snd_mixer_oss
snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114
snd_pcm snd_timer snd_page_alloc snd_ak4xxx_adda snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore ntfs i2c_nforce2 i2c_core
Pid: 5502, comm: aplay Tainted: P      2.6.16-gentoo-r9 #4
RIP: 0010:[<ffffffff880a0c6d>]
<ffffffff880a0c6d>{:snd_ice1724:snd_vt1724_playback_pro_open+29}
RSP: 0018:ffff81007854fd68  EFLAGS: 00010246
RAX: ffffffff880ae940 RBX: ffff81007e69c400 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8100793c6390 RDI: ffff81007e69c400
RBP: ffff810079b0f400 R08: 00000000000f4240 R09: 0000000000000011
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81007e69c600 R14: ffff81007c7b8980 R15: 0000000000000000
FS:  00002b1f2882b1c0(0000) GS:ffff810002f65b40(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000b0 CR3: 0000000079b1a000 CR4: 00000000000006e0
Process aplay (pid: 5502, threadinfo ffff81007854e000, task
ffff81007fe982c0)
Stack: 0000000000000000 ffff81007a0feae0 ffff81007e69c788
ffffffff8806a8e1
       ffff81007e69c7a8 ffff81007e69c400 ffff810000000000
ffff81007fe982c0
       ffffffff80128c20 ffff81007e69c7b0
Call Trace: <ffffffff8806a8e1>{:snd_pcm:snd_pcm_open+353}
       <ffffffff80128c20>{default_wake_function+0}
<ffffffff8803c1eb>{:snd:snd_open+283}
       <ffffffff80180259>{chrdev_open+393}
<ffffffff801800d0>{chrdev_open+0}
       <ffffffff801763dc>{__dentry_open+236}
<ffffffff80176522>{nameidata_to_filp+34}
       <ffffffff8017656a>{do_filp_open+42}
<ffffffff8017670e>{get_unused_fd+110}
       <ffffffff8017691a>{do_sys_open+90}
<ffffffff8010ad86>{system_call+126}

Code: 49 89 bc 24 b0 00 00 00 48 8b 05 44 dd 00 00 48 89 85 68 01
RIP <ffffffff880a0c6d>{:snd_ice1724:snd_vt1724_playback_pro_open+29} RSP
<ffff81007854fd68>
CR2: 00000000000000b0 
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-09-06 05:17 
----------------------------------------------------------------------
Please reproduce with an untainted kernel (aka without nvidia loaded)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 04:43 admeralthrawn  New Issue                                    
06-09-06 04:43 admeralthrawn  Distribution              => Gentoo          
06-09-06 04:43 admeralthrawn  Kernel Version            => 2.6.16 with gentoo
patchset (r9)
06-09-06 05:17 rlrevell       Note Added: 0010131                          
======================================================================
