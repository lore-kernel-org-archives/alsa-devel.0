From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: txx9: Added blank line after
	declarations" to the asoc tree
Date: Tue, 07 Mar 2017 14:33:20 +0100
Message-ID: <E1clFEu-0005YW-Rj@finisterre>
References: <1488050273-7929-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FCF7267051
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:34:19 +0100 (CET)
In-Reply-To: <1488050273-7929-1-git-send-email-codrut.cristian.grosu@gmail.com>
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

   ASoC: txx9: Added blank line after declarations

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

>From c2dcce361ab7161e494e93f19a2945574c5a2cd7 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 21:17:53 +0200
Subject: [PATCH] ASoC: txx9: Added blank line after declarations

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/txx9/txx9aclc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index a8f705bb60dc..2cb2e0672c44 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -392,6 +392,7 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 	for (i = 0; i < 2; i++) {
 		struct txx9aclc_dmadata *dmadata = &dev->dmadata[i];
 		struct dma_chan *chan = dmadata->dma_chan;
+
 		if (chan) {
 			dmadata->frag_count = -1;
 			dmaengine_terminate_all(chan);
-- 
2.11.0
