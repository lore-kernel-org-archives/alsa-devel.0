From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: constify snd_soc_ops structures"
	to the asoc tree
Date: Wed, 15 Mar 2017 18:13:54 +0000
Message-ID: <E1coDQo-0002Rd-K5@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 788EB2670CD
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:14:02 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: constify snd_soc_ops structures

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

>From 943b73112dfdd6747871a3347f70de6876f4dd4b Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Tue, 14 Mar 2017 01:16:40 +0530
Subject: [PATCH] ASoC: pxa: constify snd_soc_ops structures

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

The .o files did not compile for all the changed .c files.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/brownstone.c | 2 +-
 sound/soc/pxa/corgi.c      | 2 +-
 sound/soc/pxa/hx4700.c     | 2 +-
 sound/soc/pxa/imote2.c     | 2 +-
 sound/soc/pxa/magician.c   | 4 ++--
 sound/soc/pxa/poodle.c     | 2 +-
 sound/soc/pxa/raumfeld.c   | 2 +-
 sound/soc/pxa/spitz.c      | 2 +-
 sound/soc/pxa/tosa.c       | 2 +-
 sound/soc/pxa/z2.c         | 2 +-
 sound/soc/pxa/zylonite.c   | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index b6cb9950f05d..9a3f5b799720 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -74,7 +74,7 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 }
 
 /* machine stream operations */
-static struct snd_soc_ops brownstone_ops = {
+static const struct snd_soc_ops brownstone_ops = {
 	.hw_params = brownstone_wm8994_hw_params,
 };
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 311774e9ca46..054e0d65db9d 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -154,7 +154,7 @@ static int corgi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops corgi_ops = {
+static const struct snd_soc_ops corgi_ops = {
 	.startup = corgi_startup,
 	.hw_params = corgi_hw_params,
 	.shutdown = corgi_shutdown,
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 85483049b916..a9ac881c2e14 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -79,7 +79,7 @@ static int hx4700_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops hx4700_ops = {
+static const struct snd_soc_ops hx4700_ops = {
 	.hw_params = hx4700_hw_params,
 };
 
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 9d0e40771ef5..78475376f971 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -42,7 +42,7 @@ static int imote2_asoc_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops imote2_asoc_ops = {
+static const struct snd_soc_ops imote2_asoc_ops = {
 	.hw_params = imote2_asoc_hw_params,
 };
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 2d4d4455fe87..2fc012b06c43 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -255,12 +255,12 @@ static int magician_capture_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops magician_capture_ops = {
+static const struct snd_soc_ops magician_capture_ops = {
 	.startup = magician_startup,
 	.hw_params = magician_capture_hw_params,
 };
 
-static struct snd_soc_ops magician_playback_ops = {
+static const struct snd_soc_ops magician_playback_ops = {
 	.startup = magician_startup,
 	.hw_params = magician_playback_hw_params,
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index a879aba0691f..b6693f32fc02 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -129,7 +129,7 @@ static int poodle_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops poodle_ops = {
+static const struct snd_soc_ops poodle_ops = {
 	.startup = poodle_startup,
 	.hw_params = poodle_hw_params,
 	.shutdown = poodle_shutdown,
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 47c91730e93c..111a907c4eb9 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -132,7 +132,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops raumfeld_cs4270_ops = {
+static const struct snd_soc_ops raumfeld_cs4270_ops = {
 	.startup = raumfeld_cs4270_startup,
 	.shutdown = raumfeld_cs4270_shutdown,
 	.hw_params = raumfeld_cs4270_hw_params,
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d38a2b519c52..1671da648e95 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -156,7 +156,7 @@ static int spitz_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops spitz_ops = {
+static const struct snd_soc_ops spitz_ops = {
 	.startup = spitz_startup,
 	.hw_params = spitz_hw_params,
 };
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 1812748b75bf..ae9c12e1ea2a 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -85,7 +85,7 @@ static int tosa_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_soc_ops tosa_ops = {
+static const struct snd_soc_ops tosa_ops = {
 	.startup = tosa_startup,
 };
 
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 6d88d9acc666..5b0eccd2b4dd 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -152,7 +152,7 @@ static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static struct snd_soc_ops z2_ops = {
+static const struct snd_soc_ops z2_ops = {
 	.hw_params = z2_hw_params,
 };
 
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 6fbcdf02c88d..ba468e560dd2 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -132,7 +132,7 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops zylonite_voice_ops = {
+static const struct snd_soc_ops zylonite_voice_ops = {
 	.hw_params = zylonite_voice_hw_params,
 };
 
-- 
2.11.0
