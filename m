From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/5] ASoC: wm5100: Pass the IRQF_ONESHOT flag
Date: Tue, 12 May 2015 01:22:57 -0300
Message-ID: <1431404580-17991-2-git-send-email-festevam@gmail.com>
References: <1431404580-17991-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 12C51265334
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 06:24:20 +0200 (CEST)
Received: by ykep21 with SMTP id p21so44194822yke.3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 21:24:19 -0700 (PDT)
In-Reply-To: <1431404580-17991-1-git-send-email-festevam@gmail.com>
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
 sound/soc/codecs/wm5100.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 9674037..5de28bfd 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2570,11 +2570,13 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
-						   wm5100_edge_irq, irq_flags,
+						   wm5100_edge_irq,
+						   irq_flags | IRQF_ONESHOT,
 						   "wm5100", wm5100);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm5100_irq,
-						   irq_flags, "wm5100",
+						   irq_flags | IRQF_ONESHOT,
+						   "wm5100",
 						   wm5100);
 
 		if (ret != 0) {
-- 
1.9.1
