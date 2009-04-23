From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/21] ASoC: Actively manage the DC servo for
	WM8903
Date: Thu, 23 Apr 2009 20:55:46 +0100
Message-ID: <1240516555-22249-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C17C1038AF
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

Save a little extra power by enabling the DC servo offset correction
for the output channels only when the relevant channels are enabled.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index de0a585..0bab5c6 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -392,14 +392,18 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	u16 val;
 	u16 reg;
+	u16 dcs_reg;
+	u16 dcs_bit;
 	int shift;
 
 	switch (w->reg) {
 	case WM8903_POWER_MANAGEMENT_2:
 		reg = WM8903_ANALOGUE_HP_0;
+		dcs_bit = 0 + w->shift;
 		break;
 	case WM8903_POWER_MANAGEMENT_3:
 		reg = WM8903_ANALOGUE_LINEOUT_0;
+		dcs_bit = 2 + w->shift;
 		break;
 	default:
 		BUG();
@@ -439,6 +443,11 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		val |= (WM8903_OUTPUT_OUT << shift);
 		wm8903_write(codec, reg, val);
 
+		/* Enable the DC servo */
+		dcs_reg = wm8903_read(codec, WM8903_DC_SERVO_0);
+		dcs_reg |= dcs_bit;
+		wm8903_write(codec, WM8903_DC_SERVO_0, dcs_reg);
+
 		/* Remove the short */
 		val |= (WM8903_OUTPUT_SHORT << shift);
 		wm8903_write(codec, reg, val);
@@ -451,6 +460,11 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		val &= ~(WM8903_OUTPUT_SHORT << shift);
 		wm8903_write(codec, reg, val);
 
+		/* Disable the DC servo */
+		dcs_reg = wm8903_read(codec, WM8903_DC_SERVO_0);
+		dcs_reg &= ~dcs_bit;
+		wm8903_write(codec, WM8903_DC_SERVO_0, dcs_reg);
+
 		/* Then disable the intermediate and output stages */
 		val &= ~((WM8903_OUTPUT_OUT | WM8903_OUTPUT_INT |
 			  WM8903_OUTPUT_IN) << shift);
-- 
1.5.6.3
