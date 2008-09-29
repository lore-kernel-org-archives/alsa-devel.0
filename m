From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: Use snd_soc_dapm_nc_pin() in Zaurus
	machine drivers
Date: Mon, 29 Sep 2008 14:44:32 +0100
Message-ID: <1222695873-20252-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080929133951.GA20161@rakim.wolfsonmicro.main>
	<1222695873-20252-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2BCA243A9
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 15:44:35 +0200 (CEST)
In-Reply-To: <1222695873-20252-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/corgi.c  |    4 ++--
 sound/soc/pxa/poodle.c |    4 ++--
 sound/soc/pxa/spitz.c  |   14 +++++++-------
 sound/soc/pxa/tosa.c   |    4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 72b7a51..0bceaf6 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -289,8 +289,8 @@ static int corgi_wm8731_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_disable_pin(codec, "LLINEIN");
-	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_nc_pin(codec, "LLINEIN");
+	snd_soc_dapm_nc_pin(codec, "RLINEIN");
 
 	/* Add corgi specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8731_corgi_controls); i++) {
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index f84f7d8..e5adb0e 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -242,8 +242,8 @@ static int poodle_wm8731_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_disable_pin(codec, "LLINEIN");
-	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_nc_pin(codec, "LLINEIN");
+	snd_soc_dapm_nc_pin(codec, "RLINEIN");
 	snd_soc_dapm_enable_pin(codec, "MICIN");
 
 	/* Add poodle specific controls */
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 3d4738c..e0bcc42 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -291,13 +291,13 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	int i, err;
 
 	/* NC codec pins */
-	snd_soc_dapm_disable_pin(codec, "RINPUT1");
-	snd_soc_dapm_disable_pin(codec, "LINPUT2");
-	snd_soc_dapm_disable_pin(codec, "RINPUT2");
-	snd_soc_dapm_disable_pin(codec, "LINPUT3");
-	snd_soc_dapm_disable_pin(codec, "RINPUT3");
-	snd_soc_dapm_disable_pin(codec, "OUT3");
-	snd_soc_dapm_disable_pin(codec, "MONO1");
+	snd_soc_dapm_nc_pin(codec, "RINPUT1");
+	snd_soc_dapm_nc_pin(codec, "LINPUT2");
+	snd_soc_dapm_nc_pin(codec, "RINPUT2");
+	snd_soc_dapm_nc_pin(codec, "LINPUT3");
+	snd_soc_dapm_nc_pin(codec, "RINPUT3");
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "MONO1");
 
 	/* Add spitz specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8750_spitz_controls); i++) {
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 2baaa75..eae2a0f 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -190,8 +190,8 @@ static int tosa_ac97_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_disable_pin(codec, "OUT3");
-	snd_soc_dapm_disable_pin(codec, "MONOOUT");
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "MONOOUT");
 
 	/* add tosa specific controls */
 	for (i = 0; i < ARRAY_SIZE(tosa_controls); i++) {
-- 
1.5.6.5
