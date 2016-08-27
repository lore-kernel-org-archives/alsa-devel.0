From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 3/4] ASoC: dapm: Fix kcontrol creation for output driver widget
Date: Sat, 27 Aug 2016 19:28:00 +0800
Message-ID: <20160827112801.31010-4-wens@csie.org>
References: <20160827112801.31010-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160827112801.31010-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit d88429a695a4 ("ASoC: dapm: Add output driver widget") added
the snd_soc_dapm_out_drv ID for the output driver widget, which is
the same as the PGA widget, with a later power sequence number.

Commit 19a2557b76d6 ("ASoC: dapm: Add kcontrol support for PGAs")
then added kcontrol support for PGA widgets, but failed to account
for output driver widgets. Attempts to use kcontrols with output
driver widgets result in silent failures, with the developer having
little idea about what went on.

Add snd_soc_dapm_out_drv to the switch/case block under snd_soc_dapm_pga
in dapm_create_or_share_kcontrol, since they are essentially the same.

Fixes: 19a2557b76d6 ("ASoC: dapm: Add kcontrol support for PGAs")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9be076bc14b5..ed6b707cc7ce 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -823,6 +823,7 @@ static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
 			case snd_soc_dapm_pga:
+			case snd_soc_dapm_out_drv:
 				wname_in_long_name = true;
 				kcname_in_long_name = true;
 				break;
-- 
2.9.3
