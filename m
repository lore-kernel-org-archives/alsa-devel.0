From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: txx9: Added requiered spaces." to the
	asoc tree
Date: Tue, 07 Mar 2017 15:21:29 +0100
Message-ID: <E1clFzV-0006ee-Ls@finisterre>
References: <1488017541-14080-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79B89266FCB
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 15:22:20 +0100 (CET)
In-Reply-To: <1488017541-14080-1-git-send-email-codrut.cristian.grosu@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, Codrut GROSU <codrut.cristian.grosu@gmail.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: txx9: Added requiered spaces.

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

>From 84052652feb89e76fde6fd37d26c9649da715557 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 12:12:21 +0200
Subject: [PATCH] ASoC: txx9: Added requiered spaces.

This was reported by checpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/txx9/txx9aclc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 2cb2e0672c44..7912bf09dc4d 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -206,7 +206,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 static int txx9aclc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
-	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	unsigned long flags;
 	int ret = 0;
@@ -340,7 +340,7 @@ static bool filter(struct dma_chan *chan, void *param)
 static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 			     struct txx9aclc_dmadata *dmadata)
 {
-	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	struct txx9dmac_slave *ds = &dmadata->dma_slave;
 	dma_cap_mask_t mask;
 
-- 
2.11.0
