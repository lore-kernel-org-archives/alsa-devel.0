From: John Hsu <supercraig0719@gmail.com>
Subject: ASoC: nau8825: make crosstalk function optional
Date: Wed, 21 Jun 2017 14:55:54 +0800
Message-ID: <1498028154-10888-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B6B4626680F
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 08:56:09 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id s66so27939921pfs.2
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 23:56:09 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, John Hsu <supercraig0719@gmail.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Make crosstalk functoin optional.
The jack detection can speed up without crosstalk detection.
Let the decision of function usage to platform design.

The patch helps the issue concern as follows:
Google issue 35574278: Chell_headphone pop back from S3

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 sound/soc/codecs/nau8825.c | 6 +++++-
 sound/soc/codecs/nau8825.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index ff827bb..fd307f5 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1682,7 +1682,7 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
-			if (!nau8825->high_imped) {
+			if (!nau8825->xtalk_bypass && !nau8825->high_imped) {
 				/* Apply the cross talk suppression in the
 				 * headset without high impedance.
 				 */
@@ -2498,6 +2498,10 @@ static int nau8825_read_device_properties(struct device *dev,
 		&nau8825->jack_eject_debounce);
 	if (ret)
 		nau8825->jack_eject_debounce = 0;
+	ret = device_property_read_u32(dev, "nuvoton,crosstalk-bypass",
+		&nau8825->xtalk_bypass);
+	if (ret)
+		nau8825->xtalk_bypass = 1;
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 514fd13..8aee5c86 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -476,6 +476,7 @@ struct nau8825 {
 	int xtalk_event_mask;
 	bool xtalk_protect;
 	int imp_rms[NAU8825_XTALK_IMM];
+	int xtalk_bypass;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.6.4
