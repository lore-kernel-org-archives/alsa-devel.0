From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: cs35l35: Improve power down time
Date: Thu, 6 Apr 2017 13:52:12 +0100
Message-ID: <1491483134-28079-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB0B267283
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 14:51:12 +0200 (CEST)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Shorten the time it takes to power down the amp by disabling the volume
ramp whilst doing the final shutdown. The driver has already muted the
amplifier at this stage so doing the volume ramp serves no purpose.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 8 ++++++++
 sound/soc/codecs/cs35l35.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 9688274..1db07a6 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -187,6 +187,10 @@ static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
 					  CS35L35_PDN_ALL_MASK, 1);
 
+		/* Already muted, so disable volume ramp for faster shutdown */
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_DIG_VOL_CTL,
+				   CS35L35_AMP_DIGSFT_MASK, 0);
+
 		reinit_completion(&cs35l35->pdn_done);
 
 		ret = wait_for_completion_timeout(&cs35l35->pdn_done,
@@ -199,6 +203,10 @@ static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
 					CS35L35_MCLK_DIS_MASK,
 					1 << CS35L35_MCLK_DIS_SHIFT);
+
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_DIG_VOL_CTL,
+				   CS35L35_AMP_DIGSFT_MASK,
+				   1 << CS35L35_AMP_DIGSFT_SHIFT);
 		break;
 	default:
 		dev_err(codec->dev, "Invalid event = 0x%x\n", event);
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index 156d2f0..54e9ac5 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -190,6 +190,9 @@
 #define CS35L35_AMP_GAIN_ZC_MASK	0x10
 #define CS35L35_AMP_GAIN_ZC_SHIFT	4
 
+#define CS35L35_AMP_DIGSFT_MASK		0x02
+#define CS35L35_AMP_DIGSFT_SHIFT	1
+
 /* CS35L35_SP_FMT_CTL3 */
 #define CS35L35_SP_I2S_DRV_MASK		0x03
 #define CS35L35_SP_I2S_DRV_SHIFT	0
-- 
2.1.4
