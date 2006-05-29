From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock detected!
Date: Mon, 29 May 2006 20:32:47 +0200
Message-ID: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4DD1159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 20:32:51 +0200 (MEST)
Received: by nz-out-0102.google.com with SMTP id l1so604229nzf
	for <alsa-devel@alsa-project.org>; Mon, 29 May 2006 11:32:48 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I get this with Ingo's lockdep patch from
http://people.redhat.com/mingo/generic-irq-subsystem/

====================================
[ BUG: possible deadlock detected! ]
------------------------------------
modprobe/592 is trying to acquire lock:
 (&grp->list_mutex){----}, at: [<fd9ee555>]
snd_seq_port_connect+0xc0/0x337 [snd_seq]

but task is already holding lock:
 (&grp->list_mutex){----}, at: [<fd9ee4fb>]
snd_seq_port_connect+0x66/0x337 [snd_seq]

which could potentially lead to deadlocks!

other info that might help us debug this:
1 locks held by modprobe/592:
 #0:  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
snd_seq_port_connect+0x66/0x337 [snd_seq]

stack backtrace:
 <c1003f36> show_trace+0xd/0xf  <c1004449> dump_stack+0x17/0x19
 <c1039792> __lockdep_acquire+0xa1a/0xa39  <c1039bed> lockdep_acquire+0x69/0x82
 <fd9ee570> snd_seq_port_connect+0xdb/0x337 [snd_seq]  <fd9ea5f5>
snd_seq_ioctl_subscribe_port+0x96/0xe6 [snd_seq]
 <fd9e91d4> snd_seq_do_ioctl+0x5d/0x68 [snd_seq]  <fd9e921c>
snd_seq_kernel_client_ctl+0x2d/0x3b [snd_seq]
 <f8877274> snd_seq_oss_create_client+0x12d/0x142 [snd_seq_oss]
<f88770f7> alsa_seq_oss_init+0xf7/0x147 [snd_seq_oss]
 <c104116d> sys_init_module+0xa6/0x230  <c11efa8b> sysenter_past_esp+0x54/0x8d

Here is dmesg http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-dmesg

Here is config
http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
