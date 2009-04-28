From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/17] ASoC: Fix logic in WM8350 master
	clocking check
Date: Tue, 28 Apr 2009 16:23:37 +0100
Message-ID: <1240932222-3718-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 610A4103892
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:46 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
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

We need to check only if the WM8350 is master and only when starting
the stream so if either is not true then we can skip the check.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3b1d099..0275321 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -968,7 +968,7 @@ static int wm8350_pcm_trigger(struct snd_pcm_substream *substream,
 	 * required for LRC in master mode. The DACs or ADCs need a
 	 * valid audio path i.e. pin -> ADC or DAC -> pin before
 	 * the LRC will be enabled in master mode. */
-	if (!master && cmd != SNDRV_PCM_TRIGGER_START)
+	if (!master || cmd != SNDRV_PCM_TRIGGER_START)
 		return 0;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-- 
1.6.2.4
