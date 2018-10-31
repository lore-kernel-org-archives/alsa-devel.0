From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: stm32: sai: fix less than zero
	comparison on unsigned int
Date: Wed, 31 Oct 2018 19:31:43 +0000
Message-ID: <20181031193143.6994-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 529162677E4
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 20:31:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the comparison of div < 0 is always false because div is
an unsigned int. Fix this by making div an int.

Detected by CoverityScan, CID#1475309 ("Unsigned compared against 0")

Fixes: 8307b2afd386 "(ASoC: stm32: sai: set sai as mclk clock provider")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/stm/stm32_sai_sub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 211589b0b2ef..d4825700b63f 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -336,8 +336,7 @@ static int stm32_sai_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
 	struct stm32_sai_sub_data *sai = mclk->sai_data;
-	unsigned int div;
-	int ret;
+	int div, ret;
 
 	div = stm32_sai_get_clk_div(sai, parent_rate, rate);
 	if (div < 0)
-- 
2.19.1
