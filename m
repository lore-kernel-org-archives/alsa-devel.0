From: syzbot <syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in linear_transfer
Date: Sun, 17 Mar 2019 03:43:01 -0700
Message-ID: <0000000000009e4ca4058447ef02@google.com>
References: <00000000000052a5500584348100@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000000000052a5500584348100@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, gustavo@embeddedor.com, joe@perches.com, linux-kernel@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Nov 9 10:59:45 2018 +0000

     ALSA: oss: Use kvzalloc() for local buffer allocations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b70c2b200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b70c2b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b70c2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=a39b5d3c50e55e24fb4d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113945fb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed3cf7200000

Reported-by: syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
