From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tpa6130a2: Define output pins with
	SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 13:55:26 +0300
Message-ID: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com
	[209.85.219.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D4FD24615
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 12:55:31 +0200 (CEST)
Received: by ewy9 with SMTP id 9so2154810ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 03:55:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
external widgets doesn't alter the output state.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
I noticed this with a widget and audio map below where state of
"Headphone Jack" wasn't changing the codec output.

SND_SOC_DAPM_HP("Headphone Jack", NULL),

{"Headphone Jack", NULL, "TPA6130A2 Headphone Left"},
{"Headphone Jack", NULL, "TPA6130A2 Headphone Right"},
{"TPA6130A2 Left", NULL, "LLOUT"},
{"TPA6130A2 Right", NULL, "RLOUT"}
---
 sound/soc/codecs/tpa6130a2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 100a747..99b70e5 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -359,8 +359,8 @@ static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
 			0, 0, tpa6130a2_supply_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* Outputs */
-	SND_SOC_DAPM_HP("TPA6130A2 Headphone Left", NULL),
-	SND_SOC_DAPM_HP("TPA6130A2 Headphone Right", NULL),
+	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Left"),
+	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Right"),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
-- 
1.7.1
