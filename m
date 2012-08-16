From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm9712: Make microphone source selectable
Date: Thu, 16 Aug 2012 22:36:04 +0100
Message-ID: <1345152965-14773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08DE7265371
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 23:06:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christop Fritz <chf.fritz@googlemail.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the microphone input source is not selectable as while there is
a DAPM widget it's not connected to anything so it won't be properly
instantiated. Add something more correct for the input structure to get
things going, even though it's not hooked into the rest of the routing
map and so won't actually achieve anything except allowing the relevant
register bits to be written.

Reported-by: Christop Fritz <chf.fritz@googlemail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9712.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 00f4436..f35e3bd 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -270,7 +270,7 @@ SOC_DAPM_ENUM("Route", wm9712_enum[9]);
 
 /* Mic select */
 static const struct snd_kcontrol_new wm9712_mic_src_controls =
-SOC_DAPM_ENUM("Route", wm9712_enum[7]);
+SOC_DAPM_ENUM("Mic Source Select", wm9712_enum[7]);
 
 /* diff select */
 static const struct snd_kcontrol_new wm9712_diff_sel_controls =
@@ -289,7 +289,9 @@ SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
 	&wm9712_capture_selectl_controls),
 SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
 	&wm9712_capture_selectr_controls),
-SND_SOC_DAPM_MUX("Mic Select Source", SND_SOC_NOPM, 0, 0,
+SND_SOC_DAPM_MUX("Left Mic Select Source", SND_SOC_NOPM, 0, 0,
+	&wm9712_mic_src_controls),
+SND_SOC_DAPM_MUX("Right Mic Select Source", SND_SOC_NOPM, 0, 0,
 	&wm9712_mic_src_controls),
 SND_SOC_DAPM_MUX("Differential Source", SND_SOC_NOPM, 0, 0,
 	&wm9712_diff_sel_controls),
@@ -317,6 +319,7 @@ SND_SOC_DAPM_PGA("Out 3 PGA", AC97_INT_PAGING, 5, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Line PGA", AC97_INT_PAGING, 2, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Phone PGA", AC97_INT_PAGING, 1, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Mic PGA", AC97_INT_PAGING, 0, 1, NULL, 0),
+SND_SOC_DAPM_PGA("Differential Mic", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MICBIAS("Mic Bias", AC97_INT_PAGING, 10, 1),
 SND_SOC_DAPM_OUTPUT("MONOOUT"),
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
@@ -377,6 +380,18 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 	{"Mic PGA", NULL, "MIC1"},
 	{"Mic PGA", NULL, "MIC2"},
 
+	/* microphones */
+	{"Differential Mic", NULL, "MIC1"},
+	{"Differential Mic", NULL, "MIC2"},
+	{"Left Mic Select Source", "Mic 1", "MIC1"},
+	{"Left Mic Select Source", "Mic 2", "MIC2"},
+	{"Left Mic Select Source", "Stereo", "MIC1"},
+	{"Left Mic Select Source", "Differential", "Differential Mic"},
+	{"Right Mic Select Source", "Mic 1", "MIC1"},
+	{"Right Mic Select Source", "Mic 2", "MIC2"},
+	{"Right Mic Select Source", "Stereo", "MIC2"},
+	{"Right Mic Select Source", "Differential", "Differential Mic"},
+
 	/* left capture selector */
 	{"Left Capture Select", "Mic", "MIC1"},
 	{"Left Capture Select", "Speaker Mixer", "Speaker Mixer"},
-- 
1.7.9.1
