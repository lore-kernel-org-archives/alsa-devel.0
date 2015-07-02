From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] Revert "ASoC: wm5100: Pass the
	IRQF_ONESHOT flag"
Date: Thu, 02 Jul 2015 21:27:48 +0800
Message-ID: <1435843668.17967.2.camel@ingics.com>
References: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 967AE265ACA
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 15:27:56 +0200 (CEST)
Received: by pdjd13 with SMTP id d13so45400485pdj.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2015 06:27:55 -0700 (PDT)
In-Reply-To: <1435843604.17967.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

This reverts 3d907cc30d07 ("ASoC: wm5100: Pass the IRQF_ONESHOT flag").

The coccinelle warnings is false positive because the original code does
set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm5100.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4c10cd8..98495dd 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2570,13 +2570,11 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
-						   wm5100_edge_irq,
-						   irq_flags | IRQF_ONESHOT,
+						   wm5100_edge_irq, irq_flags,
 						   "wm5100", wm5100);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm5100_irq,
-						   irq_flags | IRQF_ONESHOT,
-						   "wm5100",
+						   irq_flags, "wm5100",
 						   wm5100);
 
 		if (ret != 0) {
-- 
2.1.0
