From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Add delay for jack plug in
Date: Wed, 30 Aug 2017 13:08:31 +0800
Message-ID: <1504069711-6549-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 646C5267049
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 07:08:47 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, Hsinyu Chao <hychao@chromium.org>, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Codec initialize takes some time when 3.5mm jack plugged in. Add a
delay to report jack plugged event to user space to avoid pop noise.

Signed-off-by: Hsinyu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index c98a8a7..ab9e0eb 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1705,6 +1705,9 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 			default:
 				dev_err(codec->dev, "Unknown CODEC Version\n");
 			}
+
+			/* Delay the jack insert report to avoid pop noise */
+			msleep(30);
 		} else {
 			/* jack is already in, report button event */
 			report = SND_JACK_HEADSET;
-- 
2.7.4
