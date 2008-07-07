From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Dump DAPM state for non-stream
	changes
Date: Mon,  7 Jul 2008 19:26:04 +0100
Message-ID: <1215455164-29019-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1215455164-29019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15D34246A3
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 20:26:07 +0200 (CEST)
In-Reply-To: <1215455164-29019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Explicit DAPM syncs are likely to cause DAPM state updates, as are mixer
and mux configuration changes, so display the DAPM status after them too.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d18ebc6..2c87061 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -717,8 +717,10 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 			path->connect = 0; /* old connection must be powered down */
 	}
 
-	if (found)
+	if (found) {
 		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dump_dapm(widget->codec, "mux power update");
+	}
 
 	return 0;
 }
@@ -754,8 +756,10 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		break;
 	}
 
-	if (found)
+	if (found) {
 		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dump_dapm(widget->codec, "mixer power update");
+	}
 
 	return 0;
 }
@@ -906,7 +910,9 @@ static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
  */
 int snd_soc_dapm_sync(struct snd_soc_codec *codec)
 {
-	return dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	int ret = dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	dump_dapm(codec, "sync");
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
-- 
1.5.6
