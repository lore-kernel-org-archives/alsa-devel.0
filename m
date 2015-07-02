From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] Revert "ASoC: wm8996: Pass the
	IRQF_ONESHOT flag"
Date: Thu, 02 Jul 2015 21:29:01 +0800
Message-ID: <1435843741.17967.3.camel@ingics.com>
References: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 66680265A12
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 15:29:10 +0200 (CEST)
Received: by pacws9 with SMTP id ws9so41426872pac.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2015 06:29:09 -0700 (PDT)
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

This reverts ed043aebe6ec ("ASoC: wm8996: Pass the IRQF_ONESHOT flag").

The coccinelle warnings is false positive because the original code does
set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8996.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 3dd063f..370459f 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2647,12 +2647,10 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
 						   wm8996_edge_irq,
-						   irq_flags | IRQF_ONESHOT,
-						   "wm8996", codec);
+						   irq_flags, "wm8996", codec);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm8996_irq,
-						   irq_flags | IRQF_ONESHOT,
-						   "wm8996", codec);
+						   irq_flags, "wm8996", codec);
 
 		if (ret == 0) {
 			/* Unmask the interrupt */
-- 
2.1.0
