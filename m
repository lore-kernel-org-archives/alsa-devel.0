From: syzbot <syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in default_read_copy_kernel
Date: Sat, 16 Mar 2019 07:49:02 -0700
Message-ID: <00000000000097b4a405843741e6@google.com>
References: <0000000000004a6256057ca3b6bd@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000004a6256057ca3b6bd@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, dan.carpenter@oracle.com, gustavo@embeddedor.com, joe@perches.com, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp, pasqualirb@gmail.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de, twischer@de.adit-jv.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Nov 9 10:59:45 2018 +0000

     ALSA: oss: Use kvzalloc() for local buffer allocations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ae57db200000
start commit:   65766ee0 ALSA: oss: Use kvzalloc() for local buffer alloca..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=106e57db200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ae57db200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=12f17c177de05efea72d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c27125400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152a2a43400000

Reported-by: syzbot+12f17c177de05efea72d@syzkaller.appspotmail.com
Fixes: 65766ee0 ("ALSA: oss: Use kvzalloc() for local buffer allocations")
