From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: adau1761: Fix input PGA volume
Date: Wed, 22 Oct 2014 10:51:18 +0200
Message-ID: <1413967878-15145-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-082.synserver.de (smtp-out-082.synserver.de
 [212.40.185.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 034C5261A83
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 10:51:21 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For the input PGA to work correctly the ALC clock needs to be active.
Otherwise volume changes are not applied.

Fixes: dab464b60b2 ("ASoC: Add ADAU1361/ADAU1761 audio CODEC support")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/adau1761.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 5518ebd..91f6028 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -405,6 +405,7 @@ static const struct snd_soc_dapm_widget adau1761_dapm_widgets[] = {
 		2, 0, NULL, 0),
 
 	SND_SOC_DAPM_SUPPLY("Slew Clock", ADAU1761_CLK_ENABLE0, 6, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ALC Clock", ADAU1761_CLK_ENABLE0, 5, 0, NULL, 0),
 
 	SND_SOC_DAPM_SUPPLY_S("Digital Clock 0", 1, ADAU1761_CLK_ENABLE1,
 		0, 0, NULL, 0),
@@ -436,6 +437,9 @@ static const struct snd_soc_dapm_route adau1761_dapm_routes[] = {
 	{ "Right Playback Mixer", NULL, "Slew Clock" },
 	{ "Left Playback Mixer", NULL, "Slew Clock" },
 
+	{ "Left Input Mixer", NULL, "ALC Clock" },
+	{ "Right Input Mixer", NULL, "ALC Clock" },
+
 	{ "Digital Clock 0", NULL, "SYSCLK" },
 	{ "Digital Clock 1", NULL, "SYSCLK" },
 };
-- 
1.8.0
