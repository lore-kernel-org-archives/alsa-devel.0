From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: OMAP3 Pandora: update for TWL4030 codec
	changes
Date: Sat,  7 Nov 2009 23:16:12 +0200
Message-ID: <1257628572-6049-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C5EA246E0
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 22:16:16 +0100 (CET)
Received: by bwz9 with SMTP id 9so7859026bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 13:16:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

A while ago TWL4030 had it's playback stream name changed, but
pandora needs it for it's playback path. Update to correct stream
name so that playback works again.

Also mark VIBRA output as not connected.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index ad219aa..0cd06f5 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -134,7 +134,7 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
  *  |P| <--- TWL4030 <--------- Line In and MICs
  */
 static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("PCM DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("PCM DAC", "HiFi Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
 			   0, 0, NULL, 0, omap3pandora_hp_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -181,6 +181,7 @@ static int omap3pandora_out_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "CARKITR");
 	snd_soc_dapm_nc_pin(codec, "HFL");
 	snd_soc_dapm_nc_pin(codec, "HFR");
+	snd_soc_dapm_nc_pin(codec, "VIBRA");
 
 	ret = snd_soc_dapm_new_controls(codec, omap3pandora_out_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_out_dapm_widgets));
-- 
1.5.6.3
