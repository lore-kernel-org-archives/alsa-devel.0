From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add TLV information for WM8978 DAC
	limiter
Date: Wed,  2 Mar 2011 11:04:45 +0000
Message-ID: <1299063885-27125-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299063885-27125-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA0231037F5
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 12:04:25 +0100 (CET)
In-Reply-To: <1299063885-27125-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 7ce4f49..85e3e63 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -93,6 +93,7 @@ static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -1200, 75, 0);
 static const DECLARE_TLV_DB_SCALE(spk_tlv, -5700, 100, 0);
 static const DECLARE_TLV_DB_SCALE(boost_tlv, -1500, 300, 1);
+static const DECLARE_TLV_DB_SCALE(limiter_tlv, 0, 100, 0);
 
 static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 
@@ -144,8 +145,8 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 
 	SOC_SINGLE("DAC Playback Limiter Threshold",
 		WM8978_DAC_LIMITER_2, 4, 7, 0),
-	SOC_SINGLE("DAC Playback Limiter Boost",
-		WM8978_DAC_LIMITER_2, 0, 12, 0),
+	SOC_SINGLE_TLV("DAC Playback Limiter Volume",
+		WM8978_DAC_LIMITER_2, 0, 12, 0, limiter_tlv),
 
 	SOC_ENUM("ALC Enable Switch", alc1),
 	SOC_SINGLE("ALC Capture Min Gain", WM8978_ALC_CONTROL_1, 0, 7, 0),
-- 
1.7.2.3
