From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: pxa-ssp: simplify
	pxa_ssp_set_dai_sysclk()
Date: Mon, 21 May 2018 23:50:17 +0200
Message-ID: <20180521215017.29095-2-daniel@zonque.org>
References: <20180521215017.29095-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 387EB26762F
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 23:50:28 +0200 (CEST)
In-Reply-To: <20180521215017.29095-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robert.jarzmik@free.fr, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Daniel Mack <daniel@zonque.org>, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

There's no need to read the register again prior to writing it, we did
that in the beginning of the function.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/pxa-ssp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index fbed87d824b8..d276f95630f0 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -216,10 +216,9 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
-	int val;
 
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
-		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+		~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
 	dev_dbg(&ssp->pdev->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
@@ -257,8 +256,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (ssp->type != PXA3xx_SSP)
 		clk_disable_unprepare(ssp->clk);
-	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
-	pxa_ssp_write_reg(ssp, SSCR0, val);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 	if (ssp->type != PXA3xx_SSP)
 		clk_prepare_enable(ssp->clk);
 
-- 
2.14.3
