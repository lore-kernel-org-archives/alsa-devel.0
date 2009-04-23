From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/21] ASoC: Factor out generic widget power
	checks
Date: Thu, 23 Apr 2009 20:55:36 +0100
Message-ID: <1240516555-22249-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CD6B103866
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:02 +0200 (CEST)
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

This will form a basis for further power check refactoring: the overall
goal of these changes is to allow us to check power separately to
applying it, allowing improvements in the power sequencing algorithms.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a6d7337..28e6e32 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -581,6 +581,19 @@ static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
 	return 0;
 }
 
+/* Generic check to see if a widget should be powered.
+ */
+static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
+{
+	int in, out;
+
+	in = is_connected_input_ep(w);
+	dapm_clear_walk(w->codec);
+	out = is_connected_output_ep(w);
+	dapm_clear_walk(w->codec);
+	return out != 0 && in != 0;
+}
+
 /*
  * Scan a single DAPM widget for a complete audio path and update the
  * power status appropriately.
@@ -653,11 +666,7 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 	}
 
 	/* all other widgets */
-	in = is_connected_input_ep(w);
-	dapm_clear_walk(w->codec);
-	out = is_connected_output_ep(w);
-	dapm_clear_walk(w->codec);
-	power = (out != 0 && in != 0) ? 1 : 0;
+	power = dapm_generic_check_power(w);
 	power_change = (w->power == power) ? 0 : 1;
 	w->power = power;
 
-- 
1.5.6.3
