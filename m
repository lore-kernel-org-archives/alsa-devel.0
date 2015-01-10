From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Update snd_soc_dai_set_tdm_slot()
	documentation
Date: Sat, 10 Jan 2015 11:52:37 +0100
Message-ID: <1420887157-18593-5-git-send-email-lars@metafoo.de>
References: <1420887157-18593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-105.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E31C2606B1
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 11:52:44 +0100 (CET)
In-Reply-To: <1420887157-18593-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

There have been some conflicting interpretations of how
snd_soc_dai_set_tdm_slot() is supposed to work. This patch updates the
documentation to be more specific on the exact semantics to avoid such
problems in the future.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2c02e9c..ededb97 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2130,15 +2130,27 @@ static int snd_soc_xlate_tdm_slot_mask(unsigned int slots,
 }
 
 /**
- * snd_soc_dai_set_tdm_slot - configure DAI TDM.
- * @dai: DAI
+ * snd_soc_dai_set_tdm_slot() - Configures a DAI for TDM operation
+ * @dai: The DAI to configure
  * @tx_mask: bitmask representing active TX slots.
  * @rx_mask: bitmask representing active RX slots.
  * @slots: Number of slots in use.
  * @slot_width: Width in bits for each slot.
  *
- * Configures a DAI for TDM operation. Both mask and slots are codec and DAI
- * specific.
+ * This function configures the specified DAI for TDM operation. @slot contains
+ * the total number of slots of the TDM stream and @slot_with the width of each
+ * slot in bit clock cycles. @tx_mask and @rx_mask are bitmasks specifying the
+ * active slots of the TDM stream for the specified DAI, i.e. which slots the
+ * DAI should write to or read from. If a bit is set the corresponding slot is
+ * active, if a bit is cleared the corresponding slot is inactive. Bit 0 maps to
+ * the first slot, bit 1 to the second slot and so on. The first active slot
+ * maps to the first channel of the DAI, the second active slot to the second
+ * channel and so on.
+ *
+ * TDM mode can be disabled by passing 0 for @slots. In this case @tx_mask,
+ * @rx_mask and @slot_width will be ignored.
+ *
+ * Returns 0 on success, a negative error code otherwise.
  */
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
-- 
1.8.0
