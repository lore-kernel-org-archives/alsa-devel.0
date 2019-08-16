From: syzbot <syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com>
Subject: Re: INFO: rcu detected stall in __do_softirq
Date: Thu, 15 Aug 2019 17:10:01 -0700
Message-ID: <000000000000b4126c059030cfb6@google.com>
References: <000000000000d3c7e0058f605a53@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000d3c7e0058f605a53@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, bp@alien8.de, gregkh@linuxfoundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de, pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com, srinivas.kandagatla@linaro.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vkoul@kernel.org, x86@kernel.org, yakui.zhao@intel.com
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 2aeac95d1a4cc85aae57ab842d5c3340df0f817f
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Tue Jun 11 10:40:41 2019 +0000

     soundwire: add module_sdw_driver helper macro

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114b45ee600000
start commit:   882e8691 Add linux-next specific files for 20190801
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=134b45ee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=154b45ee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=466b331af3f34e94
dashboard link: https://syzkaller.appspot.com/bug?extid=6593c6b8c8b66a07cd98
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b216b2600000

Reported-by: syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com
Fixes: 2aeac95d1a4c ("soundwire: add module_sdw_driver helper macro")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
