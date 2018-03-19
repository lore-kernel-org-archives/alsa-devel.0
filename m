From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: don't turn off HV and VREF if
	headset is detected
Date: Mon, 19 Mar 2018 18:07:29 +0800
Message-ID: <1521454049-32435-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 052DB266F2E
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 11:07:48 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, puneethx.prabhu@intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

"HV" and "VREF" will be powered up when jack type detection process is
started and will be powered off when jack type detection process is finished.
It will generate an unexpected interrupt signal when they are powered
up during the capture process. Codec driver will do the jack type detection
process and we can't capture properly before the jack detection process is
finished. This patch will not power off the "HV" and "VREF" widgets if
headset is detected and it will solve the unexpected interrupt issue. As a
result, it will also solve the silence data captured at the beginning in
headset mic recording issue.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7bf4b31..06cdba4 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -290,9 +290,10 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 		regmap_read(rt298->regmap, RT298_GET_MIC1_SENSE, &buf);
 		*mic = buf & 0x80000000;
 	}
-
-	snd_soc_dapm_disable_pin(dapm, "HV");
-	snd_soc_dapm_disable_pin(dapm, "VREF");
+	if (!*mic) {
+		snd_soc_dapm_disable_pin(dapm, "HV");
+		snd_soc_dapm_disable_pin(dapm, "VREF");
+	}
 	if (!*hp)
 		snd_soc_dapm_disable_pin(dapm, "LDO1");
 	snd_soc_dapm_sync(dapm);
-- 
2.7.4
