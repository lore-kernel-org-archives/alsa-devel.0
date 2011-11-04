From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Only enable thermal shutdown when
	required on WM9081
Date: Fri,  4 Nov 2011 22:46:25 +0000
Message-ID: <1320446785-20120-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA6A21038C2
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 23:46:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM9081 thermal shutdown is only effective when the speaker output is
enabled so disable it when that is not in use for a small current saving.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 550bf92..a4570e7 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -796,6 +796,7 @@ SND_SOC_DAPM_SUPPLY("CLK_SYS", WM9081_CLOCK_CONTROL_3, 0, 0, clk_sys_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("CLK_DSP", WM9081_CLOCK_CONTROL_3, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("TOCLK", WM9081_CLOCK_CONTROL_3, 2, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("TSENSE", WM9081_POWER_MANAGEMENT, 7, 0, NULL, 0),
 };
 
 
@@ -818,6 +819,7 @@ static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 	{ "Speaker PGA", NULL, "CLK_SYS" },
 
 	{ "Speaker", NULL, "Speaker PGA" },
+	{ "Speaker", NULL, "TSENSE" },
 
 	{ "SPKN", NULL, "Speaker" },
 	{ "SPKP", NULL, "Speaker" },
-- 
1.7.7.1
