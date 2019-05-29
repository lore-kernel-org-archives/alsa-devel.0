From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] net: sched: pie: Use ULL suffix for 64-bit constant
Date: Wed, 29 May 2019 13:39:06 +0200
Message-ID: <CAK8P3a3yPBOfw+GhTXGXZzr3wdz1yA3kKZGqqWYnW6+TzXm_PQ@mail.gmail.com>
References: <20190528142424.19626-1-geert@linux-m68k.org> <20190528142424.19626-4-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-4-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block <linux-block@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 4:24 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> With gcc 4.1, when compiling for a 32-bit platform:
>
>     net/sched/sch_pie.c: In function ‘drop_early’:
>     net/sched/sch_pie.c:116: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:138: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:144: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:147: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c: In function ‘pie_qdisc_enqueue’:
>     net/sched/sch_pie.c:173: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c: In function ‘calculate_probability’:
>     net/sched/sch_pie.c:371: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:372: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:377: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:382: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:397: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:398: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:399: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:407: warning: integer constant is too large for ‘long’ type
>     net/sched/sch_pie.c:414: warning: integer constant is too large for ‘long’ type
>
> Fix this by adding the missing "ULL" suffix.
>
> Fixes: 3f7ae5f3dc5295ac ("net: sched: pie: add more cases to auto-tune alpha and beta")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I created patches for all instances of this issue at some point in the past,
but did not send those as we raised the minimum compiler version to one
that handles this in the expected way without a warning.

Maybe you can just ignore these as well?

      Arnd
