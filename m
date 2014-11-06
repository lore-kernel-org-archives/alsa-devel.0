From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: ssm4567: Add support for disabling
	the boost stage
Date: Thu,  6 Nov 2014 15:59:24 +0100
Message-ID: <1415285964-15930-3-git-send-email-lars@metafoo.de>
References: <1415285964-15930-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-022.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id F10BB2614A1
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 15:59:27 +0100 (CET)
In-Reply-To: <1415285964-15930-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a switch to enable/disable boost stage of the output
amplifier. Applications that know that they do not need the output
amplifier boost stage can disable it to conserve a bit of power.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm4567.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 2176679..a984485 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -165,13 +165,20 @@ static const struct snd_kcontrol_new ssm4567_snd_controls[] = {
 		5, 1, 0),
 };
 
+static const struct snd_kcontrol_new ssm4567_amplifier_boost_control =
+	SOC_DAPM_SINGLE("Switch", SSM4567_REG_POWER_CTRL, 1, 1, 1);
+
 static const struct snd_soc_dapm_widget ssm4567_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM4567_REG_POWER_CTRL, 2, 1),
+	SND_SOC_DAPM_SWITCH("Amplifier Boost", SSM4567_REG_POWER_CTRL, 3, 1,
+		&ssm4567_amplifier_boost_control),
 
 	SND_SOC_DAPM_OUTPUT("OUT"),
 };
 
 static const struct snd_soc_dapm_route ssm4567_routes[] = {
+	{ "OUT", NULL, "Amplifier Boost" },
+	{ "Amplifier Boost", "Switch", "DAC" },
 	{ "OUT", NULL, "DAC" },
 };
 
-- 
1.8.0
