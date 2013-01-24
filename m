From: "R. Chandrasekar" <rcsekar@samsung.com>
Subject: [PATCH] Asoc: Samsung: Add I2S S/W RST in startup function
Date: Thu, 24 Jan 2013 18:05:31 +0530
Message-ID: <1359030931-27354-2-git-send-email-rcsekar@samsung.com>
References: <1359030931-27354-1-git-send-email-rcsekar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1359030931-27354-1-git-send-email-rcsekar@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
Cc: sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, kgene.kim@samsung.com, jassisinghbrar@gmail.com, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: Padmavathi Venna <padma.v@samsung.com>

I2S module need to be reset after S2R. Keeping the S/W rst
control part in resume didn't help in playing audio after resume.
So this patch adds S/W RST control part in startup function which
gets triggered for every new audio stream playback.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: R. Chandrasekar <rcsekar@samsung.com>
---
 sound/soc/samsung/i2s.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 27a5ab1..9f098cd 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -651,6 +651,9 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	/* Enforce set_sysclk in Master mode */
 	i2s->rclk_srcrate = 0;
 
+	if (!any_active(i2s) && (i2s->quirks & QUIRK_NEED_RSTCLR))
+		writel(CON_RSTCLR, i2s->addr + I2SCON);
+
 	spin_unlock_irqrestore(&lock, flags);
 
 	return 0;
-- 
1.7.9.5
