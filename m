From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix bug in playback when
	suspend" to the asoc tree
Date: Thu, 04 Aug 2016 22:09:12 +0100
Message-ID: <E1bVPtA-0007Ib-1Q@debutante>
References: <1470300727-19998-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F970267981
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 23:09:18 +0200 (CEST)
In-Reply-To: <1470300727-19998-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix bug in playback when suspend

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

>From ca6ac305f017472a172e53345264abdb495eba46 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Thu, 4 Aug 2016 16:52:06 +0800
Subject: [PATCH] ASoC: nau8825: fix bug in playback when suspend

In chromium, the following steps will make codec function fail.
\1. plug in headphones, Play music
\2. run "powerd_dbus_suspend"
\3. resume from S3
After resume, the jack detection will restart and make configuration
for the headset. Meanwhile, the playback prepares and starts to work.
The two sequences will conflict and make wrong register configuration.

Originally, the driver adds protection for the case when it finds
the playback is active. But the "powerd_dbus_suspend" command will
close the pcm stream before suspend. Therefore, the driver can't
detect the playback after resume, and the protection not works.
For the issue, the driver raises protection every time after resume.
The protection will release after jack detection and configuration
completes, and then the playback just will goes on.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 51 +++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5c9707ac4bbf..20d2f1578b87 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -212,31 +212,6 @@ static const unsigned short logtable[256] = {
 	0xfa2f, 0xfaea, 0xfba5, 0xfc60, 0xfd1a, 0xfdd4, 0xfe8e, 0xff47
 };
 
-static struct snd_soc_dai *nau8825_get_codec_dai(struct nau8825 *nau8825)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(nau8825->dapm);
-	struct snd_soc_component *component = &codec->component;
-	struct snd_soc_dai *codec_dai, *_dai;
-
-	list_for_each_entry_safe(codec_dai, _dai, &component->dai_list, list) {
-		if (!strncmp(codec_dai->name, NUVOTON_CODEC_DAI,
-			strlen(NUVOTON_CODEC_DAI)))
-			return codec_dai;
-	}
-	return NULL;
-}
-
-static bool nau8825_dai_is_active(struct nau8825 *nau8825)
-{
-	struct snd_soc_dai *codec_dai = nau8825_get_codec_dai(nau8825);
-
-	if (codec_dai) {
-		if (codec_dai->playback_active || codec_dai->capture_active)
-			return true;
-	}
-	return false;
-}
-
 /**
  * nau8825_sema_acquire - acquire the semaphore of nau88l25
  * @nau8825:  component to register the codec private data with
@@ -1205,6 +1180,8 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val_len = 0;
 
+	nau8825_sema_acquire(nau8825, 2 * HZ);
+
 	switch (params_width(params)) {
 	case 16:
 		val_len |= NAU8825_I2S_DL_16;
@@ -1225,6 +1202,9 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
 		NAU8825_I2S_DL_MASK, val_len);
 
+	/* Release the semaphone. */
+	nau8825_sema_release(nau8825);
+
 	return 0;
 }
 
@@ -1234,6 +1214,8 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 	unsigned int ctrl1_val = 0, ctrl2_val = 0;
 
+	nau8825_sema_acquire(nau8825, 2 * HZ);
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		ctrl2_val |= NAU8825_I2S_MS_MASTER;
@@ -1282,6 +1264,9 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
 		NAU8825_I2S_MS_MASK, ctrl2_val);
 
+	/* Release the semaphone. */
+	nau8825_sema_release(nau8825);
+
 	return 0;
 }
 
@@ -2241,20 +2226,8 @@ static int __maybe_unused nau8825_resume(struct snd_soc_codec *codec)
 
 	regcache_cache_only(nau8825->regmap, false);
 	regcache_sync(nau8825->regmap);
-	if (nau8825_is_jack_inserted(nau8825->regmap)) {
-		/* If the jack is inserted, we need to check whether the play-
-		 * back is active before suspend. If active, the driver has to
-		 * raise the protection for cross talk function to avoid the
-		 * playback recovers before cross talk process finish. Other-
-		 * wise, the playback will be interfered by cross talk func-
-		 * tion. It is better to apply hardware related parameters
-		 * before starting playback or record.
-		 */
-		if (nau8825_dai_is_active(nau8825)) {
-			nau8825->xtalk_protect = true;
-			nau8825_sema_acquire(nau8825, 0);
-		}
-	}
+	nau8825->xtalk_protect = true;
+	nau8825_sema_acquire(nau8825, 0);
 	enable_irq(nau8825->irq);
 
 	return 0;
-- 
2.8.1
