From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure sane WM835x AIF configuration by
	default
Date: Tue,  9 Nov 2010 18:58:00 +0000
Message-ID: <1289329080-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1FDB244C5
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 19:57:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure that whatever ran before us leaves the WM835x with a sane default
audio interface configuration as we do not override the companding,
loopback or tristate settings and do not reset the chip at startup (as it
is a PMIC).

Reported-by: Keiji Mitsuhisa <Keiji.Mitsuhisa@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 4f3e919..7611add 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1586,6 +1586,13 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_set_bits(wm8350, WM8350_ROUT2_VOLUME,
 			WM8350_OUT2_VU | WM8350_OUT2R_MUTE);
 
+	/* Make sure AIF tristating is disabled by default */
+	wm8350_clear_bits(wm8350, WM8350_AI_FORMATING, WM8350_AIF_TRI);
+
+	/* Make sure we've got a sane companding setup too */
+	wm8350_clear_bits(wm8350, WM8350_ADC_DAC_COMP,
+			  WM8350_DAC_COMP | WM8350_LOOPBACK);
+
 	/* Make sure jack detect is disabled to start off with */
 	wm8350_clear_bits(wm8350, WM8350_JACK_DETECT,
 			  WM8350_JDL_ENA | WM8350_JDR_ENA);
-- 
1.7.1
