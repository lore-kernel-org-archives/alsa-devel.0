From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 31/31] sound/soc: use kmemdup rather than duplicating its
 implementation
Date: Fri, 07 Aug 2015 09:59:37 +0200
Message-ID: <1438934377-4922-32-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4dadb5e..a5da91b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -831,12 +831,12 @@ static int soc_tplg_denum_create_values(struct soc_enum *se,
 	if (ec->items > sizeof(*ec->values))
 		return -EINVAL;
 
-	se->dobj.control.dvalues =
-		kmalloc(ec->items * sizeof(u32), GFP_KERNEL);
+	se->dobj.control.dvalues = kmemdup(ec->values,
+					   ec->items * sizeof(u32),
+					   GFP_KERNEL);
 	if (!se->dobj.control.dvalues)
 		return -ENOMEM;
 
-	memcpy(se->dobj.control.dvalues, ec->values, ec->items * sizeof(u32));
 	return 0;
 }
 
-- 
1.9.1
