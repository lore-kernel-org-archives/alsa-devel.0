From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: No recording on hda-intel (AD1981HD)
Date: Tue, 12 Feb 2008 23:17:40 +0100
Message-ID: <200802122317.40255.grzegorz.chwesewicz@chilan.com>
References: <200802032017.38614.grzegorz.chwesewicz@chilan.com>
	<s5hve4utgms.wl%tiwai@suse.de>
	<200802121859.44416.grzegorz.chwesewicz@chilan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id B3E3A24426
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 23:17:55 +0100 (CET)
In-Reply-To: <200802121859.44416.grzegorz.chwesewicz@chilan.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

Takashi, below is listing of few softlockups that I've encountered while 
testing your patch (MSI one).

78921 Feb  7 17:37:01 ensima-hp [  290.184844] BUG: soft lockup - CPU#0 stuck 
for 11s! [kirqd:879]
78922 Feb  7 17:37:01 ensima-hp [  290.184848]
78923 Feb  7 17:37:01 ensima-hp [  290.184851] Pid: 879, comm: kirqd Not 
tainted (2.6.24 #3)
78924 Feb  7 17:37:01 ensima-hp [  290.184854] EIP: 0060:[<c0155ed3>] EFLAGS: 
00000246 CPU: 0
78925 Feb  7 17:37:01 ensima-hp [  290.184859] EIP is at 
handle_IRQ_event+0x13/0x60
78926 Feb  7 17:37:01 ensima-hp [  290.184862] EAX: 000000dc EBX: f72177a0 
ECX: f7d9c000 EDX: f72177a0
78927 Feb  7 17:37:01 ensima-hp [  290.184865] ESI: f72177a0 EDI: 000000dc 
EBP: 000000dc ESP: f7d9df0c
78928 Feb  7 17:37:01 ensima-hp [  290.184868]  DS: 007b ES: 007b FS: 00d8 GS: 
0000 SS: 0068
78929 Feb  7 17:37:01 ensima-hp [  290.184871] CR0: 8005003b CR2: 0807b064 
CR3: 36e30000 CR4: 000006d0
78930 Feb  7 17:37:01 ensima-hp [  290.184875] DR0: 00000000 DR1: 00000000 
DR2: 00000000 DR3: 00000000
78931 Feb  7 17:37:02 ensima-hp [  290.184878] DR6: ffff0ff0 DR7: 00000400
78932 Feb  7 17:37:02 ensima-hp [  290.184895]  [<c01573dd>] 
handle_edge_irq+0xad/0x130
78933 Feb  7 17:37:02 ensima-hp [  290.184903]  [<c010827b>] do_IRQ+0x3b/0x70
78934 Feb  7 17:37:02 ensima-hp [  290.184915]  [<c0105ea3>] 
common_interrupt+0x23/0x28
78935 Feb  7 17:37:02 ensima-hp [  290.184929]  [<c011b6f3>] 
balanced_irq+0x3f3/0x5b0
78936 Feb  7 17:37:02 ensima-hp [  290.184949]  [<c011b300>] 
balanced_irq+0x0/0x5b0
78937 Feb  7 17:37:02 ensima-hp [  290.184969]  [<c013e502>] kthread+0x42/0x70
78938 Feb  7 17:37:02 ensima-hp [  290.184973]  [<c013e4c0>] kthread+0x0/0x70
78939 Feb  7 17:37:02 ensima-hp [  290.184977]  [<c01060cf>] 
kernel_thread_helper+0x7/0x18
78940 Feb  7 17:37:02 ensima-hp [  290.184987]  =======================
78941 Feb  7 17:37:13 ensima-hp [  301.989526] BUG: soft lockup - CPU#0 stuck 
for 11s! [kirqd:879]
78942 Feb  7 17:37:13 ensima-hp [  301.989529]
78943 Feb  7 17:37:13 ensima-hp [  301.989531] Pid: 879, comm: kirqd Not 
tainted (2.6.24 #3)
78944 Feb  7 17:37:13 ensima-hp [  301.989533] EIP: 0060:[<c0155ed3>] EFLAGS: 
00000246 CPU: 0
78945 Feb  7 17:37:13 ensima-hp [  301.989536] EIP is at 
handle_IRQ_event+0x13/0x60
78946 Feb  7 17:37:13 ensima-hp [  301.989539] EAX: 000000dc EBX: f72177a0 
ECX: f7d9c000 EDX: f72177a0
78947 Feb  7 17:37:13 ensima-hp [  301.989541] ESI: f72177a0 EDI: 000000dc 
EBP: 000000dc ESP: f7d9df0c
78948 Feb  7 17:37:13 ensima-hp [  301.989544]  DS: 007b ES: 007b FS: 00d8 GS: 
0000 SS: 0068
78949 Feb  7 17:37:13 ensima-hp [  301.989547] CR0: 8005003b CR2: 0807b064 
CR3: 36e30000 CR4: 000006d0
78950 Feb  7 17:37:13 ensima-hp [  301.989550] DR0: 00000000 DR1: 00000000 
DR2: 00000000 DR3: 00000000
78951 Feb  7 17:37:14 ensima-hp [  301.989552] DR6: ffff0ff0 DR7: 00000400
78952 Feb  7 17:37:14 ensima-hp [  301.989560]  [<c01573dd>] 
handle_edge_irq+0xad/0x130
78953 Feb  7 17:37:14 ensima-hp [  301.989581]  [<c010827b>] do_IRQ+0x3b/0x70
78954 Feb  7 17:37:14 ensima-hp [  301.989592]  [<c0105ea3>] 
common_interrupt+0x23/0x28
78955 Feb  7 17:37:14 ensima-hp [  301.989606]  [<c011b6f3>] 
balanced_irq+0x3f3/0x5b0
78956 Feb  7 17:37:14 ensima-hp [  301.989639]  [<c011b300>] 
balanced_irq+0x0/0x5b0
78957 Feb  7 17:37:14 ensima-hp [  301.989644]  [<c013e502>] kthread+0x42/0x70
78958 Feb  7 17:37:14 ensima-hp [  301.989646]  [<c013e4c0>] kthread+0x0/0x70
78959 Feb  7 17:37:14 ensima-hp [  301.989651]  [<c01060cf>] 
kernel_thread_helper+0x7/0x18
78960 Feb  7 17:37:14 ensima-hp [  301.989659]  =======================
78961 Feb  7 17:37:25 ensima-hp [  313.794211] BUG: soft lockup - CPU#0 stuck 
for 11s! [kirqd:879]
78962 Feb  7 17:37:25 ensima-hp [  313.794214]
78963 Feb  7 17:37:25 ensima-hp [  313.794216] Pid: 879, comm: kirqd Not 
tainted (2.6.24 #3)
78964 Feb  7 17:37:25 ensima-hp [  313.794218] EIP: 0060:[<c03a6117>] EFLAGS: 
00000282 CPU: 0
78965 Feb  7 17:37:25 ensima-hp [  313.794222] EIP is at 
_read_unlock_irqrestore+0x7/0x30
78966 Feb  7 17:37:25 ensima-hp [  313.794226] EAX: 00000282 EBX: f6ee4800 
ECX: f7d9c000 EDX: 00000282
78967 Feb  7 17:37:25 ensima-hp [  313.794229] ESI: f71d1380 EDI: 000004c8 
EBP: f6ee4800 ESP: f7d9deac
78968 Feb  7 17:37:25 ensima-hp [  313.794231]  DS: 007b ES: 007b FS: 00d8 GS: 
0000 SS: 0068
78969 Feb  7 17:37:25 ensima-hp [  313.794237] CR0: 8005003b CR2: 0807b064 
CR3: 36e30000 CR4: 000006d0
78970 Feb  7 17:37:25 ensima-hp [  313.794257] DR0: 00000000 DR1: 00000000 
DR2: 00000000 DR3: 00000000
78971 Feb  7 17:37:25 ensima-hp [  313.794272] DR6: ffff0ff0 DR7: 00000400
78972 Feb  7 17:37:26 ensima-hp [  313.794275]  [<f955ffed>] 
snd_pcm_period_elapsed+0x7d/0x2f0 [snd_pcm]
78973 Feb  7 17:37:26 ensima-hp [  313.794298]  [<c027c993>] 
pci_bus_write_config_word+0x63/0x80
78974 Feb  7 17:37:26 ensima-hp [  313.794323]  [<f956efd9>] 
azx_interrupt+0x79/0x100 [snd_hda_intel]
78975 Feb  7 17:37:26 ensima-hp [  313.794344]  [<c0155ef0>] 
handle_IRQ_event+0x30/0x60
78976 Feb  7 17:37:26 ensima-hp [  313.794351]  [<c01573dd>] 
handle_edge_irq+0xad/0x130
78977 Feb  7 17:37:26 ensima-hp [  313.794357]  [<c010827b>] do_IRQ+0x3b/0x70
78978 Feb  7 17:37:26 ensima-hp [  313.794366]  [<c0105ea3>] 
common_interrupt+0x23/0x28
78979 Feb  7 17:37:26 ensima-hp [  313.794377]  [<c011b6f3>] 
balanced_irq+0x3f3/0x5b0
78980 Feb  7 17:37:26 ensima-hp [  313.794393]  [<c011b300>] 
balanced_irq+0x0/0x5b0
78981 Feb  7 17:37:26 ensima-hp [  313.794398]  [<c013e502>] kthread+0x42/0x70
78982 Feb  7 17:37:26 ensima-hp [  313.794401]  [<c013e4c0>] kthread+0x0/0x70
78983 Feb  7 17:37:26 ensima-hp [  313.794405]  [<c01060cf>] 
kernel_thread_helper+0x7/0x18
78984 Feb  7 17:37:27 ensima-hp [  313.794414]  =======================
78985 Feb  7 17:37:37 ensima-hp [  325.598892] BUG: soft lockup - CPU#0 stuck 
for 11s! [kirqd:879]
78986 Feb  7 17:37:37 ensima-hp [  325.598895]
78987 Feb  7 17:37:37 ensima-hp [  325.598897] Pid: 879, comm: kirqd Not 
tainted (2.6.24 #3)
78988 Feb  7 17:37:37 ensima-hp [  325.598899] EIP: 0060:[<c03a6117>] EFLAGS: 
00000282 CPU: 0
78989 Feb  7 17:37:37 ensima-hp [  325.598902] EIP is at 
_read_unlock_irqrestore+0x7/0x30
78990 Feb  7 17:37:37 ensima-hp [  325.598907] EAX: 00000282 EBX: f6ee4800 
ECX: f7d9c000 EDX: 00000282
78991 Feb  7 17:37:37 ensima-hp [  325.598910] ESI: f71d1380 EDI: 000004c8 
EBP: f6ee4800 ESP: f7d9deac
78992 Feb  7 17:37:37 ensima-hp [  325.598913]  DS: 007b ES: 007b FS: 00d8 GS: 
0000 SS: 0068
78993 Feb  7 17:37:37 ensima-hp [  325.598924] CR0: 8005003b CR2: 0807b064 
CR3: 36e30000 CR4: 000006d0
78994 Feb  7 17:37:37 ensima-hp [  325.598928] DR0: 00000000 DR1: 00000000 
DR2: 00000000 DR3: 00000000
78995 Feb  7 17:37:37 ensima-hp [  325.598942] DR6: ffff0ff0 DR7: 00000400
78996 Feb  7 17:37:37 ensima-hp [  325.598946]  [<f955ffed>] 
snd_pcm_period_elapsed+0x7d/0x2f0 [snd_pcm]
78997 Feb  7 17:37:37 ensima-hp [  325.598964]  [<c027c993>] 
pci_bus_write_config_word+0x63/0x80
78998 Feb  7 17:37:37 ensima-hp [  325.598983]  [<f956efd9>] 
azx_interrupt+0x79/0x100 [snd_hda_intel]
78999 Feb  7 17:37:38 ensima-hp [  325.599003]  [<c0155ef0>] 
handle_IRQ_event+0x30/0x60
79000 Feb  7 17:37:38 ensima-hp [  325.599010]  [<c01573dd>] 
handle_edge_irq+0xad/0x130
79001 Feb  7 17:37:38 ensima-hp [  325.599016]  [<c010827b>] do_IRQ+0x3b/0x70
79002 Feb  7 17:37:38 ensima-hp [  325.599025]  [<c0105ea3>] 
common_interrupt+0x23/0x28
79003 Feb  7 17:37:38 ensima-hp [  325.599036]  [<c011b6f3>] 
balanced_irq+0x3f3/0x5b0
79004 Feb  7 17:37:38 ensima-hp [  325.599052]  [<c011b300>] 
balanced_irq+0x0/0x5b0
79005 Feb  7 17:37:38 ensima-hp [  325.599057]  [<c013e502>] kthread+0x42/0x70
79006 Feb  7 17:37:38 ensima-hp [  325.599060]  [<c013e4c0>] kthread+0x0/0x70
79007 Feb  7 17:37:38 ensima-hp [  325.599064]  [<c01060cf>] 
kernel_thread_helper+0x7/0x18
79008 Feb  7 17:37:38 ensima-hp [  325.599073]  =======================

-- 
Greetings
Grzegorz Chwesewicz, Chilan 
mailto:grzegorz.chwesewicz@chilan.com
