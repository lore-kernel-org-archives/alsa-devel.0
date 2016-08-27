From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4/4] ASoC: dapm: Give error when adding hardware backed controls for PGA widgets
Date: Sat, 27 Aug 2016 19:28:01 +0800
Message-ID: <20160827112801.31010-5-wens@csie.org>
References: <20160827112801.31010-1-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160827112801.31010-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 19a2557b76d6 ("ASoC: dapm: Add kcontrol support for PGAs") added
kcontrol support for PGA widgets, but did not add necessary changes to
snd_soc_dapm_put_volsw or soc_dapm_mixer_update_power to have hardware
register updates actually happen.

As this is a little used feature, this patch just adds an error message
when someone tries to use hardware backed controls with PGA or output
driver widgets.

Fixes: 19a2557b76d6 ("ASoC: dapm: Add kcontrol support for PGAs")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/soc-dapm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ed6b707cc7ce..f681a251d766 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -984,6 +984,14 @@ static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 	int i, ret;
 
 	for (i = 0; i < w->num_kcontrols; i++) {
+		const struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)w->kcontrol_news[i].private_value;
+
+		if (mc->reg != SND_SOC_NOPM)
+			dev_err(w->dapm->dev,
+				"ASoC: hardware backed PGA controls not supported: '%s'\n",
+				w->name);
+
 		ret = dapm_create_or_share_kcontrol(w, i);
 		if (ret < 0)
 			return ret;
-- 
2.9.3
