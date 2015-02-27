From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: rt286: correct the OR to AND
Date: Fri, 27 Feb 2015 12:52:26 +0800
Message-ID: <1425012746-11355-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA732606DE
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 05:50:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Here it should be AND(&) to check the status.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 16723b1..49c44a7 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -397,7 +397,7 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 
 	if (jack) {
 		/* enable IRQ */
-		if (rt286->jack->status | SND_JACK_HEADPHONE)
+		if (rt286->jack->status & SND_JACK_HEADPHONE)
 			snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO1");
 		regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2, 0x2);
 		/* Send an initial empty report */
-- 
1.9.1
