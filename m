From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: dapm: Remove SND_SOC_DAPM_MICBIAS_E()
Date: Wed, 28 Mar 2012 20:53:46 +0100
Message-ID: <1332964426-8480-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53C8D24414
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 21:53:55 +0200 (CEST)
In-Reply-To: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There are no users any more and new drivers should be using supply widgets
which fully replace it anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f98dc7d..01e7ad1 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -141,10 +141,6 @@ struct device;
 {       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols, .event = wevent, .event_flags = wflags}
-#define SND_SOC_DAPM_MICBIAS_E(wname, wreg, wshift, winvert, wevent, wflags) \
-{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = NULL, .num_kcontrols = 0, \
-	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-- 
1.7.9.1
