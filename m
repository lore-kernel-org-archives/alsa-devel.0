From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: Work around warnings from some build
	environments
Date: Wed, 10 Dec 2008 20:01:08 +0000
Message-ID: <1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EED4F243BC
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:16 +0100 (CET)
In-Reply-To: <20081210195858.GA4062@rakim.wolfsonmicro.main>
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

BUG() should be marked as not returning but for at least some
configurations (including some widely deployed compilers) that's either
not happening or being forgotten by the compiler.  Add some extra return
statements to the affected paths.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 0b5bea3..b1f5cf7 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -392,6 +392,7 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		BUG();
+		return -EINVAL;  /* Spurious warning from some compilers */
 	}
 
 	switch (w->shift) {
@@ -403,6 +404,7 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		BUG();
+		return -EINVAL;  /* Spurious warning from some compilers */
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMU) {
-- 
1.5.6.5
