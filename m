From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: twl6040: Change event ordering for
	Earphone driver
Date: Thu, 13 Oct 2011 15:05:43 +0300
Message-ID: <1318507544-26856-4-git-send-email-peter.ujfalusi@ti.com>
References: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 53016103A62
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 14:06:02 +0200 (CEST)
Received: by mail-yw0-f54.google.com with SMTP id 17so1307167ywp.41
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 05:05:59 -0700 (PDT)
In-Reply-To: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

It is better to switch HS Power Mode (if it was in low power mode) before
we enable the Earpiece driver. The switched off EP driver can filter out
noise coming from the Low Power to High Performance transition on the
HSL DAC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 8f033f0..eadece8 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1164,7 +1164,7 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_OUT_DRV_E("Earphone Driver",
 			TWL6040_REG_EARCTL, 0, 0, NULL, 0,
 			twl6040_power_mode_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUT_DRV("Vibra Left Driver",
 			TWL6040_REG_VIBCTLL, 0, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV("Vibra Right Driver",
-- 
1.7.7
