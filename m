From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: fix master clock naming" to
	the asoc tree
Date: Tue, 23 Oct 2018 11:53:55 +0200 (CEST)
Message-ID: <20181023095356.02CB9440078@finisterre.ee.mobilebroadband>
References: <1540221046-11812-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D2862675B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 11:54:00 +0200 (CEST)
In-Reply-To: <1540221046-11812-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: fix master clock naming

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6be0f96d799f487f05eb412d362d5a1747d665c2 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 22 Oct 2018 17:10:46 +0200
Subject: [PATCH] ASoC: stm32: sai: fix master clock naming

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Fix warning issued by strncat when bound equals to source length.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0
