From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [RFC PATCH 2/4] ASoC: dapm: Add support for a rate
	domain widget
Date: Thu, 11 Oct 2018 17:28:29 +0100
Message-ID: <20181011162831.26351-3-ckeepax@opensource.cirrus.com>
References: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 617832678E9
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 18:28:36 +0200 (CEST)
In-Reply-To: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Some CODECs can support multiple sample rates internally but
frequently groups of functionality will be force to the run on the
same sample rate. For example, perhaps all the DACs are required to
run at a single rate. Utimately, it would be ideal if the sample
rates could be propagated through from the top level DAI links to
these groups of widgets. This should allow more complex use-cases
involving multiple sample rates to be connected and will also allow
detection of errors where blocks with incompatible sample rates
are connected.

A first step in this process is to provide a mechanism that documents
which blocks are tidied together with respect to sample rate and
track when they are in use.  This is acheived by adding a supply
like widget that represents a group of widgets that are bound to a
single sample rate. This domain widget should be connected to all
inputs and outputs to the group of widgets, that way it will power
up whenever anything in that group of widgets does.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-dapm.h | 4 ++++
 sound/soc/soc-dapm.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bd8163f151cb8..c0ef27b2d4b22 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -273,6 +273,9 @@ struct device;
 	.reg = SND_SOC_NOPM, .event = dapm_pinctrl_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
+#define SND_SOC_DAPM_RATE(wname, wreg, wshift, winvert, wops, wpriv) \
+{	.id = snd_soc_dapm_rate, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert) }
 
 
 /* dapm kcontrol types */
@@ -519,6 +522,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
 	snd_soc_dapm_encoder,		/* FW/SW audio encoder component */
 	snd_soc_dapm_decoder,		/* FW/SW audio decoder component */
+	snd_soc_dapm_rate,		/* Rate group */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b3..7e3858d1e81dc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -68,6 +68,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_regulator_supply] = 1,
 	[snd_soc_dapm_pinctrl] = 1,
 	[snd_soc_dapm_clock_supply] = 1,
+	[snd_soc_dapm_rate] = 2,
 	[snd_soc_dapm_supply] = 2,
 	[snd_soc_dapm_micbias] = 3,
 	[snd_soc_dapm_dai_link] = 2,
@@ -115,6 +116,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_dai_out] = 10,
 	[snd_soc_dapm_dai_link] = 11,
 	[snd_soc_dapm_supply] = 12,
+	[snd_soc_dapm_rate] = 12,
 	[snd_soc_dapm_clock_supply] = 13,
 	[snd_soc_dapm_pinctrl] = 13,
 	[snd_soc_dapm_regulator_supply] = 13,
@@ -1912,6 +1914,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 			case snd_soc_dapm_vmid:
 				break;
 			case snd_soc_dapm_supply:
+			case snd_soc_dapm_rate:
 			case snd_soc_dapm_regulator_supply:
 			case snd_soc_dapm_pinctrl:
 			case snd_soc_dapm_clock_supply:
@@ -2326,6 +2329,7 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
+		case snd_soc_dapm_rate:
 		case snd_soc_dapm_regulator_supply:
 		case snd_soc_dapm_pinctrl:
 		case snd_soc_dapm_clock_supply:
@@ -3522,6 +3526,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_supply:
+	case snd_soc_dapm_rate:
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_pinctrl:
 	case snd_soc_dapm_clock_supply:
-- 
2.11.0
