From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: uniperf: Add missing __iomem
	annotation
Date: Mon, 27 Jul 2015 10:56:26 +0200
Message-ID: <1437987388-9706-5-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A6326078A
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:38 +0200 (CEST)
In-Reply-To: <1437987388-9706-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

base referes to a iomem region, so it should have the __iomem annotation.
Fixes the following warnings from sparse:

	sound/soc/sti/sti_uniperif.c:169:19: warning: incorrect type in
		assignment (different address spaces)
	sound/soc/sti/sti_uniperif.c:169:19:    expected void *base
	sound/soc/sti/sti_uniperif.c:169:19:    got void [noderef] <asn:2>*
	sound/soc/sti/uniperif_player.c:104:18: warning: incorrect type in
		argument 1 (different address spaces)
	sound/soc/sti/uniperif_player.c:104:18:    expected void const volatile
		[noderef] <asn:2>*addr
	sound/soc/sti/uniperif_player.c:104:18:    got void *
	[...]

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sti/uniperif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index ee462f7..f0fd5a9 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1168,7 +1168,7 @@ struct uniperif {
 
 	/* Resources */
 	struct resource *mem_region;
-	void *base;
+	void __iomem *base;
 	unsigned long fifo_phys_address;
 	int irq;
 
-- 
2.1.4
