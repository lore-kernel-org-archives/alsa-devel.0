From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v7 9/9] drm/mediatek: hdmi: use helper function for N and CTS
 calculation
Date: Wed, 20 Apr 2016 11:00:04 +0200
Message-ID: <1461142804-26728-10-git-send-email-p.zabel@pengutronix.de>
References: <1461142804-26728-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461142804-26728-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Use the hdmi helper function [1] to calculate N and CTS.

[1] https://patchwork.kernel.org/patch/8091531/ ("video: hdmi: add helper
    function for N and CTS")

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 85 +++++++++----------------------------
 1 file changed, 21 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 06e3811..da6edef 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -656,65 +656,6 @@ static const struct hdmi_acr_n hdmi_rec_n_table[] = {
 	{      0, {  4096,  6272,  6144 } }, /* all other TMDS clocks */
 };
 
-/**
- * hdmi_recommended_n() - Return N value recommended by HDMI specification
- * @freq: audio sample rate in Hz
- * @clock: rounded TMDS clock in kHz
- */
-static unsigned int hdmi_recommended_n(unsigned int freq, unsigned int clock)
-{
-	const struct hdmi_acr_n *recommended;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(hdmi_rec_n_table) - 1; i++) {
-		if (clock == hdmi_rec_n_table[i].clock)
-			break;
-	}
-	recommended = hdmi_rec_n_table + i;
-
-	switch (freq) {
-	case 32000:
-		return recommended->n[0];
-	case 44100:
-		return recommended->n[1];
-	case 48000:
-		return recommended->n[2];
-	case 88200:
-		return recommended->n[1] * 2;
-	case 96000:
-		return recommended->n[2] * 2;
-	case 176400:
-		return recommended->n[1] * 4;
-	case 192000:
-		return recommended->n[2] * 4;
-	default:
-		return (128 * freq) / 1000;
-	}
-}
-
-static unsigned int hdmi_mode_clock_to_hz(unsigned int clock)
-{
-	switch (clock) {
-	case 25175:
-		return 25174825;	/* 25.2/1.001 MHz */
-	case 74176:
-		return 74175824;	/* 74.25/1.001 MHz */
-	case 148352:
-		return 148351648;	/* 148.5/1.001 MHz */
-	case 296703:
-		return 296703297;	/* 297/1.001 MHz */
-	default:
-		return clock * 1000;
-	}
-}
-
-static unsigned int hdmi_expected_cts(unsigned int audio_sample_rate,
-				      unsigned int tmds_clock, unsigned int n)
-{
-	return DIV_ROUND_CLOSEST_ULL((u64)hdmi_mode_clock_to_hz(tmds_clock) * n,
-				     128 * audio_sample_rate);
-}
-
 static void do_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi, unsigned int n,
 				    unsigned int cts)
 {
@@ -739,21 +680,37 @@ static void do_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi, unsigned int n,
 		mtk_hdmi_write(hdmi, GRL_NCTS, val[i]);
 }
 
+static unsigned int hdmi_mode_clock_to_hz(unsigned int clock)
+{
+	switch (clock) {
+	case 25175:
+		return 25174825;	/* 25.2/1.001 MHz */
+	case 74176:
+		return 74175824;	/* 74.25/1.001 MHz */
+	case 148352:
+		return 148351648;	/* 148.5/1.001 MHz */
+	case 296703:
+		return 296703296;	/* 297/1.001 MHz */
+	default:
+		return clock * 1000;
+	}
+}
+
 static void mtk_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi,
 				     unsigned int sample_rate,
 				     unsigned int clock)
 {
-	unsigned int n, cts;
+	struct hdmi_audio_n_cts n_cts;
 
-	n = hdmi_recommended_n(sample_rate, clock);
-	cts = hdmi_expected_cts(sample_rate, clock, n);
+	hdmi_audio_get_coherent_n_cts(sample_rate, hdmi_mode_clock_to_hz(clock),
+				      &n_cts);
 
 	dev_dbg(hdmi->dev, "%s: sample_rate=%u, clock=%d, cts=%u, n=%u\n",
-		__func__, sample_rate, clock, n, cts);
+		__func__, sample_rate, clock, n_cts.cts, n_cts.n);
 
 	mtk_hdmi_mask(hdmi, DUMMY_304, AUDIO_I2S_NCTS_SEL_64,
 		      AUDIO_I2S_NCTS_SEL);
-	do_hdmi_hw_aud_set_ncts(hdmi, n, cts);
+	do_hdmi_hw_aud_set_ncts(hdmi, n_cts.n, n_cts.cts);
 }
 
 static u8 mtk_hdmi_aud_get_chnl_count(enum hdmi_aud_channel_type channel_type)
-- 
2.8.0.rc3
