From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: pxa: Make static string arrays 'const
	'char * const []'
Date: Sat, 12 Nov 2016 14:23:13 +0100
Message-ID: <1478956993-10065-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AC8A6260083
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 14:23:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/pxa/corgi.c    | 6 +++---
 sound/soc/pxa/magician.c | 2 +-
 sound/soc/pxa/poodle.c   | 4 ++--
 sound/soc/pxa/spitz.c    | 6 +++---
 sound/soc/pxa/tosa.c     | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index dcbb7aa..311774e 100644
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
index 62b8377..2d4d445 100644
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
index 4b3b714..a879aba 100644
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
index 0e02634..07d77cd 100644
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
index daed981..2e312c6 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -169,9 +169,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
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
2.1.4
