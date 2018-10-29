From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Rename output widgets
Date: Mon, 29 Oct 2018 09:59:13 +0100
Message-ID: <20181029085913.17298-2-kmarinushkin@birdec.tech>
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5B82677D1
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2018 09:57:54 +0100 (CET)
In-Reply-To: <20181029085913.17298-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

In the initial commit [1], I added differential outputs of the codec as
separate `+` and `-` widgets:

OUTL+
OUTR+
OUTL-
OUTR-

Later, in the commit [2], I added a control to switch the outputs between
differential and single-ended modes. Having this control, the `+` and `-`
separation in widgets seems for me confusing. There are no functional
benefits in such separation, so I find reasonable to get rid of it:

OUTL
OUTR

The new naming is more friendly for sound cards, and is better aligned with
other codec drivers in kernel.

Renaming outputs now should not be a problem from the backwards-
compatibility perspective, as the driver for PCM3060 is added into the
mainline very recently, and did not yet appear in any releases.

[1] commit 6ee47d4a8dac ("ASoC: pcm3060: Add codec driver")
[2] commit c33260d09337 ("ASoC: pcm3060: Add control for differential
    output")

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index f792ad637ae4..078a3b1fc064 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -207,20 +207,16 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
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
