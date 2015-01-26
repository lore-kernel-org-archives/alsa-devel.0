From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] sound: jz4740: Enable codec clock during dai_probe
Date: Mon, 26 Jan 2015 10:18:31 +0000
Message-ID: <1422267511-6649-5-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422267511-6649-1-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

As we are moving away from platform to DT, we cant rely on the board
file to do this now. So enable it here.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 3c309fc..a7e4a7b 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -376,6 +376,10 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 		JZ_AIC_CONF_I2S |
 		JZ_AIC_CONF_INTERNAL_CODEC;
 
+	/* enable codec sysclk */
+	clk_set_rate(i2s->clk_i2s, 12000000);
+	clk_prepare_enable(i2s->clk_i2s);
+
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
