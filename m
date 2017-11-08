From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_component_cache_sync()" to
	the asoc tree
Date: Wed, 08 Nov 2017 21:32:05 +0000
Message-ID: <E1eCXx7-0005Nl-Nr@debutante>
References: <87k21jm1gz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 35E172676A0
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:32:54 +0100 (CET)
In-Reply-To: <87k21jm1gz.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add snd_soc_component_cache_sync()

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

>From 474db2c9991cc624e7415770c8b80fc7acf40cdd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 01:48:52 +0000
Subject: [PATCH] ASoC: add snd_soc_component_cache_sync()

snd_soc_cache_sync() (= for Codec) will be removed soon.
This patch Component version of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f69b13c4a641..4961f4455b65 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1540,6 +1540,18 @@ static inline int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	return regcache_sync(codec->component.regmap);
 }
 
+/**
+ * snd_soc_component_cache_sync() - Sync the register cache with the hardware
+ * @component: COMPONENT to sync
+ *
+ * Note: This function will call regcache_sync()
+ */
+static inline int snd_soc_component_cache_sync(
+	struct snd_soc_component *component)
+{
+	return regcache_sync(component->regmap);
+}
+
 /* component IO */
 int snd_soc_component_read(struct snd_soc_component *component,
 	unsigned int reg, unsigned int *val);
-- 
2.15.0
