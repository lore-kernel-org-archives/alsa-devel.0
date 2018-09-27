From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-utils: Rename dummy_dma_ops to
	snd_dummy_dma_ops" to the asoc tree
Date: Thu, 27 Sep 2018 23:39:58 +0100 (BST)
Message-ID: <20180927223958.E7816440078@finisterre.ee.mobilebroadband>
References: <20180925180914.193244-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E53722678CD
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 00:39:59 +0200 (CEST)
In-Reply-To: <20180925180914.193244-1-mka@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops

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

>From 42cfb412e24ffbb46d6de9590293bc44f921a0fb Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 25 Sep 2018 11:09:14 -0700
Subject: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops

The symbols 'dummy_dma_ops' is declared with different data types by
sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:

sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
  static const struct snd_pcm_ops dummy_dma_ops = {
                                  ^
...
arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
  extern const struct dma_map_ops dummy_dma_ops;
                                  ^

Rename the symbol in soc-utils.c to 'snd_dummy_dma_ops' to avoid the
conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..e3b9dd634c6d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_dma_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_dma_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0
