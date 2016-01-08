From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: wm8960: boost switch should be closed
	when using L/RINPUT1
Date: Fri, 8 Jan 2016 16:57:02 +0800
Message-ID: <89e05efb7792deb496f216ed9e086e9c10053ba8.1452243310.git.zidan.wang@freescale.com>
References: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D29D2658CB
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 09:54:39 +0100 (CET)
In-Reply-To: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

L/RINPUT1 can line to Left/Right Boost Mixer through boost switch.
If boost switch is open, there will be no voice when using L/RINPUT1.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 029031b..ff23772 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -413,8 +413,8 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Left Boost Mixer", "LINPUT2 Switch", "LINPUT2" },
 	{ "Left Boost Mixer", "LINPUT3 Switch", "LINPUT3" },
 
-	{ "Left Input Mixer", "Boost Switch", "Left Boost Mixer", },
-	{ "Left Input Mixer", NULL, "LINPUT1", },  /* Really Boost Switch */
+	{ "Left Input Mixer", "Boost Switch", "Left Boost Mixer" },
+	{ "Left Input Mixer", "Boost Switch", "LINPUT1" },  /* Really Boost Switch */
 	{ "Left Input Mixer", NULL, "LINPUT2" },
 	{ "Left Input Mixer", NULL, "LINPUT3" },
 
@@ -422,8 +422,8 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Right Boost Mixer", "RINPUT2 Switch", "RINPUT2" },
 	{ "Right Boost Mixer", "RINPUT3 Switch", "RINPUT3" },
 
-	{ "Right Input Mixer", "Boost Switch", "Right Boost Mixer", },
-	{ "Right Input Mixer", NULL, "RINPUT1", },  /* Really Boost Switch */
+	{ "Right Input Mixer", "Boost Switch", "Right Boost Mixer" },
+	{ "Right Input Mixer", "Boost Switch", "RINPUT1" },  /* Really Boost Switch */
 	{ "Right Input Mixer", NULL, "RINPUT2" },
 	{ "Right Input Mixer", NULL, "RINPUT3" },
 
@@ -431,11 +431,11 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Right ADC", NULL, "Right Input Mixer" },
 
 	{ "Left Output Mixer", "LINPUT3 Switch", "LINPUT3" },
-	{ "Left Output Mixer", "Boost Bypass Switch", "Left Boost Mixer"} ,
+	{ "Left Output Mixer", "Boost Bypass Switch", "Left Boost Mixer" },
 	{ "Left Output Mixer", "PCM Playback Switch", "Left DAC" },
 
 	{ "Right Output Mixer", "RINPUT3 Switch", "RINPUT3" },
-	{ "Right Output Mixer", "Boost Bypass Switch", "Right Boost Mixer" } ,
+	{ "Right Output Mixer", "Boost Bypass Switch", "Right Boost Mixer" },
 	{ "Right Output Mixer", "PCM Playback Switch", "Right DAC" },
 
 	{ "LOUT1 PGA", NULL, "Left Output Mixer" },
-- 
1.9.1
