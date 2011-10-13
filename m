From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: twl6040: Rename the Earphone Driver
	event handler
Date: Thu, 13 Oct 2011 15:05:44 +0300
Message-ID: <1318507544-26856-5-git-send-email-peter.ujfalusi@ti.com>
References: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 861DF103A40
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 14:06:02 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id zs2so294227bkb.25
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 05:06:00 -0700 (PDT)
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

Since the event handler is only used by the Earphone Driver, it is better
to rename it from twl6040_power_mode_event to twl6040_ep_drv_event.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index eadece8..6c573c3 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -673,7 +673,7 @@ static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
+static int twl6040_ep_drv_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
@@ -1163,7 +1163,7 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUT_DRV_E("Earphone Driver",
 			TWL6040_REG_EARCTL, 0, 0, NULL, 0,
-			twl6040_power_mode_event,
+			twl6040_ep_drv_event,
 			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUT_DRV("Vibra Left Driver",
 			TWL6040_REG_VIBCTLL, 0, 0, NULL, 0),
-- 
1.7.7
