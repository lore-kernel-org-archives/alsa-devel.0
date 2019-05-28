From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] net: sched: pie: Use ULL suffix for 64-bit constant
Date: Tue, 28 May 2019 16:24:22 +0200
Message-ID: <20190528142424.19626-4-geert@linux-m68k.org>
References: <20190528142424.19626-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-block@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

With gcc 4.1, when compiling for a 32-bit platform:

    net/sched/sch_pie.c: In function ‘drop_early’:
    net/sched/sch_pie.c:116: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:138: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:144: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:147: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c: In function ‘pie_qdisc_enqueue’:
    net/sched/sch_pie.c:173: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c: In function ‘calculate_probability’:
    net/sched/sch_pie.c:371: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:372: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:377: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:382: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:397: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:398: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:399: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:407: warning: integer constant is too large for ‘long’ type
    net/sched/sch_pie.c:414: warning: integer constant is too large for ‘long’ type

Fix this by adding the missing "ULL" suffix.

Fixes: 3f7ae5f3dc5295ac ("net: sched: pie: add more cases to auto-tune alpha and beta")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/sched/sch_pie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 8fa129d3943e32ad..f3424833e6a7cd3b 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -31,7 +31,7 @@
 
 #define QUEUE_THRESHOLD 16384
 #define DQCOUNT_INVALID -1
-#define MAX_PROB 0xffffffffffffffff
+#define MAX_PROB 0xffffffffffffffffULL
 #define PIE_SCALE 8
 
 /* parameters used */
-- 
2.17.1
