From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Correct line input to line
	output 2 paths
Date: Wed,  1 Feb 2012 23:47:37 +0000
Message-ID: <1328140057-3217-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E211243FA
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 00:47:46 +0100 (CET)
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

The second line output mixer has the controls for the line input bypasses
in the opposite order.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 57514dd2..b08d04c 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -586,8 +586,8 @@ SOC_DAPM_SINGLE("Left Output Switch", WM8993_LINE_MIXER1, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new line2_mix[] = {
-SOC_DAPM_SINGLE("IN1R Switch", WM8993_LINE_MIXER2, 2, 1, 0),
-SOC_DAPM_SINGLE("IN1L Switch", WM8993_LINE_MIXER2, 1, 1, 0),
+SOC_DAPM_SINGLE("IN1L Switch", WM8993_LINE_MIXER2, 2, 1, 0),
+SOC_DAPM_SINGLE("IN1R Switch", WM8993_LINE_MIXER2, 1, 1, 0),
 SOC_DAPM_SINGLE("Output Switch", WM8993_LINE_MIXER2, 0, 1, 0),
 };
 
-- 
1.7.9.rc1
