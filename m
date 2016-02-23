From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: i2s: add default values for
	registers
Date: Tue, 23 Feb 2016 09:19:22 +0800
Message-ID: <1456190362-15653-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE88260563
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 02:25:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

this patch add default values for registers according description from TRM.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6561c4c..a0b0942 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -440,11 +440,21 @@ static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_default rockchip_i2s_reg_defaults[] = {
+	{0x00, 0x0000000f},
+	{0x04, 0x0000000f},
+	{0x08, 0x00071f1f},
+	{0x10, 0x001f0000},
+	{0x14, 0x01f00000},
+};
+
 static const struct regmap_config rockchip_i2s_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = I2S_RXDR,
+	.reg_defaults = rockchip_i2s_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rockchip_i2s_reg_defaults),
 	.writeable_reg = rockchip_i2s_wr_reg,
 	.readable_reg = rockchip_i2s_rd_reg,
 	.volatile_reg = rockchip_i2s_volatile_reg,
-- 
1.9.1
