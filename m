From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] ASoC: rsnd: Fix warnings due to improper
	printk formats
Date: Tue,  4 Mar 2014 19:10:51 +0100
Message-ID: <1393956651-10658-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [95.142.166.194])
 by alsa0.perex.cz (Postfix) with ESMTP id A40EE261B21
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 19:09:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Use the %pap printk specifier to print resource_size_t variables. This
fixes warnings on platforms where resource_size_t has a different size
than int.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 sound/soc/sh/rcar/gen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index add088b..f505b1f 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -283,13 +283,13 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 		return ret;
 
 	dev_dbg(dev, "Gen2 device probed\n");
-	dev_dbg(dev, "SRU  : %08x => %p\n", scu_res->start,
+	dev_dbg(dev, "SRU  : %pap => %p\n", &scu_res->start,
 		gen->base[RSND_GEN2_SCU]);
-	dev_dbg(dev, "ADG  : %08x => %p\n", adg_res->start,
+	dev_dbg(dev, "ADG  : %pap => %p\n", &adg_res->start,
 		gen->base[RSND_GEN2_ADG]);
-	dev_dbg(dev, "SSIU : %08x => %p\n", ssiu_res->start,
+	dev_dbg(dev, "SSIU : %pap => %p\n", &ssiu_res->start,
 		gen->base[RSND_GEN2_SSIU]);
-	dev_dbg(dev, "SSI  : %08x => %p\n", ssi_res->start,
+	dev_dbg(dev, "SSI  : %pap => %p\n", &ssi_res->start,
 		gen->base[RSND_GEN2_SSI]);
 
 	return 0;
-- 
Regards,

Laurent Pinchart
