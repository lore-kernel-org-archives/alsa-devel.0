From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: rx51: Correct DAPM route for capture
Date: Fri, 30 Jan 2015 09:32:43 +0200
Message-ID: <1422603163-13346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BEE8260677
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 08:32:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

"Mic Bias" is DAPM_SUPPLY so it has to be connected in the route
accordingly.
Fixes audio capture on the board.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
---
 sound/soc/omap/rx51.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 04896d6252a2..7f299357c2d2 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"FM Transmitter", NULL, "LLOUT"},
 	{"FM Transmitter", NULL, "RLOUT"},
 
-	{"DMic Rate 64", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "DMic"},
+	{"DMic Rate 64", NULL, "DMic"},
+	{"DMic", NULL, "Mic Bias"},
 
 	{"b LINE2R", NULL, "MONO_LOUT"},
 	{"Earphone", NULL, "b HPLOUT"},
 
-	{"LINE1L", NULL, "b Mic Bias"},
-	{"b Mic Bias", NULL, "HS Mic"}
+	{"LINE1L", NULL, "HS Mic"},
+	{"HS Mic", NULL, "b Mic Bias"},
 };
 
 static const char * const spk_function[] = {"Off", "On"};
-- 
2.2.2
