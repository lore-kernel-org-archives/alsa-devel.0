From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in port_delete
Date: Tue, 2 Apr 2019 15:12:16 +0200
Message-ID: <CACT4Y+ZBxcwq+s9HbrVRFFt04Ri+MyVR9CQ=pp-5D13LzVngdg@mail.gmail.com>
References: <0000000000004f7eb00570be9f92@google.com> <0000000000002402ed05857361e0@google.com>
 <20190401192413.GQ4102@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401192413.GQ4102@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>, alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, Colin King <colin.king@canonical.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Steven Rostedt <rostedt@goodmis.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 1, 2019 at 9:25 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Mon, Apr 01, 2019 at 12:58:01AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 63d86a7e85f84b8ac3b2f394570965aedbb03787
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Tue May 1 20:08:46 2018 +0000
> >
> >     rcu: Convert rcu_grace_period_init tracepoint to gp_seq
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f86d2f200000
> > start commit:   091a1eaa Merge branch 'akpm'
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14046d2f200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10046d2f200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000
> >
> > Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> > Fixes: 63d86a7e85f8 ("rcu: Convert rcu_grace_period_init tracepoint
> > to gp_seq")
>
> I could easily be suffering from a lack of imagination, but I am not
> seeing how this change to RCU's event tracing could cause this result.
> Especially given that CONFIG_RCU_TRACE=n in your .config.
>
> What am I missing here?

I don't think you are missing something here.
