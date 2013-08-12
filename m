From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: wm5102: Add inputs for noise and mic
	mixers
Date: Mon, 12 Aug 2013 23:59:48 +0100
Message-ID: <1376348390-6550-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A695A2650B3
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 00:59:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The noise and mic mixer inputs were not connected, do so.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm5102.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index f38c52d..8bbddc1 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1423,9 +1423,6 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "Tone Generator 1", NULL, "TONE" },
 	{ "Tone Generator 2", NULL, "TONE" },
 
-	{ "Mic Mute Mixer", NULL, "Noise Mixer" },
-	{ "Mic Mute Mixer", NULL, "Mic Mixer" },
-
 	{ "AIF1 Capture", NULL, "AIF1TX1" },
 	{ "AIF1 Capture", NULL, "AIF1TX2" },
 	{ "AIF1 Capture", NULL, "AIF1TX3" },
@@ -1552,6 +1549,9 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("LHPF3", "LHPF3"),
 	ARIZONA_MIXER_ROUTES("LHPF4", "LHPF4"),
 
+	ARIZONA_MIXER_ROUTES("Mic Mute Mixer", "Noise"),
+	ARIZONA_MIXER_ROUTES("Mic Mute Mixer", "Mic"),
+
 	ARIZONA_MUX_ROUTES("ASRC1L", "ASRC1L"),
 	ARIZONA_MUX_ROUTES("ASRC1R", "ASRC1R"),
 	ARIZONA_MUX_ROUTES("ASRC2L", "ASRC2L"),
-- 
1.8.4.rc1
