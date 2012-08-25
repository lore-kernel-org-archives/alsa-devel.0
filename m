From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Add dummy widget for CLKIN
Date: Sat, 25 Aug 2012 09:18:45 -0700
Message-ID: <1345911525-24448-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C98C9265D90
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2012 18:18:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Make it easier to integrate the management of the clock supplying the
WM0010 with DAPM by providing a dummy supply widget which supplies the
interface widgets, this can be connected to clock outputs by the machines.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f820b57..b6f7097 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -118,9 +118,18 @@ struct wm0010_spi_msg {
 	size_t len;
 };
 
+static const struct snd_soc_dapm_widget wm0010_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("CLKIN",  SND_SOC_NOPM, 0, 0, NULL, 0),
+};
+
 static const struct snd_soc_dapm_route wm0010_dapm_routes[] = {
 	{ "SDI2 Capture", NULL, "SDI1 Playback" },
 	{ "SDI1 Capture", NULL, "SDI2 Playback" },
+
+	{ "SDI1 Capture", NULL, "CLKIN" },
+	{ "SDI2 Capture", NULL, "CLKIN" },
+	{ "SDI1 Playback", NULL, "CLKIN" },
+	{ "SDI2 Playback", NULL, "CLKIN" },
 };
 
 static const char *wm0010_state_to_str(enum wm0010_state state)
@@ -718,6 +727,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm0010 = {
 	.set_bias_level = wm0010_set_bias_level,
 	.set_sysclk = wm0010_set_sysclk,
 
+	.dapm_widgets = wm0010_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm0010_dapm_widgets),
 	.dapm_routes = wm0010_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(wm0010_dapm_routes),
 };
-- 
1.7.10.4
