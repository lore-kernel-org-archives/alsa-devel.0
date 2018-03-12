From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 7/7] ASoC: amd: enabling bt i2s config after
	acp reset
Date: Mon, 12 Mar 2018 12:04:20 +0530
Message-ID: <1520836460-21809-8-git-send-email-Vijendar.Mukunda@amd.com>
References: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0046.outbound.protection.outlook.com [104.47.32.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD1A2676B6
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 07:33:44 +0100 (CET)
In-Reply-To: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

after acp reset , it requires to reprogram bt i2s config
mux pins to enable bt i2s instance.
added bt i2s enablement sequence during acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 5 +++++
 sound/soc/amd/acp.h         | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index a6787ac..f7471ae 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -604,6 +604,11 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
 
+	/*For BT instance change pins from UART to BT */
+	val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
+	val |= ACP_BT_UART_PAD_SELECT_MASK;
+	acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
+
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
 			mmACP_AXI2DAGB_ONION_CNTL);
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index cd83a03..84b3850 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -108,6 +108,8 @@
 #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
 #define I2S_SP_INSTANCE 1
 #define I2S_BT_INSTANCE 3
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
-- 
2.7.4
