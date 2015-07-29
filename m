From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xtfpga-i2s: Add missing __rcu
	annotation" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:03 +0100
Message-ID: <E1ZKS6R-0004XJ-0C@finisterre>
References: <1437987388-9706-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 262102657B0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:19 +0200 (CEST)
In-Reply-To: <1437987388-9706-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xtfpga-i2s: Add missing __rcu annotation

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

>From d32e03f0b6f9b4ad260feca1c5c938a882066de9 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 27 Jul 2015 10:56:28 +0200
Subject: [PATCH] ASoC: xtfpga-i2s: Add missing __rcu annotation

tx_substeam is accessed using the RCU API and hence should have the __rcu
annotation. Fixes the following sparse warnings:

	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: incompatible types in
		comparison expression (different address spaces)
	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream
		[noderef] <asn:4>*' versus
	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream *'
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: incompatible types in
		comparison expression (different address spaces)
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream
		[noderef] <asn:4>*' versus
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream *'

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xtensa/xtfpga-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 039f65e..8382ffa 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -75,7 +75,7 @@ struct xtfpga_i2s {
 	 * stream in the pcm_close callback it synchronizes with the interrupt
 	 * handler by means of synchronize_rcu call.
 	 */
-	struct snd_pcm_substream *tx_substream;
+	struct snd_pcm_substream __rcu *tx_substream;
 	unsigned (*tx_fn)(struct xtfpga_i2s *i2s,
 			  struct snd_pcm_runtime *runtime,
 			  unsigned tx_ptr);
-- 
2.1.4
