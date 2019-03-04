From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 3/4] drm/i2c: tda998x: calculate CTS_N
	directly from the bclk_ratio
Date: Mon,  4 Mar 2019 11:59:54 -0500
Message-ID: <20190304165955.21696-3-TheSven73@gmail.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5977F896F5
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 18:00:06 +0100 (CET)
Received: by mail-it1-x142.google.com with SMTP id m137so8259337ita.0
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 09:00:06 -0800 (PST)
In-Reply-To: <20190304165955.21696-1-TheSven73@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 20 ++++++++++++++------
 include/drm/i2c/tda998x.h         |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index a7c39f39793f..caccfaf90dd2 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -893,19 +893,26 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		switch (params->sample_width) {
+		switch (params->bclk_ratio) {
 		case 16:
+			cts_n = CTS_N_M(3) | CTS_N_K(0);
+			break;
+		case 32:
 			cts_n = CTS_N_M(3) | CTS_N_K(1);
 			break;
-		case 18:
-		case 20:
-		case 24:
+		case 48:
 			cts_n = CTS_N_M(3) | CTS_N_K(2);
 			break;
-		default:
-		case 32:
+		case 64:
 			cts_n = CTS_N_M(3) | CTS_N_K(3);
 			break;
+		case 128:
+			cts_n = CTS_N_M(0) | CTS_N_K(0);
+			break;
+		default:
+			dev_err(&priv->hdmi->dev,
+				"unsupported I2S bclk ratio\n");
+			return -EINVAL;
 		}
 		break;
 
@@ -984,6 +991,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	struct tda998x_audio_params audio = {
 		.sample_width = params->sample_width,
 		.sample_rate = params->sample_rate,
+		.bclk_ratio = params->bclk_ratio,
 		.cea = params->cea,
 	};
 
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index 3cb25ccbe5e6..62d85c662aa1 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -16,6 +16,7 @@ struct tda998x_audio_params {
 	u8 format;
 	unsigned sample_width;
 	unsigned sample_rate;
+	unsigned int bclk_ratio;
 	struct hdmi_audio_infoframe cea;
 	u8 status[5];
 };
-- 
2.17.1
