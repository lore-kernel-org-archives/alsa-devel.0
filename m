From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Staticise twl6040_hs_jack_report()
Date: Thu, 20 Jan 2011 21:43:44 +0000
Message-ID: <1295559824-3837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8ADE24437
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 22:43:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Margarita Olaya Cabrera <magi.olaya@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's an internal function so shouldn't be exported (as sparse points
out).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4bbf1b1..482fcdb 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -724,8 +724,8 @@ static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-void twl6040_hs_jack_report(struct snd_soc_codec *codec,
-				struct snd_soc_jack *jack, int report)
+static void twl6040_hs_jack_report(struct snd_soc_codec *codec,
+				   struct snd_soc_jack *jack, int report)
 {
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int status;
-- 
1.7.2.3
