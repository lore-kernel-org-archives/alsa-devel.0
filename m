From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level .read/.write" to
	the asoc tree
Date: Tue, 16 Jan 2018 13:55:57 +0000
Message-ID: <E1ebRiX-00057C-Ao@debutante>
References: <87vag28sx9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AB9D266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:56:02 +0100 (CET)
In-Reply-To: <87vag28sx9.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add Component level .read/.write

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

>From d0ff8ba57d9654e6f7a2e18f192bac3b93268fef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jan 2018 02:00:59 +0000
Subject: [PATCH] ASoC: add Component level .read/.write

In current ALSA SoC, Codec only has .read/.write callback.
Codec will be merged into Component in next generation ALSA SoC,
thus current Codec specific feature need to be merged into it.
This is glue patch for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 3 +++
 sound/soc/soc-io.c  | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1a7323238c49..6e865c2bcffe 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -802,6 +802,9 @@ struct snd_soc_component_driver {
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
 
+	unsigned int (*read)(struct snd_soc_component *, unsigned int);
+	int (*write)(struct snd_soc_component *, unsigned int, unsigned int);
+
 	/* pcm creation and destruction */
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 20340ade20a7..2bc1c4c17896 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -34,6 +34,10 @@ int snd_soc_component_read(struct snd_soc_component *component,
 		ret = regmap_read(component->regmap, reg, val);
 	else if (component->read)
 		ret = component->read(component, reg, val);
+	else if (component->driver->read) {
+		*val = component->driver->read(component, reg);
+		ret = 0;
+	}
 	else
 		ret = -EIO;
 
@@ -70,6 +74,8 @@ int snd_soc_component_write(struct snd_soc_component *component,
 		return regmap_write(component->regmap, reg, val);
 	else if (component->write)
 		return component->write(component, reg, val);
+	else if (component->driver->write)
+		return component->driver->write(component, reg, val);
 	else
 		return -EIO;
 }
-- 
2.15.1
