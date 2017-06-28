From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ASoC: rt5645: add inv_jd1_1 flag
Date: Wed, 28 Jun 2017 14:49:38 +0200
Message-ID: <20170628124939.11696-4-tiwai@suse.de>
References: <20170628124939.11696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E9C5266BBC
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:49:42 +0200 (CEST)
In-Reply-To: <20170628124939.11696-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

The flag will invert jd1_1 status. Which will be used if the jack
connector is normal closed.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rt5645.h    | 2 ++
 sound/soc/codecs/rt5645.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index c427f10a39ae..d0c33a9972b9 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,8 @@ struct rt5645_platform_data {
 	unsigned int jd_mode;
 	/* Use level triggered irq */
 	bool level_trigger_irq;
+	/* Invert JD1_1 status polarity */
+	bool inv_jd1_1;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e0c09bbd3f12..162044d82632 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3833,6 +3833,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		default:
 			break;
 		}
+		if (rt5645->pdata.inv_jd1_1) {
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+		}
 	}
 
 	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
-- 
2.13.2
