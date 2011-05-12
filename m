From: jinyoungp@nvidia.com
Subject: [PATCH 2/3] ASoC: codecs: max98088: Moved the EX
	Limiter Mode from dapm widget to control
Date: Thu, 12 May 2011 14:58:37 +0900
Message-ID: <1305179918-19317-3-git-send-email-jinyoungp@nvidia.com>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D80C2446E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 07:59:06 +0200 (CEST)
In-Reply-To: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, Jin Park <jinyoungp@nvidia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jin Park <jinyoungp@nvidia.com>

Moved the EX Limiter Mode from dapm widget to control, because it was not
required DAPM route.

Signed-off-by: Jin Park <jinyoungp@nvidia.com>
---
 sound/soc/codecs/max98088.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 3bdaa04..c520093 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -656,8 +656,6 @@ static const struct soc_enum max98088_exmode_enum =
                              ARRAY_SIZE(max98088_exmode_texts),
                              max98088_exmode_texts,
                              max98088_exmode_values);
-static const struct snd_kcontrol_new max98088_exmode_controls =
-       SOC_DAPM_VALUE_ENUM("Route", max98088_exmode_enum);
 
 static const char *max98088_ex_thresh[] = { /* volts PP */
        "0.6", "1.2", "1.8", "2.4", "3.0", "3.6", "4.2", "4.8"};
@@ -783,6 +781,7 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
        SOC_SINGLE("EQ1 Switch", M98088_REG_49_CFG_LEVEL, 0, 1, 0),
        SOC_SINGLE("EQ2 Switch", M98088_REG_49_CFG_LEVEL, 1, 1, 0),
 
+       SOC_ENUM("EX Limiter Mode", max98088_exmode_enum),
        SOC_ENUM("EX Limiter Threshold", max98088_ex_thresh_enum),
 
        SOC_ENUM("DAI1 Filter Mode", max98088_filter_mode_enum),
@@ -1094,9 +1093,6 @@ static const struct snd_soc_dapm_widget max98088_dapm_widgets[] = {
 
        SND_SOC_DAPM_MICBIAS("MICBIAS", M98088_REG_4C_PWR_EN_IN, 3, 0),
 
-       SND_SOC_DAPM_MUX("EX Limiter Mode", SND_SOC_NOPM, 0, 0,
-               &max98088_exmode_controls),
-
        SND_SOC_DAPM_OUTPUT("HPL"),
        SND_SOC_DAPM_OUTPUT("HPR"),
        SND_SOC_DAPM_OUTPUT("SPKL"),
-- 
1.7.1


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
