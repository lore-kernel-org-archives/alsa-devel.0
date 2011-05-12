From: jinyoungp@nvidia.com
Subject: [PATCH 1/3] ASoC: codecs: max98088: Fixed invalid
	register definitions in mixer controls
Date: Thu, 12 May 2011 14:58:36 +0900
Message-ID: <1305179918-19317-2-git-send-email-jinyoungp@nvidia.com>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 660772446E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 07:59:04 +0200 (CEST)
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

Fixed invalid register definitions in mixer controls such as left
speaker mixer, left hp mixer and left rec mixer.

Signed-off-by: Jin Park <jinyoungp@nvidia.com>
---
 sound/soc/codecs/max98088.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 89498f9..3bdaa04 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -808,10 +808,10 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
 
 /* Left speaker mixer switch */
 static const struct snd_kcontrol_new max98088_left_speaker_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_2B_MIX_SPK_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_2B_MIX_SPK_LEFT, 1, 1, 0),
@@ -836,10 +836,10 @@ static const struct snd_kcontrol_new max98088_right_speaker_mixer_controls[] = {
 
 /* Left headphone mixer switch */
 static const struct snd_kcontrol_new max98088_left_hp_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_25_MIX_HP_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_25_MIX_HP_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_25_MIX_HP_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_25_MIX_HP_LEFT, 1, 1, 0),
@@ -864,10 +864,10 @@ static const struct snd_kcontrol_new max98088_right_hp_mixer_controls[] = {
 
 /* Left earpiece/receiver mixer switch */
 static const struct snd_kcontrol_new max98088_left_rec_mixer_controls[] = {
-       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
-       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
-       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC1 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
+       SOC_DAPM_SINGLE("Left DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 0, 1, 0),
+       SOC_DAPM_SINGLE("Right DAC2 Switch", M98088_REG_28_MIX_REC_LEFT, 7, 1, 0),
        SOC_DAPM_SINGLE("MIC1 Switch", M98088_REG_28_MIX_REC_LEFT, 5, 1, 0),
        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_28_MIX_REC_LEFT, 6, 1, 0),
        SOC_DAPM_SINGLE("INA1 Switch", M98088_REG_28_MIX_REC_LEFT, 1, 1, 0),
-- 
1.7.1


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
