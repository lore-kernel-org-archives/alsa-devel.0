From: "yitian" <yitian.bu@tangramtek.com>
Subject: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
Date: Tue, 29 Sep 2015 22:39:00 +0800
Message-ID: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg65.qq.com (smtpbg65.qq.com [103.7.28.233])
 by alsa0.perex.cz (Postfix) with ESMTP id D9C58265705
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 16:39:13 +0200 (CEST)
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Andrew.Jackson@arm.com, wsa@the-dreams.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

from Designware I2S datasheet, irq is cleared by reading from
TOR/ROR registers, rather than by writing into them.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
---
 sound/soc/dwc/designware_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..0d28e3b 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -131,10 +131,10 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
*dev, u32 stream)
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, TOR(i), 0);
+			i2s_read_reg(dev->i2s_base, TOR(i));
 	} else {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, ROR(i), 0);
+			i2s_read_reg(dev->i2s_base, ROR(i));
 	}
 }
 
-- 
1.7.12.4
