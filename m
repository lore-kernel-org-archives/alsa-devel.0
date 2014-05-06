From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: add default case for unexpected
	ID
Date: Tue, 6 May 2014 15:56:06 +0800
Message-ID: <1399362966-19908-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E71D26072A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:57:46 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

We may read an unexpected value when detemining which codec is attached.
In that case, either a unsupported codec is attached or something wrong 
with I2C. The driver will not work properly on both cases. So we return
an error for that.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index b0967df..9e0d48f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2019,6 +2019,10 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 			rt5639_specific_dapm_routes,
 			ARRAY_SIZE(rt5639_specific_dapm_routes));
 		break;
+	default:
+		dev_err(codec->dev,
+			"The driver is for RT5639 RT5640 or RT5642 only\n");
+		return -ENODEV;
 	}
 
 	return 0;
-- 
1.8.1.1.439.g50a6b54
