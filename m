From: <fischerc@swissphone.de>
Subject: [PATCH] ASoC: sgtl5000: fix powerup/down of
	micbias-voltage
Date: Thu, 11 Jan 2018 09:40:31 +0100
Message-ID: <1515660031-9183-1-git-send-email-fischerc@swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id D69362668F0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 09:40:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com, Christian Fischer <fischerc@swissphone.de>, bhumirks@gmail.com, richard.leitner@skidata.com
List-Id: alsa-devel@alsa-project.org

From: Christian Fischer <fischerc@swissphone.de>

The mic-bias-voltage should get powered up/down automatically.
Added missing DAPM_PRE and DAPM_POST widgets to fire up the mic_bias_event function.

Signed-off-by: Christian Fischer <fischerc@swissphone.de>
---
 sound/soc/codecs/sgtl5000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f2bb4fe..4973365 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -260,6 +260,9 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 
 	SND_SOC_DAPM_PRE("VAG_POWER_PRE", power_vag_event),
 	SND_SOC_DAPM_POST("VAG_POWER_POST", power_vag_event),
+
+	SND_SOC_DAPM_PRE("MIC_BIAS_PRE", mic_bias_event),
+	SND_SOC_DAPM_POST("MIC_BIAS_POST", mic_bias_event),
 };
 
 /* routes for sgtl5000 */
-- 
2.7.4
