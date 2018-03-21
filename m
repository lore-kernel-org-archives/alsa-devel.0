From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8824: user configuration of key
	detection
Date: Wed, 21 Mar 2018 15:30:23 +0800
Message-ID: <1521617423-2213-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A46267321
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 08:30:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The SAR ADC of key press detection varies depending on headset.
We can't make a set of common threshold values for every case.
Therefore, the driver provides configuration for user and
they can set up values by UCM configuration.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 637e952..76502c0 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -409,6 +409,15 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 
 	SOC_SINGLE("DACL LR Mix", NAU8824_REG_DAC_MUTE_CTRL, 0, 1, 0),
 	SOC_SINGLE("DACR LR Mix", NAU8824_REG_DAC_MUTE_CTRL, 1, 1, 0),
+
+	SOC_SINGLE("THD for key media",
+		NAU8824_REG_VDET_THRESHOLD_1, 8, 0xff, 0),
+	SOC_SINGLE("THD for key voice command",
+		NAU8824_REG_VDET_THRESHOLD_1, 0, 0xff, 0),
+	SOC_SINGLE("THD for key volume up",
+		NAU8824_REG_VDET_THRESHOLD_2, 8, 0xff, 0),
+	SOC_SINGLE("THD for key volume down",
+		NAU8824_REG_VDET_THRESHOLD_2, 0, 0xff, 0),
 };
 
 static int nau8824_output_dac_event(struct snd_soc_dapm_widget *w,
-- 
2.6.4
