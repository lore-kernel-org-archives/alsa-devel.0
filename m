From: syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>
Subject: Re: WARNING in port_delete
Date: Mon, 01 Apr 2019 00:58:01 -0700
Message-ID: <0000000000002402ed05857361e0@google.com>
References: <0000000000004f7eb00570be9f92@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000004f7eb00570be9f92@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, colin.king@canonical.com, linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com, perex@perex.cz, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 63d86a7e85f84b8ac3b2f394570965aedbb03787
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue May 1 20:08:46 2018 +0000

     rcu: Convert rcu_grace_period_init tracepoint to gp_seq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f86d2f200000
start commit:   091a1eaa Merge branch 'akpm'
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14046d2f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10046d2f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Fixes: 63d86a7e85f8 ("rcu: Convert rcu_grace_period_init tracepoint to  
gp_seq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
