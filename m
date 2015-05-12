From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/5] ASoC: twl6040: Pass the IRQF_ONESHOT flag
Date: Tue, 12 May 2015 01:22:59 -0300
Message-ID: <1431404580-17991-4-git-send-email-festevam@gmail.com>
References: <1431404580-17991-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 80BE226533F
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 06:24:25 +0200 (CEST)
Received: by ykeo186 with SMTP id o186so44241815yke.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 21:24:25 -0700 (PDT)
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
 sound/soc/codecs/twl6040.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b8ecce2..4791f9a 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1121,7 +1121,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	mutex_init(&priv->mutex);
 
 	ret = request_threaded_irq(priv->plug_irq, NULL,
-					twl6040_audio_handler, IRQF_NO_SUSPEND,
+					twl6040_audio_handler,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					"twl6040_irq_plug", codec);
 	if (ret) {
 		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
-- 
1.9.1
