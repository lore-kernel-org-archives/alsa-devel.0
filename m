From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: wm8350: Move delayed work struct
	from DAPM context to driver state
Date: Mon, 30 Mar 2015 21:04:51 +0200
Message-ID: <1427742293-8588-7-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D50D2605BD
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:55 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm8350 driver is the last driver that still uses the delayed_work field
from the snd_soc_dapm_context struct. Moving this over to the driver's
private data struct will allow us to remove the field from the DAPM context,
which will drastically reduce its size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8350.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index c81a9ea..c65e5a7 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -69,14 +69,14 @@ struct wm8350_data {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 	int fll_freq_out;
 	int fll_freq_in;
+	struct delayed_work pga_work;
 };
 
 /*
  * Ramp OUT1 PGA volume to minimise pops at stream startup and shutdown.
  */
-static inline int wm8350_out1_ramp_step(struct snd_soc_codec *codec)
+static inline int wm8350_out1_ramp_step(struct wm8350_data *wm8350_data)
 {
-	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_data->out1;
 	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	int left_complete = 0, right_complete = 0;
@@ -140,9 +140,8 @@ static inline int wm8350_out1_ramp_step(struct snd_soc_codec *codec)
 /*
  * Ramp OUT2 PGA volume to minimise pops at stream startup and shutdown.
  */
-static inline int wm8350_out2_ramp_step(struct snd_soc_codec *codec)
+static inline int wm8350_out2_ramp_step(struct wm8350_data *wm8350_data)
 {
-	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out2 = &wm8350_data->out2;
 	struct wm8350 *wm8350 = wm8350_data->wm8350;
 	int left_complete = 0, right_complete = 0;
@@ -210,10 +209,8 @@ static inline int wm8350_out2_ramp_step(struct snd_soc_codec *codec)
  */
 static void wm8350_pga_work(struct work_struct *work)
 {
-	struct snd_soc_dapm_context *dapm =
-	    container_of(work, struct snd_soc_dapm_context, delayed_work.work);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
+	struct wm8350_data *wm8350_data =
+		container_of(work, struct wm8350_data, pga_work.work);
 	struct wm8350_output *out1 = &wm8350_data->out1,
 	    *out2 = &wm8350_data->out2;
 	int i, out1_complete, out2_complete;
@@ -226,9 +223,9 @@ static void wm8350_pga_work(struct work_struct *work)
 	for (i = 0; i <= 63; i++) {
 		out1_complete = 1, out2_complete = 1;
 		if (out1->ramp != WM8350_RAMP_NONE)
-			out1_complete = wm8350_out1_ramp_step(codec);
+			out1_complete = wm8350_out1_ramp_step(wm8350_data);
 		if (out2->ramp != WM8350_RAMP_NONE)
-			out2_complete = wm8350_out2_ramp_step(codec);
+			out2_complete = wm8350_out2_ramp_step(wm8350_data);
 
 		/* ramp finished ? */
 		if (out1_complete && out2_complete)
@@ -283,7 +280,7 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_UP;
 		out->active = 1;
 
-		schedule_delayed_work(&codec->dapm.delayed_work,
+		schedule_delayed_work(&wm8350_data->pga_work,
 				      msecs_to_jiffies(1));
 		break;
 
@@ -291,7 +288,7 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_DOWN;
 		out->active = 0;
 
-		schedule_delayed_work(&codec->dapm.delayed_work,
+		schedule_delayed_work(&wm8350_data->pga_work,
 				      msecs_to_jiffies(1));
 		break;
 	}
@@ -1492,7 +1489,7 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	/* Put the codec into reset if it wasn't already */
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
-	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8350_pga_work);
+	INIT_DELAYED_WORK(&priv->pga_work, wm8350_pga_work);
 	INIT_DELAYED_WORK(&priv->hpl.work, wm8350_hpl_work);
 	INIT_DELAYED_WORK(&priv->hpr.work, wm8350_hpr_work);
 
@@ -1578,7 +1575,7 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 
 	/* if there was any work waiting then we run it now and
 	 * wait for its completion */
-	flush_delayed_work(&codec->dapm.delayed_work);
+	flush_delayed_work(&priv->pga_work);
 
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
-- 
1.8.0
