From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: TWL4030: Correct bypass event for voice
	sidetone
Date: Mon, 22 Jun 2009 19:34:07 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3555FB1F@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 2127E24395
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 02:34:16 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Event for voice sidetone was being interpreted as an
analog HiFi bypass event because VSTPGA register offset
is less than ARXR2_APGA_CTL offset. Reordering the
register checks allows to handle voice digital bypass
event properly.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f916a9a..df42fa2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -712,7 +712,19 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 
 	reg = twl4030_read_reg_cache(w->codec, m->reg);
 
-	if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
+	/*
+	 * bypass_state[0:3] - analog HiFi bypass
+	 * bypass_state[4]   - analog voice bypass
+	 * bypass_state[5]   - digital voice bypass
+	 * bypass_state[6:7] - digital HiFi bypass
+	 */
+	if (m->reg == TWL4030_REG_VSTPGA) {
+		/* Voice digital bypass */
+		if (reg)
+			twl4030->bypass_state |= (1 << 5);
+		else
+			twl4030->bypass_state &= ~(1 << 5);
+	} else if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
 		/* Analog bypass */
 		if (reg & (1 << m->shift))
 			twl4030->bypass_state |=
@@ -726,12 +738,6 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 			twl4030->bypass_state |= (1 << 4);
 		else
 			twl4030->bypass_state &= ~(1 << 4);
-	} else if (m->reg == TWL4030_REG_VSTPGA) {
-		/* Voice digital bypass */
-		if (reg)
-			twl4030->bypass_state |= (1 << 5);
-		else
-			twl4030->bypass_state &= ~(1 << 5);
 	} else {
 		/* Digital bypass */
 		if (reg & (0x7 << m->shift))
-- 
1.5.4.3
