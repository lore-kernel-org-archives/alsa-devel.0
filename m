From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: dapm: Add snd_soc_dapm_switch to the power up/down sequence table
Date: Fri, 14 Jun 2013 13:16:50 +0200
Message-ID: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The power up/down sequence order for DAPM switch widgets is not explicitly
initialized, causing them to be run always as the first widget type for both
power up and down. Move it to the same position in the sequence as other mixer
widget types.

Cc: stable@vger.kernel.org
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2201f22..10290c7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -64,6 +64,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_virt_mux] = 5,
 	[snd_soc_dapm_value_mux] = 5,
 	[snd_soc_dapm_dac] = 6,
+	[snd_soc_dapm_switch] = 7,
 	[snd_soc_dapm_mixer] = 7,
 	[snd_soc_dapm_mixer_named_ctl] = 7,
 	[snd_soc_dapm_pga] = 8,
@@ -83,6 +84,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_line] = 2,
 	[snd_soc_dapm_out_drv] = 2,
 	[snd_soc_dapm_pga] = 4,
+	[snd_soc_dapm_switch] = 5,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
 	[snd_soc_dapm_mixer] = 5,
 	[snd_soc_dapm_dac] = 6,
-- 
1.8.0
