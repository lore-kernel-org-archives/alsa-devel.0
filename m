From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH v2 3/3] ASoC: pcm3060: Rename output widgets
Date: Mon, 12 Nov 2018 08:08:34 +0100
Message-ID: <20181112070834.16979-3-kmarinushkin@birdec.tech>
References: <20181105112036.GC5365@sirena.org.uk>
 <20181112070834.16979-1-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112070834.16979-1-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

In the initial commit [1], I added differential output of the codec as
separate `+` and `-` widgets:

OUTL+
OUTR+
OUTL-
OUTR-

Later, in the commit [2], I added a device tree property to configure the
output as single-ended or differential. Having this property, the `+` and
`-` separation in widgets seems for me confusing. There are no functional
benefits in such separation, so I find reasonable to get rid of it:

OUTL
OUTR

The new naming is more friendly for sound cards, and is better aligned with
other codec drivers in kernel.

Renaming the output widgets now should not be a problem from the backwards-
compatibility perspective, as the driver for PCM3060 is added into the
mainline very recently, and did not yet appear in any releases.

[1] commit 6ee47d4a8dac ("ASoC: pcm3060: Add codec driver")
[2] commit a78c62de00d5 ("ASoC: pcm3060: Add DT property for single-ended
    output")

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 5f479aa61097..1dd851a7b43b 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,20 +198,16 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("OUTL+"),
-	SND_SOC_DAPM_OUTPUT("OUTR+"),
-	SND_SOC_DAPM_OUTPUT("OUTL-"),
-	SND_SOC_DAPM_OUTPUT("OUTR-"),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL+", NULL, "Playback" },
-	{ "OUTR+", NULL, "Playback" },
-	{ "OUTL-", NULL, "Playback" },
-	{ "OUTR-", NULL, "Playback" },
+	{ "OUTL", NULL, "Playback" },
+	{ "OUTR", NULL, "Playback" },
 
 	{ "Capture", NULL, "INL" },
 	{ "Capture", NULL, "INR" },
-- 
2.13.6
