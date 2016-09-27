From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Add debug prints for output
	power up/down times
Date: Tue, 27 Sep 2016 16:35:44 +0100
Message-ID: <1474990545-29282-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A058C266F4E
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 17:35:54 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

When debugging it is useful to check the total power up/down delay that
is executed as part of the coalesced output delay. This patch adds some
debug prints for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 780cf4f..eaf1dbb 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -891,6 +891,8 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending--;
 			if (!priv->out_up_pending) {
+				dev_dbg(codec->dev, "Power up delay: %d\n",
+					priv->out_up_delay);
 				msleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
@@ -925,6 +927,8 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending--;
 			if (!priv->out_down_pending) {
+				dev_dbg(codec->dev, "Power down delay: %d\n",
+					priv->out_down_delay);
 				msleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
-- 
2.1.4
