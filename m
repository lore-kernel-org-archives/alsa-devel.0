From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [Patch v2] sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag
Date: Wed, 10 Jul 2019 07:46:27 +0530
Message-ID: <20190710021627.GA13396@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Gen Zhang <blackgod016574@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
handler finished".

fixes below issue reported by coccicheck

sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
primary handler requested without IRQF_ONESHOT

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v1 : add IRQF_ONESHOT and introduce irqflags variable 
v2 : remove irqflags variable

 sound/soc/codecs/wcd9335.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..9566027 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4062,7 +4062,8 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 
 		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
 						wcd9335_irqs[i].handler,
-						IRQF_TRIGGER_RISING,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
 						wcd9335_irqs[i].name, wcd);
 		if (ret) {
 			dev_err(wcd->dev, "Failed to request %s\n",
-- 
2.7.4
