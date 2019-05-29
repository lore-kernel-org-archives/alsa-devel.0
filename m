From: Gen Zhang <blackgod016574@gmail.com>
Subject: [PATCH] wcd9335: fix a incorrect use of kstrndup()
Date: Wed, 29 May 2019 09:53:05 +0800
Message-ID: <20190529015305.GA4700@zhanggen-UX430UQ>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, wen.yang99@zte.com.cn
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
However, according to doc: "Note: Use kmemdup_nul() instead if the size
is known exactly." So we should use kmemdup_nul() here instead of
kstrndup().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a04a7ce..85737fe 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
---
