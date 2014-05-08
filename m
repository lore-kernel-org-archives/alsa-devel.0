From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/4] ASoC: rt5645: Move settings from probe()
	to reg_default struct
Date: Thu, 8 May 2014 14:47:36 +0800
Message-ID: <1399531657-31793-3-git-send-email-oder_chiou@realtek.com>
References: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 34C912654BE
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 08:47:50 +0200 (CEST)
In-Reply-To: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch moves the private register settings from probe() to reg_default
struct.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9d8c7c8..4be9000 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -50,6 +50,10 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 
 static const struct reg_default init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
+	{RT5645_PR_BASE + 0x1c, 0xfd20);
+	{RT5645_PR_BASE + 0x20, 0x611f);
+	{RT5645_PR_BASE + 0x21, 0x4040);
+	{RT5645_PR_BASE + 0x23, 0x0004);
 };
 #define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
@@ -2205,10 +2209,6 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 	rt5645_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
-	snd_soc_write(codec, RT5645_PR_BASE + 0x1c, 0xfd20);
-	snd_soc_write(codec, RT5645_PR_BASE + 0x20, 0x611f);
-	snd_soc_write(codec, RT5645_PR_BASE + 0x21, 0x4040);
-	snd_soc_write(codec, RT5645_PR_BASE + 0x23, 0x0004);
 
 	return 0;
 }
-- 
1.8.1.1.439.g50a6b54
