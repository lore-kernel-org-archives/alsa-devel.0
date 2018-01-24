From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: call dummy write for PW_MGMT1/3
	when Playback" to the asoc tree
Date: Wed, 24 Jan 2018 12:10:52 +0000
Message-ID: <E1eeJtE-00087L-SO@debutante>
References: <87374n880c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DCEC266FE0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 13:10:58 +0100 (CET)
In-Reply-To: <87374n880c.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4613: call dummy write for PW_MGMT1/3 when Playback

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

>From 03bbf9f5e4eb9944511cd218d3c1b18809d12eb2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Jan 2018 05:11:42 +0000
Subject: [PATCH] ASoC: ak4613: call dummy write for PW_MGMT1/3 when Playback

Power Down Release Command (PMVR, PMDAC, RSTN, PMDA1-PMDA6)
which are located on PW_MGMT1 / PW_MGMT3 register must be
write again after at least 5 LRCK cycle or later on each command.
Otherwise, Playback volume will be 0dB.
Basically, it should be

        1.   PowerDownRelease by Power Management1 <= call 1.x after 5LRCK
        1.x  Dummy write      to Power Management1
        2.   PowerDownRelease by Power Management3 <= call 2.x after 5LRCK
        2.x  Dummy write      to Power Management3

To avoid too many dummy write, this patch is merging these.

        1.   PowerDownRelease by Power Management1
        2.   PowerDownRelease by Power Management3   <= call after 5LRCK
        2.x  Dummy write      to Power Management1/3 <= merge dummy write

This patch adds dummy write when Playback Start timing.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index b95bb8b52e51..3d1cf4784e87 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -95,6 +96,9 @@ struct ak4613_priv {
 	struct mutex lock;
 	const struct ak4613_interface *iface;
 	struct snd_pcm_hw_constraint_list constraint;
+	struct work_struct dummy_write_work;
+	struct snd_soc_component *component;
+	unsigned int rate;
 	unsigned int sysclk;
 
 	unsigned int fmt;
@@ -392,6 +396,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	priv->rate = rate;
 
 	/*
 	 * FIXME
@@ -467,11 +472,83 @@ static int ak4613_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static void ak4613_dummy_write(struct work_struct *work)
+{
+	struct ak4613_priv *priv = container_of(work,
+						struct ak4613_priv,
+						dummy_write_work);
+	struct snd_soc_component *component = priv->component;
+	unsigned int mgmt1;
+	unsigned int mgmt3;
+
+	/*
+	 * PW_MGMT1 / PW_MGMT3 needs dummy write at least after 5 LR clocks
+	 *
+	 * Note
+	 *
+	 * To avoid extra delay, we want to avoid preemption here,
+	 * but we can't. Because it uses I2C access which is using IRQ
+	 * and sleep. Thus, delay might be more than 5 LR clocks
+	 * see also
+	 *	ak4613_dai_trigger()
+	 */
+	udelay(5000000 / priv->rate);
+
+	snd_soc_component_read(component, PW_MGMT1, &mgmt1);
+	snd_soc_component_read(component, PW_MGMT3, &mgmt3);
+
+	snd_soc_component_write(component, PW_MGMT1, mgmt1);
+	snd_soc_component_write(component, PW_MGMT3, mgmt3);
+}
+
+static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	/*
+	 * FIXME
+	 *
+	 * PW_MGMT1 / PW_MGMT3 needs dummy write at least after 5 LR clocks
+	 * from Power Down Release. Otherwise, Playback volume will be 0dB.
+	 * To avoid complex multiple delay/dummy_write method from
+	 * ak4613_set_bias_level() / SND_SOC_DAPM_DAC_E("DACx", ...),
+	 * call it once here.
+	 *
+	 * But, unfortunately, we can't "write" here because here is atomic
+	 * context (It uses I2C access for writing).
+	 * Thus, use schedule_work() to switching to normal context
+	 * immediately.
+	 *
+	 * Note
+	 *
+	 * Calling ak4613_dummy_write() function might be delayed.
+	 * In such case, ak4613 volume might be temporarily 0dB when
+	 * beggining of playback.
+	 * see also
+	 *	ak4613_dummy_write()
+	 */
+
+	if ((cmd != SNDRV_PCM_TRIGGER_START) &&
+	    (cmd != SNDRV_PCM_TRIGGER_RESUME))
+		return 0;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return  0;
+
+	priv->component = &codec->component;
+	schedule_work(&priv->dummy_write_work);
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops ak4613_dai_ops = {
 	.startup	= ak4613_dai_startup,
 	.shutdown	= ak4613_dai_shutdown,
 	.set_sysclk	= ak4613_dai_set_sysclk,
 	.set_fmt	= ak4613_dai_set_fmt,
+	.trigger	= ak4613_dai_trigger,
 	.hw_params	= ak4613_dai_hw_params,
 };
 
@@ -590,6 +667,7 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	priv->iface		= NULL;
 	priv->cnt		= 0;
 	priv->sysclk		= 0;
+	INIT_WORK(&priv->dummy_write_work, ak4613_dummy_write);
 
 	mutex_init(&priv->lock);
 
-- 
2.15.1
