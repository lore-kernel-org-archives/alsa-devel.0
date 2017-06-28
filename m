From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: stm32: sai: remove some stray tabs
Date: Wed, 28 Jun 2017 15:20:06 +0300
Message-ID: <20170628121946.fvw2mpirm2kjaqak@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 49EAF266AF8
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:20:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, olivier moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

This line was accidentally indented too far.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index ba3fdc777ed8..90d439613899 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -631,7 +631,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 	dev_dbg(cpu_dai->dev, "SAI clock %d, divider %d\n", sai_clk_rate, div);
 
 	mask = SAI_XCR1_MCKDIV_MASK(SAI_XCR1_MCKDIV_WIDTH(version));
-				    cr1 = SAI_XCR1_MCKDIV_SET(div);
+	cr1 = SAI_XCR1_MCKDIV_SET(div);
 	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, mask, cr1);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
