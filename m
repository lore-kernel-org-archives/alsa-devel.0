From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: Fix the issue about
	unsupported rate" to the asoc tree
Date: Thu, 16 May 2019 19:02:59 +0100 (BST)
Message-ID: <20190516180259.AA4AD112929F@debutante.sirena.org.uk>
References: <e0c519d616b48a1481c9f239646517b453e7ce50.1557901312.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EA19F8078F
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 20:03:02 +0200 (CEST)
In-Reply-To: <e0c519d616b48a1481c9f239646517b453e7ce50.1557901312.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: Fix the issue about unsupported rate

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From b06c58c2a1eed571ea2a6640fdb85b7b00196b1e Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Wed, 15 May 2019 06:42:18 +0000
Subject: [PATCH] ASoC: fsl_asrc: Fix the issue about unsupported rate

When the output sample rate is [8kHz, 30kHz], the limitation
of the supported ratio range is [1/24, 8]. In the driver
we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
So this patch is to fix this issue and the potential rounding
issue with divider.

Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
output sample rate")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0b937924d2e4..ea035c12a325 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -282,8 +282,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
-	if ((outrate > 8000 && outrate < 30000) &&
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	if ((outrate >= 8000 && outrate <= 30000) &&
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
 		pair_err("exceed supported ratio range [1/24, 8] for \
 				inrate/outrate: %d/%d\n", inrate, outrate);
 		return -EINVAL;
-- 
2.20.1
