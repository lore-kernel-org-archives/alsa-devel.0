From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH v2 1/3] ASoC: rockchip: i2s: fix error
	defination of transmit data level
Date: Wed, 24 Dec 2014 17:37:00 +0800
Message-ID: <1419413822-11539-2-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id D34A12614FB
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 10:39:11 +0100 (CET)
In-Reply-To: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, heiko@sntech.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sonnyrao@chromium.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Jianqun Xu <jay.xu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

According to description about "Transmit Data Level",

This bit field controls the level at which a DMA request
is made by the transmit logic.

It is equal to the watermark level.

That is, the dma_tx_req signal is generated when the number
of valid data entries in the TXFIFO
(TXFIFO0 if CSR=00
 TXFIFO1 if CSR=01
 TXFIFO2 if CSR=10
 TXFIFO3 if CSR=11)
is equal to or below this field value.

Different to receive data level, transmit data level does not need
to "-1".

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v1:
- none

 sound/soc/rockchip/rockchip_i2s.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index 89a5d8b..93f456f 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -127,7 +127,7 @@
 #define I2S_DMACR_TDE_DISABLE	(0 << I2S_DMACR_TDE_SHIFT)
 #define I2S_DMACR_TDE_ENABLE	(1 << I2S_DMACR_TDE_SHIFT)
 #define I2S_DMACR_TDL_SHIFT	0
-#define I2S_DMACR_TDL(x)	((x - 1) << I2S_DMACR_TDL_SHIFT)
+#define I2S_DMACR_TDL(x)	((x) << I2S_DMACR_TDL_SHIFT)
 #define I2S_DMACR_TDL_MASK	(0x1f << I2S_DMACR_TDL_SHIFT)
 
 /*
-- 
1.9.1
