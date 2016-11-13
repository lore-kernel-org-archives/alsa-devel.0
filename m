From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Make static string arrays 'const
	'char * const []'" to the asoc tree
Date: Sun, 13 Nov 2016 11:40:54 +0000
Message-ID: <E1c5t9a-0008NF-Mt@finisterre>
References: <1478956993-10065-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0172664F7
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 12:41:22 +0100 (CET)
In-Reply-To: <1478956993-10065-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: Make static string arrays 'const 'char * const []'

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

>From 92be58106e5d750b97567bea7171f5aee74a678a Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 12 Nov 2016 14:23:13 +0100
Subject: [PATCH] ASoC: pxa: Make static string arrays 'const 'char * const []'

const char * const [] is the preferred type for static string arrays since
this states explicitly that the individual entries are not going to be
changed. Due to limitations in the ASoC API it was not possible to use it
for enum text arrays. Commit 87023ff74 ('ASoC: Declare const properly for
enum texts') changed this, but most drivers still use 'const char
* []' as the type for their enum text arrays.

Change these occurrences of 'static * const char * []' to 'static const
char * const []'.

The conversion was done automatically using the following coccinelle semantic
patch:
// <smpl>
@disable optional_qualifier@
identifier s;
@@
 static
-const char *
+const char * const
 s[] = ...;
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/corgi.c    | 6 +++---
 sound/soc/pxa/magician.c | 2 +-
 sound/soc/pxa/poodle.c   | 4 ++--
 sound/soc/pxa/spitz.c    | 6 +++---
 sound/soc/pxa/tosa.c     | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index dcbb7aa9830c..311774e9ca46 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -244,9 +244,9 @@ static const struct snd_soc_dapm_route corgi_audio_map[] = {
 	{"MICIN", NULL, "Line Jack"},
 };
 
-static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
-	"Off"};
-static const char *spk_function[] = {"On", "Off"};
+static const char * const jack_function[] = {"Headphone", "Mic", "Line",
+	"Headset", "Off"};
+static const char * const spk_function[] = {"On", "Off"};
 static const struct soc_enum corgi_enum[] = {
 	SOC_ENUM_SINGLE_EXT(5, jack_function),
 	SOC_ENUM_SINGLE_EXT(2, spk_function),
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 62b8377a9d2b..2d4d4455fe87 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -376,7 +376,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"VINM", NULL, "Call Mic"},
 };
 
-static const char *input_select[] = {"Call Mic", "Headset Mic"};
+static const char * const input_select[] = {"Call Mic", "Headset Mic"};
 static const struct soc_enum magician_in_sel_enum =
 	SOC_ENUM_SINGLE_EXT(2, input_select);
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 4b3b714f5ee7..a879aba0691f 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -209,8 +209,8 @@ static const struct snd_soc_dapm_route poodle_audio_map[] = {
 	{"MICIN", NULL, "Microphone"},
 };
 
-static const char *jack_function[] = {"Off", "Headphone"};
-static const char *spk_function[] = {"Off", "On"};
+static const char * const jack_function[] = {"Off", "Headphone"};
+static const char * const spk_function[] = {"Off", "On"};
 static const struct soc_enum poodle_enum[] = {
 	SOC_ENUM_SINGLE_EXT(2, jack_function),
 	SOC_ENUM_SINGLE_EXT(2, spk_function),
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 0e02634c8b7f..07d77cddac60 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -241,9 +241,9 @@ static const struct snd_soc_dapm_route spitz_audio_map[] = {
 	{"LINPUT1", NULL, "Line Jack"},
 };
 
-static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
-	"Off"};
-static const char *spk_function[] = {"On", "Off"};
+static const char * const jack_function[] = {"Headphone", "Mic", "Line",
+	"Headset", "Off"};
+static const char * const spk_function[] = {"On", "Off"};
 static const struct soc_enum spitz_enum[] = {
 	SOC_ENUM_SINGLE_EXT(5, jack_function),
 	SOC_ENUM_SINGLE_EXT(2, spk_function),
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index c508f024ecfb..08b0cf50e91a 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -170,9 +170,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Mic Bias", NULL, "Headset Jack"},
 };
 
-static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
-	"Off"};
-static const char *spk_function[] = {"On", "Off"};
+static const char * const jack_function[] = {"Headphone", "Mic", "Line",
+	"Headset", "Off"};
+static const char * const spk_function[] = {"On", "Off"};
 static const struct soc_enum tosa_enum[] = {
 	SOC_ENUM_SINGLE_EXT(5, jack_function),
 	SOC_ENUM_SINGLE_EXT(2, spk_function),
-- 
2.10.2
