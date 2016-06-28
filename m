From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: fix spelling mistake: "receivce" -> "receive"" to the asoc tree
Date: Tue, 28 Jun 2016 20:36:24 +0100
Message-ID: <E1bHyo4-0004Sx-11@debutante>
References: <1467118079-8652-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467118079-8652-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: fix spelling mistake: "receivce" -> "receive"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d93c5066e85e936765af29bf47ec78885d55ad02 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 28 Jun 2016 13:47:59 +0100
Subject: [PATCH] ASoC: fsl_spdif: fix spelling mistake: "receivce" ->
 "receive"

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 151849f79863..beec7934a265 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -172,7 +172,7 @@ static void spdif_irq_uqrx_full(struct fsl_spdif_priv *spdif_priv, char name)
 	if (*pos >= size * 2) {
 		*pos = 0;
 	} else if (unlikely((*pos % size) + 3 > size)) {
-		dev_err(&pdev->dev, "User bit receivce buffer overflow\n");
+		dev_err(&pdev->dev, "User bit receive buffer overflow\n");
 		return;
 	}
 
-- 
2.8.1
