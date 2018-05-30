From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix 0-day warnings with
	snd_soc_new_compress()" to the asoc tree
Date: Wed, 30 May 2018 12:02:46 +0100
Message-ID: <E1fNysQ-0006gv-Ez@debutante>
References: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B122676DD
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 13:02:51 +0200 (CEST)
In-Reply-To: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix 0-day warnings with snd_soc_new_compress()

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

>From 0b014d72ebae14c0c6ab3fb36a442fda91e1a1b3 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 29 May 2018 18:30:02 -0500
Subject: [PATCH] ASoC: fix 0-day warnings with snd_soc_new_compress()

All conditionally-defined routines in include/sound/soc.h expose a
static inline fallback to avoid 0-day warnings and compilation issues,
except snd_soc_new_compress().

Fixes: 5db6aab6f36f ('ASoC: topology: Add support for compressed PCMs')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 600a7ebd10c0..1378dcd2128a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -462,6 +462,11 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 #ifdef CONFIG_SND_SOC_COMPRESS
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
+#else
+static inline int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
+{
+	return 0;
+}
 #endif
 
 void snd_soc_disconnect_sync(struct device *dev);
-- 
2.17.0
