From: "thewade" <pdman@aproximation.org>
Subject: hdsploader error: binary, kernel or what?
Date: Wed, 8 Sep 2004 19:14:03 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409090114.i891E3Ah030941@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I have compiled into my kernel the Hammerfall DSP sound driver. When I 
boot I get:
Hammerfall-DSP: no Digiface or Multiface connected!
card initialization pending : waiting for firmware
even though the Multiface IS connected.

When I run hdsploader I get:
Message from syslogd@musicbox at Wed Sep  8 18:49:56 2004 ...
musicbox kernel: Oops: 0000 [1]

Message from syslogd@musicbox at Wed Sep  8 18:49:57 2004 ...
musicbox kernel: CR2: 0000000000000000
<1>Unable to handle kernel NULL pointer dereference at 0000000000000068
RIP:
<ffffffff80188022>{sync_sb_inodes+194}
PML4 3f398067 PGD 3f269067 PMD 0
Oops: 0000 [2]
CPU 0
Modules linked in: ipv6 autofs4 ds yenta_socket pcmcia_core ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables sg scsi_mod oh
ci1394 ieee1394 dm_mod joydev ohci_hcd ehci_hcd button battery asus_acpi
ac ext3 jbd
Pid: 52, comm: pdflush Not tainted 2.6.8.1-2
RIP: 0010:[<ffffffff80188022>] <ffffffff80188022>{sync_sb_inodes+194}
RSP: 0018:000001003fc11dc8  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000010037ea9400 RCX: 000001003c7c2a88
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000001003cf253f8
RBP: 000001003c7c2a78 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000040 R11: 000001003e9bd700 R12: 000001003fc54bd8
R13: 000001003fc11e58 R14: 0000010037ea94d0 R15: 0000000000000000
FS:  0000002a9556a780(0000) GS:ffffffff8045c240(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000068 CR3: 0000000000101000 CR4: 00000000000006e0
Process pdflush (pid: 52, threadinfo 000001003fc10000, task
0000010037e9a0b0)
Stack: ffffffff8033321b 0000010037ea94c0 00000000fffc56f0 0000010037ea9400
       0000010037ea9478 000001003fc11e58 ffffffff803aa530 000001003ff3fec8
       0000000000000000 ffffffff801883e8
Call Trace:<ffffffff8033321b>{__down_failed_trylock+53}
<ffffffff801883e8>{writeback_inodes+104}
       <ffffffff801530b9>{wb_kupdate+185} <ffffffff80153ad8>{pdflush+264}
       <ffffffff80153000>{wb_kupdate+0} <ffffffff801539d0>{pdflush+0}
       <ffffffff8014438d>{kthread+205} <ffffffff80110c37>{child_rip+8}
       <ffffffff801443d0>{keventd_create_kthread+0}
<ffffffff801442c0>{kthread+0}
       <ffffffff80110c2f>{child_rip+0}

Code: 4c 8b 60 68 45 8b 54 24 10 45 85 d2 74 40 48 3b 1d b1 8f 2a
RIP <ffffffff80188022>{sync_sb_inodes+194} RSP <000001003fc11dc8>
CR2: 0000000000000068

Message from syslogd@musicbox at Wed Sep  8 18:50:04 2004 ...
musicbox kernel: Oops: 0000 [2]

Message from syslogd@musicbox at Wed Sep  8 18:50:04 2004 ...
musicbox kernel: CR2: 0000000000000068

What is configured wrong?
My old laptop with 2.6.4 seems to have no problem with the hammerfall...

Thanks for your help!
-thewade
ps: My machine is an AMD 64 laptop running FC3t1 and the standard 
2.6.8.1 kernel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
