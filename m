From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Call arizona_init_notifiers
	for all CODECs" to the asoc tree
Date: Thu, 10 Nov 2016 17:28:59 +0000
Message-ID: <E1c4t9n-0005yR-Qi@finisterre>
References: <1478791455-11246-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7B326686A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 18:29:29 +0100 (CET)
In-Reply-To: <1478791455-11246-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Call arizona_init_notifiers for all CODECs

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

>From 88c1886075e069f699c20fbc04ef6f10b8eb8c43 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 10 Nov 2016 15:24:15 +0000
Subject: [PATCH] ASoC: arizona: Call arizona_init_notifiers for all CODECs

The call to arizona_init_notifiers was only added for CODECs that are
generating voice trigger events, however, this is somewhat annoying
for machine drivers that might be used with multiple CODECs as they
need to conditionally register for the notifier, depending on the
CODEC being attached.

As the cost of initialising the notifier is so minimal, and we may
well add other events in the future that apply to more CODECs, simply
do this for all Arizona CODECs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 1 +
 sound/soc/codecs/wm8997.c | 1 +
 sound/soc/codecs/wm8998.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0136234e6e66..72ff291a85be 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1945,6 +1945,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 600595c54fe7..ea8b1bfdf5a0 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1063,6 +1063,7 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
 
 	arizona_init_spk(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 4cccaae6dcfa..1e1d9c1f0371 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1325,6 +1325,7 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
+	arizona_init_notifiers(codec);
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
-- 
2.10.2
