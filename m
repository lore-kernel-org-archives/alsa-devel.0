From: syzbot <syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in default_write_copy_kernel
Date: Tue, 19 Mar 2019 21:16:00 -0700
Message-ID: <0000000000001a1eb005847ee152@google.com>
References: <000000000000c93833057b6d496a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000c93833057b6d496a@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, gustavo@embeddedor.com, joe@perches.com, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp, pasqualirb@gmail.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de, twischer@de.adit-jv.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Nov 9 10:59:45 2018 +0000

     ALSA: oss: Use kvzalloc() for local buffer allocations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c3005d200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13c3005d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15c3005d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=d4503ae45b65c5bc1194
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1789354d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162ebe2b400000

Reported-by: syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
