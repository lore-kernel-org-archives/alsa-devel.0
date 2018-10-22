From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/2] ASoC: stm32: sai: fix master clock naming
Date: Mon, 22 Oct 2018 17:10:46 +0200
Message-ID: <1540221046-11812-3-git-send-email-olivier.moysan@st.com>
References: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF152679F4
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 17:10:51 +0200 (CEST)
In-Reply-To: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Fix warning issued by strncat when bound equals to source length.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 31d22abd3204..ea05cc91aa05 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -404,12 +404,11 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 	 * String after "_" char is stripped in parent name.
 	 */
 	p = mclk_name;
-	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 6))) {
+	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 7))) {
 		*p++ = *s++;
 		i++;
 	}
-	STM_SAI_IS_SUB_A(sai) ?
-		strncat(p, "a_mclk", 6) : strncat(p, "b_mclk", 6);
+	STM_SAI_IS_SUB_A(sai) ? strcat(p, "a_mclk") : strcat(p, "b_mclk");
 
 	mclk->hw.init = CLK_HW_INIT(mclk_name, pname, &mclk_ops, 0);
 	mclk->sai_data = sai;
-- 
2.7.4
