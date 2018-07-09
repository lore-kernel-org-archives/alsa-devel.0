From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: replace "%p" with "%pK"" to the
	asoc tree
Date: Mon, 09 Jul 2018 12:16:39 +0100
Message-ID: <E1fcU9n-0005bB-GS@debutante>
References: <20180706130703.22352-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BDB026739D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jul 2018 13:17:07 +0200 (CEST)
In-Reply-To: <20180706130703.22352-1-benjamin.gaignard@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: benjamin.gaignard@linaro.orgbenjamin.gaignard@linaro.org
Cc: alsa-devel@alsa-project.org, Benjamin Gaignard <benjamin.gaignard@st.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: replace "%p" with "%pK"

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

>From 8db339d66774821091f73bd0e57c8a7511c5988e Mon Sep 17 00:00:00 2001
From: "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Date: Fri, 6 Jul 2018 15:07:03 +0200
Subject: [PATCH] ASoC: stm32: replace "%p" with "%pK"

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index db73fef3e500..0e9373064032 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -149,7 +149,7 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	unsigned int old_pos = priv->pos;
 	unsigned int cur_size = size;
 
-	dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %zu\n",
+	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
 		__func__, &pcm_buff[priv->pos], priv->pos, size);
 
 	if ((priv->pos + size) > buff_size) {
-- 
2.18.0.rc2
