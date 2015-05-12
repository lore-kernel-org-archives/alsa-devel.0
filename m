From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/5] ASoC: wm8994: Pass the IRQF_ONESHOT flag
Date: Tue, 12 May 2015 01:22:58 -0300
Message-ID: <1431404580-17991-3-git-send-email-festevam@gmail.com>
References: <1431404580-17991-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f42.google.com (mail-yh0-f42.google.com
 [209.85.213.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BED9265335
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 06:24:23 +0200 (CEST)
Received: by yhcb70 with SMTP id b70so42795556yhc.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 21:24:22 -0700 (PDT)
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
 sound/soc/codecs/wm8994.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2d32b54..dc8f482 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4084,7 +4084,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		if (wm8994->micdet_irq)
 			ret = request_threaded_irq(wm8994->micdet_irq, NULL,
 						   wm8994_mic_irq,
-						   IRQF_TRIGGER_RISING,
+						   IRQF_TRIGGER_RISING |
+						   IRQF_ONESHOT,
 						   "Mic1 detect",
 						   wm8994);
 		 else
@@ -4132,7 +4133,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		if (wm8994->micdet_irq) {
 			ret = request_threaded_irq(wm8994->micdet_irq, NULL,
 						   wm8958_mic_irq,
-						   IRQF_TRIGGER_RISING,
+						   IRQF_TRIGGER_RISING |
+						   IRQF_ONESHOT,
 						   "Mic detect",
 						   wm8994);
 			if (ret != 0)
-- 
1.9.1
