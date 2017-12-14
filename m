From: Olivier Moysan <olivier.moysan@st.com>
Subject: [RFC PATCH 1/2] ASoC: add support of mclk clock
	providers in wm8894 driver
Date: Thu, 14 Dec 2017 17:53:57 +0100
Message-ID: <1513270438-18523-2-git-send-email-olivier.moysan@st.com>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B5A38267AEE
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 17:56:18 +0100 (CET)
In-Reply-To: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: patches@opensource.wolfsonmicro.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Wolfson wm8994 codec bindings exposes MCLK1 and MCLK1 clocks.
This patch adds support of MCLK1 and MCLK2 in mfd driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/mfd/wm8994-core.c        | 9 +++++++++
 include/linux/mfd/wm8994/pdata.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 953d079..f1ff9d8 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -310,6 +311,14 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 	if (pdata->ldo[1].enable < 0)
 		pdata->ldo[1].enable = 0;
 
+	pdata->mclk1 = devm_clk_get(wm8994->dev, "MCLK1");
+	if (IS_ERR(pdata->mclk1))
+		pdata->mclk1 = NULL;
+
+	pdata->mclk2 = devm_clk_get(wm8994->dev, "MCLK2");
+	if (IS_ERR(pdata->mclk2))
+		pdata->mclk2 = NULL;
+
 	return 0;
 }
 #else
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 90c6052..8037d26 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -233,6 +233,12 @@ struct wm8994_pdata {
 	 * GPIO for the IRQ pin if host only supports edge triggering
 	 */
 	int irq_gpio;
+
+	/* MCLK1 clock provider */
+	struct clk *mclk1;
+
+	/* MCLK2 clock provider */
+	struct clk *mclk2;
 };
 
 #endif
-- 
1.9.1
