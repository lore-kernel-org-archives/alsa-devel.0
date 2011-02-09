From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Fix WM8903 DAC mute default
Date: Wed,  9 Feb 2011 17:42:57 +0000
Message-ID: <1297273377-7898-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4DBE24443
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 18:43:14 +0100 (CET)
In-Reply-To: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM8903 register map does not mute the DAC by default at startup
so we need to explicitly do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 4aeb767..0ade99d 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2072,9 +2072,9 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8903_ANALOGUE_OUT3_RIGHT, val);
 
 	/* Enable DAC soft mute by default */
-	val = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
-	val |= WM8903_DAC_MUTEMODE;
-	snd_soc_write(codec, WM8903_DAC_DIGITAL_1, val);
+	snd_soc_update_bits(codec, WM8903_DAC_DIGITAL_1,
+			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE,
+			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE);
 
 	snd_soc_add_controls(codec, wm8903_snd_controls,
 				ARRAY_SIZE(wm8903_snd_controls));
-- 
1.7.2.3
