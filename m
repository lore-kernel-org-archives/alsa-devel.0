From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/2] ASoC: stm32: spdifrx: fix typo in function
	name.
Date: Wed, 31 Jan 2018 17:47:02 +0100
Message-ID: <1517417223-21899-2-git-send-email-olivier.moysan@st.com>
References: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4FC267665
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 17:47:38 +0100 (CET)
In-Reply-To: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
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
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Fix function name prefix for naming consistency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b9bdefc..42ad2ae 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -858,8 +858,8 @@ static void stm32_spdifrx_shutdown(struct snd_pcm_substream *substream,
 	{}
 };
 
-static int stm_spdifrx_parse_of(struct platform_device *pdev,
-				struct stm32_spdifrx_data *spdifrx)
+static int stm32_spdifrx_parse_of(struct platform_device *pdev,
+				  struct stm32_spdifrx_data *spdifrx)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
@@ -914,7 +914,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spdifrx);
 
-	ret = stm_spdifrx_parse_of(pdev, spdifrx);
+	ret = stm32_spdifrx_parse_of(pdev, spdifrx);
 	if (ret)
 		return ret;
 
-- 
1.9.1
