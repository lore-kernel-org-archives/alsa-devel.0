From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: snd_soc_component_driver has
	pmdown_time" to the asoc tree
Date: Mon, 23 Oct 2017 10:43:17 +0100 (BST)
Message-ID: <20171023094317.35C6C440058@finisterre.ee.mobilebroadband>
References: <87r2vrm1ka.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84F65266FFE
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 11:43:17 +0200 (CEST)
In-Reply-To: <87r2vrm1ka.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: snd_soc_component_driver has pmdown_time

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

>From fbb16563c6c2b7fc4944adc49f93c1dc6fe25770 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Oct 2017 01:38:08 +0000
Subject: [PATCH] ASoC: snd_soc_component_driver has pmdown_time

Current snd_soc_runtime_ignore_pmdown_time() tallys all Codec and
CPU's "ignore_pmdown_time". Now, CPU (= via compoent)
ignore_pmdown_time is fixed as "true". Codec's one is copied from Codec
driver. This means Codec side default is "false".

Current all Codec driver will be replaced into Component, thus, we can
use for_each_rtdcom() for this totalization. This patch adds new
"pmdown_time" on Component driver. Its inverted value will be used
for this "ignore" totalizaton.

Of course all existing Component driver doesn't have its settings now,
thus, all existing "pmdown_time" is "false". This means all
Components will ignore pmdown time. This is current CPU behavior.
To keep compatibility, snd_soc_runtime_ignore_pmdown_time() totalize
Component's inverted "pmdown_time" (= total will be true) and
Codec's "ignore_pmdown_time" (= depends on Codec driver settings).
Because It is using AND operation, its result is based on Codec driver
settings only.
This means this operation can keep compatibility and doesn't have
nonconformity.

When we replace Codec to Component, the driver which has
".ignore_pmdown_time = true" will be just removed,
and the driver which doesn't have it will have new
".pmdown_time = true".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h |  1 +
 sound/soc/soc-pcm.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ae0a27fdc016..44fab951b686 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -836,6 +836,7 @@ struct snd_soc_component_driver {
 	/* bits */
 	unsigned int idle_bias_on:1;
 	unsigned int suspend_bias_off:1;
+	unsigned int pmdown_time:1; /* care pmdown_time at stop */
 };
 
 struct snd_soc_component {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index daaa670ee9b7..8075856668c2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -133,16 +133,25 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component;
 	int i;
 	bool ignore = true;
 
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		ignore &= !component->driver->pmdown_time;
+	}
+
+	/* this will be removed */
 	for (i = 0; i < rtd->num_codecs; i++)
 		ignore &= rtd->codec_dais[i]->component->ignore_pmdown_time;
 
-	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
+	return ignore;
 }
 
 /**
-- 
2.14.1
