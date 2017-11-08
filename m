From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_component_read32" to the
	asoc tree
Date: Wed, 08 Nov 2017 21:32:21 +0000
Message-ID: <E1eCXxN-0005Pm-D1@debutante>
References: <87a80y4gir.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA1D267647
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:44 +0100 (CET)
In-Reply-To: <87a80y4gir.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add snd_soc_component_read32

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

>From 738b49efe6c6ba485e2b45265db535c58bbd54e7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 01:48:19 +0000
Subject: [PATCH] ASoC: add snd_soc_component_read32

Current codec drivers are using snd_soc_read(). It will be replaced
into snd_soc_component_read(), but these 2 are using different style.
For example, it will be

	- val = snd_soc_read(xxx, reg);
	+ ret = snd_soc_component_read(xxx, reg, &val);
	+ if (ret < 0) {
	+	...
	+ }

To more smooth replace, let's add snd_soc_component_read32
which is copied from snd_soc_read()

	- val = snd_soc_read(xxx, reg);
	+ val = snd_soc_component_read32(xxx, reg);

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-io.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6c808527a4f6..747588273c96 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1498,6 +1498,8 @@ static inline int snd_soc_cache_sync(struct snd_soc_codec *codec)
 /* component IO */
 int snd_soc_component_read(struct snd_soc_component *component,
 	unsigned int reg, unsigned int *val);
+unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+				      unsigned int reg);
 int snd_soc_component_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val);
 int snd_soc_component_update_bits(struct snd_soc_component *component,
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 9b3939049cef..20340ade20a7 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -41,6 +41,20 @@ int snd_soc_component_read(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_read);
 
+unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+				      unsigned int reg)
+{
+	unsigned int val;
+	int ret;
+
+	ret = snd_soc_component_read(component, reg, &val);
+	if (ret < 0)
+		return -1;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_read32);
+
 /**
  * snd_soc_component_write() - Write register value
  * @component: Component to write to
-- 
2.15.0
