From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Attach SYSCLK to DSP
	preloaders" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:22 -0700
Message-ID: <E1bo2SE-0002wT-Nf@finisterre>
References: <1474375956-10443-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D0F82665CC
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:36 +0200 (CEST)
In-Reply-To: <1474375956-10443-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: arizona: Attach SYSCLK to DSP preloaders

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

>From 3577357a1680543b8acb98d69d23e87c1175db2b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 20 Sep 2016 13:52:30 +0100
Subject: [PATCH] ASoC: arizona: Attach SYSCLK to DSP preloaders

Currently SYSCLK is attached to every compressed DAI as this follows the
pattern of attaching clocks to the chips inputs and outputs, however, it is
really the DSP that requires the clock here. As firmware download can be a
significant part of the path startup time for these devices occasionally it
would be desirable to download the firmware in advance of the path being
brought up.

To help facilitate this early firmware loading this patch attaches the
SYSCLK to the DSP preloader widget. This also saves us adding a new route
to SYSCLK every time a new compressed DAI is created.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 1 +
 sound/soc/codecs/cs47l24.c | 2 --
 sound/soc/codecs/wm5102.c  | 1 -
 sound/soc/codecs/wm5110.c  | 2 --
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 69da1ef3a17c..e49955d834f0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -190,6 +190,7 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
 #define ARIZONA_DSP_ROUTES(name) \
 	{ name, NULL, name " Preloader"}, \
+	{ name " Preloader", NULL, "SYSCLK" }, \
 	{ name " Preloader", NULL, name " Aux 1" }, \
 	{ name " Preloader", NULL, name " Aux 2" }, \
 	{ name " Preloader", NULL, name " Aux 3" }, \
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index f8d8139b2d42..9576dbd116ac 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -814,7 +814,6 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "AIF3 Capture", NULL, "SYSCLK" },
 
 	{ "Voice Control DSP", NULL, "DSP3" },
-	{ "Voice Control DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
@@ -823,7 +822,6 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "IN2R PGA", NULL, "IN2R" },
 
 	{ "Audio Trace DSP", NULL, "DSP2" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 16a1c5b46243..8ce76806a78b 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1610,7 +1610,6 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
 	{ "Audio Trace DSP", NULL, "DSP1" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 673dc598c234..5d8c5b67ed42 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1842,10 +1842,8 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
 	{ "Voice Control DSP", NULL, "DSP3" },
-	{ "Voice Control DSP", NULL, "SYSCLK" },
 
 	{ "Audio Trace DSP", NULL, "DSP1" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
-- 
2.9.3
