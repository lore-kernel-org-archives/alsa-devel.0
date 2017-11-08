From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_dapm_kcontrol_component()"
	to the asoc tree
Date: Wed, 08 Nov 2017 21:32:01 +0000
Message-ID: <E1eCXx3-0005Mr-7l@debutante>
References: <87inh3m1g9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A2B267637
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:32:44 +0100 (CET)
In-Reply-To: <87inh3m1g9.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: add snd_soc_dapm_kcontrol_component()

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

>From e07bd30bb87f6a6ca1f75fa41df71ff5e7bc6a3f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 01:49:06 +0000
Subject: [PATCH] ASoC: add snd_soc_dapm_kcontrol_component()

snd_soc_dapm_kcontrol_codec() (= for Codec) will be removed soon.
This patch Component version of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4961f4455b65..0668cbd9f0b5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1524,6 +1524,19 @@ static inline struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(
 	return snd_soc_dapm_to_codec(snd_soc_dapm_kcontrol_dapm(kcontrol));
 }
 
+/**
+ * snd_soc_dapm_kcontrol_component() - Returns the component associated to a kcontrol
+ * @kcontrol: The kcontrol
+ *
+ * This function must only be used on DAPM contexts that are known to be part of
+ * a COMPONENT (e.g. in a COMPONENT driver). Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_component *snd_soc_dapm_kcontrol_component(
+	struct snd_kcontrol *kcontrol)
+{
+	return snd_soc_dapm_to_component(snd_soc_dapm_kcontrol_dapm(kcontrol));
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
-- 
2.15.0
