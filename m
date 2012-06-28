From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dwc: Add missing __iomem annotations
Date: Thu, 28 Jun 2012 13:12:40 +0100
Message-ID: <1340885560-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 843582414F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 14:12:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise sparse gets very upset with us.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/dwc/designware_i2s.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index e667e2b..1bd042b 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -71,12 +71,12 @@ struct dw_i2s_dev {
 	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
 };
 
-static inline void i2s_write_reg(void *io_base, int reg, u32 val)
+static inline void i2s_write_reg(void __iomem *io_base, int reg, u32 val)
 {
 	writel(val, io_base + reg);
 }
 
-static inline u32 i2s_read_reg(void *io_base, int reg)
+static inline u32 i2s_read_reg(void __iomem *io_base, int reg)
 {
 	return readl(io_base + reg);
 }
-- 
1.7.10
