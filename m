From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/23] ASoC: tas2552: Fix kernel crash
	caused by wrong kcontrol entry
Date: Thu, 4 Jun 2015 16:04:15 +0300
Message-ID: <1433423075-14142-4-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 537F82606A2
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:04:47 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SOC_DAPM_SINGLE("Playback AMP", ..) should not be under kcontrols. It
causes kernel crash (NULL pointer) when the mixers are listed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index df89947f1032..9954bd4c14f3 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -338,7 +338,6 @@ static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 24);
 static const struct snd_kcontrol_new tas2552_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
 			 TAS2552_PGA_GAIN, 0, 0x1f, 1, dac_tlv),
-	SOC_DAPM_SINGLE("Playback AMP", SND_SOC_NOPM, 0, 1, 0),
 };
 
 static const struct reg_default tas2552_init_regs[] = {
-- 
2.4.2
