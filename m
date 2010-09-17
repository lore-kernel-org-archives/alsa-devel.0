From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Add virtual output pin
	Detection
Date: Fri, 17 Sep 2010 14:39:01 +0300
Message-ID: <1284723541-21813-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1242A24470
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 13:42:32 +0200 (CEST)
Received: by eye27 with SMTP id 27so1042877eye.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2010 04:42:31 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Purpose of this virtual Detection pin is to keep codec bias on whenever the
GPIO or jack detection features are needed.

Jack detection needs a mic bias so machine drivers can construct a following
route for instance for keeping the path and codec bias on:

"Input Jack" -> "Mic Bias xV" -> "Detection" -> detection block inside codec.

For the GPIO the machine driver can force the pin on with
snd_soc_dapm_force_enable_pin.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
PLL is activated when in SND_SOC_BIAS_PREPARE or _ON so it could be running
but I have a vague impression that it's active only when ADC or DAC is on.
I don't have at the moment possibility to measure it and don't want to move
it to DAPM either before doing some oscilloscope and pop & clicks measurements.
Current consumption anyway doesn't differ between standby and on when there is
no active stream and other widgets are off.
---
 sound/soc/codecs/tlv320aic3x.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7b5f159..6190351 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -605,6 +605,14 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINE1R"),
 	SND_SOC_DAPM_INPUT("LINE2L"),
 	SND_SOC_DAPM_INPUT("LINE2R"),
+
+	/*
+	 * Virtual output pin to detection block inside codec. This can be
+	 * used to keep codec bias on if gpio or detection features are needed.
+	 * Force pin on or construct a path with an input jack and mic bias
+	 * widgets.
+	 */
+	SND_SOC_DAPM_OUTPUT("Detection"),
 };
 
 static const struct snd_soc_dapm_widget aic3007_dapm_widgets[] = {
-- 
1.7.1
