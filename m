From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: Added blank line after
	declarations" to the asoc tree
Date: Tue, 07 Mar 2017 14:33:10 +0100
Message-ID: <E1clFEk-0005Vv-Q3@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B46E266AC4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:33:20 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Codrut GROSU <codrut.cristian.grosu@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: Added blank line after declarations

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

>From fe3a980cd39125efb7e9ddd67dd0f1a9ef237171 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 21:50:21 +0200
Subject: [PATCH] ASoC: ux500: Added blank line after declarations

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/ux500_msp_dai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 36e9bb2bd634..ec5152aa3f6e 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -133,6 +133,7 @@ static int setup_pcm_framing(struct snd_soc_dai *dai, unsigned int rate,
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
 
 	u32 frame_length = MSP_FRAME_LEN_1;
+
 	prot_desc->frame_width = 0;
 
 	switch (drvdata->slots) {
-- 
2.11.0
