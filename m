From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: jack connection decision with
	different insertion logic
Date: Wed, 29 Jun 2016 11:20:38 +0800
Message-ID: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 798D22605D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 05:18:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The original design only covers the jack insertion logic is active low.
Add more condition to cover no matter the logic is active low and high.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3f30e6e..a2f0d03 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1345,10 +1345,18 @@ EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
 
 static bool nau8825_is_jack_inserted(struct regmap *regmap)
 {
-	int status;
+	int status, jkdet, res;
 
 	regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
-	return !(status & NAU8825_GPIO2JD1);
+	regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
+
+	/* return jack connection status according to jack insertion logic
+	 * active high or active low.
+	 */
+	res = !(status & NAU8825_GPIO2JD1) * !(jkdet & NAU8825_JACK_POLARITY) +
+		(status & NAU8825_GPIO2JD1) * (jkdet & NAU8825_JACK_POLARITY);
+
+	return res ? true : false;
 }
 
 static void nau8825_restart_jack_detection(struct regmap *regmap)
-- 
2.6.4
