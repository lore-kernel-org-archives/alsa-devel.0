From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Fix WM8903 right mixer bypass path
Date: Wed,  3 Dec 2008 13:24:53 +0000
Message-ID: <1228310694-6082-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081203132005.GA5943@rakim.wolfsonmicro.main>
	<1228310694-6082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228310694-6082-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEDF71037F5
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 14:24:56 +0100 (CET)
In-Reply-To: <1228310694-6082-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 393a4c1..3c83b79 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -773,14 +773,14 @@ static const struct snd_kcontrol_new left_output_mixer[] = {
 SOC_DAPM_SINGLE("DACL Switch", WM8903_ANALOGUE_LEFT_MIX_0, 3, 1, 0),
 SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_LEFT_MIX_0, 2, 1, 0),
 SOC_DAPM_SINGLE_W("Left Bypass Switch", WM8903_ANALOGUE_LEFT_MIX_0, 1, 1, 0),
-SOC_DAPM_SINGLE_W("Right Bypass Switch", WM8903_ANALOGUE_LEFT_MIX_0, 1, 1, 0),
+SOC_DAPM_SINGLE_W("Right Bypass Switch", WM8903_ANALOGUE_LEFT_MIX_0, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new right_output_mixer[] = {
 SOC_DAPM_SINGLE("DACL Switch", WM8903_ANALOGUE_RIGHT_MIX_0, 3, 1, 0),
 SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_RIGHT_MIX_0, 2, 1, 0),
 SOC_DAPM_SINGLE_W("Left Bypass Switch", WM8903_ANALOGUE_RIGHT_MIX_0, 1, 1, 0),
-SOC_DAPM_SINGLE_W("Right Bypass Switch", WM8903_ANALOGUE_RIGHT_MIX_0, 1, 1, 0),
+SOC_DAPM_SINGLE_W("Right Bypass Switch", WM8903_ANALOGUE_RIGHT_MIX_0, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new left_speaker_mixer[] = {
@@ -788,7 +788,7 @@ SOC_DAPM_SINGLE("DACL Switch", WM8903_ANALOGUE_SPK_MIX_LEFT_0, 3, 1, 0),
 SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_SPK_MIX_LEFT_0, 2, 1, 0),
 SOC_DAPM_SINGLE("Left Bypass Switch", WM8903_ANALOGUE_SPK_MIX_LEFT_0, 1, 1, 0),
 SOC_DAPM_SINGLE("Right Bypass Switch", WM8903_ANALOGUE_SPK_MIX_LEFT_0,
-		1, 1, 0),
+		0, 1, 0),
 };
 
 static const struct snd_kcontrol_new right_speaker_mixer[] = {
@@ -797,7 +797,7 @@ SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_SPK_MIX_RIGHT_0, 2, 1, 0),
 SOC_DAPM_SINGLE("Left Bypass Switch", WM8903_ANALOGUE_SPK_MIX_RIGHT_0,
 		1, 1, 0),
 SOC_DAPM_SINGLE("Right Bypass Switch", WM8903_ANALOGUE_SPK_MIX_RIGHT_0,
-		1, 1, 0),
+		0, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget wm8903_dapm_widgets[] = {
-- 
1.5.6.5
