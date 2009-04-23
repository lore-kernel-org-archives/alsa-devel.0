From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/21] ASoC: Optimise configuration of WM8903
	DC servo
Date: Thu, 23 Apr 2009 20:55:45 +0100
Message-ID: <1240516555-22249-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD3810389E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:06 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
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

Modify the default startup sequence in the chip to set the DC servo
dither level for optimal performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 27c8b94..de0a585 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -978,6 +978,11 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 			wm8903_write(codec, WM8903_CLOCK_RATES_2,
 				     WM8903_CLK_SYS_ENA);
 
+			/* Change DC servo dither level in startup sequence */
+			wm8903_write(codec, WM8903_WRITE_SEQUENCER_0, 0x11);
+			wm8903_write(codec, WM8903_WRITE_SEQUENCER_1, 0x1257);
+			wm8903_write(codec, WM8903_WRITE_SEQUENCER_2, 0x2);
+
 			wm8903_run_sequence(codec, 0);
 			wm8903_sync_reg_cache(codec, codec->reg_cache);
 
-- 
1.5.6.3
