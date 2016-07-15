From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: drop redundant idiom when
	converting integer to boolean
Date: Fri, 15 Jul 2016 10:06:17 +0800
Message-ID: <1468548377-9269-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D075265873
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 04:04:05 +0200 (CEST)
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

Thanks Mark and Anatol for the discussion. According to the result, 
the standard C will translate any non-zero value into true, or 
false otherwise.
QUOTE:
"6.3.1.2 Boolean type
When any scalar value is converted to _Bool, the result is 0 if the 
value compares equal to 0; otherwise, the result is 1
"
Thus, the "!!" idiom is removed.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index a97418d..5c9707a 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1349,9 +1349,9 @@ static bool nau8825_is_jack_inserted(struct regmap *regmap)
 	int status, jkdet;
 
 	regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
-	active_high = !!(jkdet & NAU8825_JACK_POLARITY);
+	active_high = jkdet & NAU8825_JACK_POLARITY;
 	regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
-	is_high = !!(status & NAU8825_GPIO2JD1);
+	is_high = status & NAU8825_GPIO2JD1;
 	/* return jack connection status according to jack insertion logic
 	 * active high or active low.
 	 */
-- 
2.6.4
