From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 2/4] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon,  4 Mar 2019 11:59:53 -0500
Message-ID: <20190304165955.21696-2-TheSven73@gmail.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57FF3F896CE
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 18:00:04 +0100 (CET)
Received: by mail-it1-x143.google.com with SMTP id z124so8573115itc.2
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 09:00:04 -0800 (PST)
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

Retrieve the bclk_ratio from the hw_params and provide it
to the HDMI bridge.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9483c55f871b..50062c773a12 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -53,6 +53,7 @@ struct hdmi_codec_params {
 	int sample_rate;
 	int sample_width;
 	int channels;
+	int bclk_ratio;
 };
 
 struct hdmi_codec_pdata;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e5b6769b9797..6a457278fe6d 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -519,6 +519,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 	hp.sample_width = params_width(params);
 	hp.sample_rate = params_rate(params);
 	hp.channels = params_channels(params);
+	hp.bclk_ratio = params_bclk_ratio(params);
 
 	return hcp->hcd.ops->hw_params(dai->dev->parent, hcp->hcd.data,
 				       &hcp->daifmt[dai->id], &hp);
-- 
2.17.1
