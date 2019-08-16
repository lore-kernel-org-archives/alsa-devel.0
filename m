From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: INFO: rcu detected stall in __do_softirq
Date: Fri, 16 Aug 2019 09:55:49 +0100
Message-ID: <63c0dc1e-323d-d46e-2d4a-b5b6d6916042@linaro.org>
References: <000000000000b4126c059030cfb6@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000b4126c059030cfb6@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com>, alsa-devel@alsa-project.org, bp@alien8.de, gregkh@linuxfoundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de, pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vkoul@kernel.org, x86@kernel.org, yakui.zhao@intel.com
List-Id: alsa-devel@alsa-project.org



On 16/08/2019 01:10, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 2aeac95d1a4cc85aae57ab842d5c3340df0f817f
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Tue Jun 11 10:40:41 2019 +0000
> 
>      soundwire: add module_sdw_driver helper macro

Not sure how adding a macro with no users triggers this rcu stall.

BTW this was in mainline since rc1.

--srini

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114b45ee600000
> start commit:   882e8691 Add linux-next specific files for 20190801
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=134b45ee600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=154b45ee600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=466b331af3f34e94
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=6593c6b8c8b66a07cd98
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b216b2600000
> 
> Reported-by: syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com
> Fixes: 2aeac95d1a4c ("soundwire: add module_sdw_driver helper macro")
> 
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection
