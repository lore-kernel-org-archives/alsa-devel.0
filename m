From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add utility function to check
	if an input is analog" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:39 +0100
Message-ID: <E1ZcItf-0007pZ-WC@finisterre>
References: <1442408383-31682-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E43261A8C
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:49 +0200 (CEST)
In-Reply-To: <1442408383-31682-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add utility function to check if an input is analog

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

>From 002b083b8da96fd6c546fab2608803e7ce47627d Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 16 Sep 2015 13:59:41 +0100
Subject: [PATCH] ASoC: arizona: Add utility function to check if an input is
 analog

We will occasionally require to take different action based on if an
input is analog or digital so add a helper function to return if an
input is analog.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 9 +++++++++
 sound/soc/codecs/arizona.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1bc19f1..ac21b85 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -691,6 +691,15 @@ static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 				    ARIZONA_IN_VU, val);
 }
 
+bool arizona_input_analog(struct snd_soc_codec *codec, int shift)
+{
+	unsigned int reg = ARIZONA_IN1L_CONTROL + ((shift / 2) * 8);
+	unsigned int val = snd_soc_read(codec, reg);
+
+	return !(val & ARIZONA_IN1_MODE_MASK);
+}
+EXPORT_SYMBOL_GPL(arizona_input_analog);
+
 int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		  int event)
 {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index ada0a41..7b68d05 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -294,4 +294,6 @@ extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 int arizona_set_output_mode(struct snd_soc_codec *codec, int output,
 			    bool diff);
 
+extern bool arizona_input_analog(struct snd_soc_codec *codec, int shift);
+
 #endif
-- 
2.5.0
