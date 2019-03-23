From: syzbot <syzbot+c4c4b2bb358bb936ad7e@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in rt_cache_valid
Date: Sat, 23 Mar 2019 14:10:00 -0700
Message-ID: <000000000000f8e14f0584c96446@google.com>
References: <00000000000066aa5f0581b6effe@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <00000000000066aa5f0581b6effe@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alexandre.torgue@st.com, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, broonie@kernel.org, colin.king@canonical.com, davem@davemloft.net, dsahern@gmail.com, ktkhai@virtuozzo.com, kuznet@ms2.inr.ac.ru, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, olivier.moysan@st.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, tyhicks@canonical.com, willy@infradead.org, yoshfuji@linux-ipv6.org
List-Id: alsa-devel@alsa-project.org

syzbot has bisected this bug to:

commit 6b27e27729270a2478fdebea2db9c4f57bb4e8e6
Author: Colin Ian King <colin.king@canonical.com>
Date:   Wed Oct 31 19:31:43 2018 +0000

     ASoC: stm32: sai: fix less than zero comparison on unsigned int

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c0298b200000
start commit:   aa0c38cf Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12c0298b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0298b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c4b2bb358bb936ad7e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1197cb88c00000

Reported-by: syzbot+c4c4b2bb358bb936ad7e@syzkaller.appspotmail.com
Fixes: 6b27e2772927 ("ASoC: stm32: sai: fix less than zero comparison on  
unsigned int")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
