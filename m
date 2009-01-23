From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/9] ASoC: Add missing comma to
	SND_SOC_DAPM_SWITCH_E in soc-dapm.h
Date: Fri, 23 Jan 2009 17:18:38 +0000
Message-ID: <1232731120-6144-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E338F2448D
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Typo fix.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 93a4edb..dfa8049 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -108,7 +108,7 @@
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1 \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-- 
1.5.6.5
