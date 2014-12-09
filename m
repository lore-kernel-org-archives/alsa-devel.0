From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: Fix potential crash in jd
	function
Date: Tue, 9 Dec 2014 10:14:45 +0800
Message-ID: <1418091285-4700-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 198EE2605B7
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 03:15:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

If no one defined the rt5645->pdata.hp_det_gpio in coreboot/bios.
It will cause kernel to reboot because rt5645->pdata.hp_det_gpio
is 0. So it is worth to add a check in rt5645_jack_detect.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
* Return an error if gpio number is invalid
---
 sound/soc/codecs/rt5645.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a7789a8..27141e2 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2209,6 +2209,10 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec)
 	int gpio_state, jack_type = 0;
 	unsigned int val;
 
+	if (!gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
+		dev_err(codec->dev, "invalid gpio\n");
+		return -EINVAL;
+	}
 	gpio_state = gpio_get_value(rt5645->pdata.hp_det_gpio);
 
 	dev_dbg(codec->dev, "gpio = %d(%d)\n", rt5645->pdata.hp_det_gpio,
-- 
1.8.1.1.439.g50a6b54
