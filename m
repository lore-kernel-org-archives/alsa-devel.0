From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: SOF: remove redundant null checks of dai
Date: Thu,  2 May 2019 12:33:40 +0100
Message-ID: <20190502113340.8688-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently there are two null checks of pointer dai in function
sof_connect_dai_widget and yet there is no null check of dai
at the end of the function when checking !dai->name.  The latter
would be a null pointer deference if dai is null (as picked up
by static analysis), however the function is only ever called
when dai is successfully allocated, so the null checks are
redundant. Clean up the code by removing the null checks.

Addresses-Coverity: ("Dereference after null check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sof/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 2b9de1b97447..1f71857298a9 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1127,15 +1127,13 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 		switch (w->id) {
 		case snd_soc_dapm_dai_out:
 			rtd->cpu_dai->capture_widget = w;
-			if (dai)
-				dai->name = rtd->dai_link->name;
+			dai->name = rtd->dai_link->name;
 			dev_dbg(sdev->dev, "tplg: connected widget %s -> DAI link %s\n",
 				w->name, rtd->dai_link->name);
 			break;
 		case snd_soc_dapm_dai_in:
 			rtd->cpu_dai->playback_widget = w;
-			if (dai)
-				dai->name = rtd->dai_link->name;
+			dai->name = rtd->dai_link->name;
 			dev_dbg(sdev->dev, "tplg: connected widget %s -> DAI link %s\n",
 				w->name, rtd->dai_link->name);
 			break;
-- 
2.20.1
