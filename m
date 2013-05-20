From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] ASoC: max98090: request IRQF_ONESHOT interrupt
Date: Sun, 19 May 2013 22:58:07 -0700
Message-ID: <1369029487-32702-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>, Ralph Birt <ralph.birt@maximintegrated.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>
List-Id: alsa-devel@alsa-project.org

request_threaded_irq() rejects calls which both do not specify a handler
(indicating that the primary IRQ handler should be used) and do not set
IRQF_ONESHOT because the combination is unsafe with level-triggered
interrupts.  It is safe in this case, though, since max98090 IRQs are
edge-triggered and the interrupts aren't ACK'ed until the codec's IRQ
status register is read.  Because of this, an IRQF_ONESHOT interrupt
doesn't really make a difference, but request one anyway in order to make
request_threaded_irq() happy.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index cbb272b..1bf96bd 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2247,7 +2247,7 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "irq = %d\n", max98090->irq);
 
 	ret = request_threaded_irq(max98090->irq, NULL,
-		max98090_interrupt, IRQF_TRIGGER_FALLING,
+		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 		"max98090_interrupt", codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "request_irq failed: %d\n",
-- 
1.8.2.1
