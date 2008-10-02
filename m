From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5 2.6.27?] ASoC: Set correct name for WM8753
	rec mixer output
Date: Thu,  2 Oct 2008 11:02:30 +0100
Message-ID: <1222941751-3238-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081002100200.GA3025@rakim.wolfsonmicro.main>
	<1222941751-3238-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72DD624515
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 12:02:33 +0200 (CEST)
In-Reply-To: <1222941751-3238-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Sims <openmoko-z@robsims.com>, Jonas Bonn <jonas.bonn@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Rob Sims <openmoko-z@robsims.com>

Rob Sims wrote:

"I can't seem to turn on register 0x17, bit 3 in the sound chip, except
by codec_reg_write; the mixer lacks direct or indirect control.  It
seems there are two names for the output of the rec mixer:
Capture ST Mixer
Playback Mixer

Would the following do the trick?"

I confirm that this solves the audio problems I was having.

Signed-off-by: Jonas Bonn <jonas.bonn@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is a bugfix which could be applied to 2.6.27 - without it the
WM8753 driver will fail to set up some audio paths.

 sound/soc/codecs/wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index b3e1b37..8c4df44 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -583,7 +583,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* out 4 */
 	{"Out4 Mux", "VREF", "VREF"},
-	{"Out4 Mux", "Capture ST", "Capture ST Mixer"},
+	{"Out4 Mux", "Capture ST", "Playback Mixer"},
 	{"Out4 Mux", "LOUT2", "LOUT2"},
 	{"Out 4", NULL, "Out4 Mux"},
 	{"OUT4", NULL, "Out 4"},
@@ -607,7 +607,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	/* Capture Right Mux */
 	{"Capture Right Mux", "PGA", "Right Capture Volume"},
 	{"Capture Right Mux", "Line or RXP-RXN", "Line Right Mux"},
-	{"Capture Right Mux", "Sidetone", "Capture ST Mixer"},
+	{"Capture Right Mux", "Sidetone", "Playback Mixer"},
 
 	/* Mono Capture mixer-mux */
 	{"Capture Right Mixer", "Stereo", "Capture Right Mux"},
-- 
1.5.6.5
