From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/5] ASoC: wm8996: Pass the IRQF_ONESHOT flag
Date: Tue, 12 May 2015 01:22:56 -0300
Message-ID: <1431404580-17991-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E3C672651B7
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 06:24:17 +0200 (CEST)
Received: by ykeo186 with SMTP id o186so44240833yke.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 21:24:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
bogus threaded irq requests") threaded IRQs without a primary handler
need to be requested with IRQF_ONESHOT, otherwise the request will fail.

So pass the IRQF_ONESHOT flag in this case.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/irqf_oneshot.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8996.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 3dce507..232f234 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2644,10 +2644,12 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
 						   wm8996_edge_irq,
-						   irq_flags, "wm8996", codec);
+						   irq_flags | IRQF_ONESHOT,
+						   "wm8996", codec);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm8996_irq,
-						   irq_flags, "wm8996", codec);
+						   irq_flags | IRQF_ONESHOT,
+						   "wm8996", codec);
 
 		if (ret == 0) {
 			/* Unmask the interrupt */
-- 
1.9.1
