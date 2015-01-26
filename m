From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 4/4] sound: jz4740: set i2s clk rate to 12MHz
Date: Mon, 26 Jan 2015 13:15:38 +0000
Message-ID: <1422278138-51097-5-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Zubair.Kakakhel@imgtec.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

i2s clock rate is not set to 12MHz currently. Set it before enabling
the clock.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V2 changes: Removed clk_prepare_enable call as clock was already being
enabled elsewhere. Just set rate to 12MHz.
---
 sound/soc/jz4740/jz4740-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 07f7781..c2e5852 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -125,6 +125,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	ctrl |= JZ_AIC_CTRL_FLUSH;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 
+	clk_set_rate(i2s->clk_i2s, 12000000);
 	clk_prepare_enable(i2s->clk_i2s);
 
 	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-- 
1.9.1
