From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Tie SYSCLK to DRC signal
	activity widgets" to the asoc tree
Date: Sat, 14 May 2016 11:13:01 +0100
Message-ID: <E1b1WZB-0004rB-5P@finisterre>
References: <1463154319-10070-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 176AA260542
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 12:22:16 +0200 (CEST)
In-Reply-To: <1463154319-10070-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Tie SYSCLK to DRC signal activity widgets

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

>From 399e1f25ef9a2b8fc4e55fadb696131f9d92f577 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 13 May 2016 16:45:15 +0100
Subject: [PATCH] ASoC: arizona: Tie SYSCLK to DRC signal activity widgets

The intent is for SYSCLK to be tied to all input and output widgets such
that it turns on whenever the chip is in use. It is not tied to the DRC
signal activity detect virtual outputs, whilst in practice this is
unlikely to cause an issue (as an input will likely also be powered up)
best to correct.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 2 ++
 sound/soc/codecs/wm5102.c  | 1 +
 sound/soc/codecs/wm5110.c  | 2 ++
 sound/soc/codecs/wm8998.c  | 1 +
 4 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 29313780a38a..f1c9f5a54579 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -896,6 +896,8 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
+	{ "DRC2 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 7a539e0529c0..20c84a10a69b 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1713,6 +1713,7 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index dd87af1ffa23..69f5231f625b 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1997,6 +1997,8 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
+	{ "DRC2 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 012396074a8a..3a175b4645cf 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1166,6 +1166,7 @@ static const struct snd_soc_dapm_route wm8998_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
-- 
2.8.1
