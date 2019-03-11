From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: stm32: i2s: fix registers declaration in regmap
Date: Mon, 11 Mar 2019 16:39:28 +0100
Message-ID: <1552318768-25404-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

- Declare SR as volatile, as it is changed by hardware.
- Remove TXDR from readable and volatile register list,
as it is intended for write accesses only.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index c18e068c1a0d..952634258b02 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -278,7 +278,6 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_CFG2_REG:
 	case STM32_I2S_IER_REG:
 	case STM32_I2S_SR_REG:
-	case STM32_I2S_TXDR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
 		return true;
@@ -290,7 +289,7 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 static bool stm32_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case STM32_I2S_TXDR_REG:
+	case STM32_I2S_SR_REG:
 	case STM32_I2S_RXDR_REG:
 		return true;
 	default:
-- 
2.7.4
