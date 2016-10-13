From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4270: fix DAPM stream name mismatch"
	to the asoc tree
Date: Thu, 13 Oct 2016 09:40:16 +0200
Message-ID: <E1buaci-00026O-Sz@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE66265119
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 09:40:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Murray Foster <mrafoster@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4270: fix DAPM stream name mismatch

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

>From aa5f920993bda2095952177eea79bc8e58ae6065 Mon Sep 17 00:00:00 2001
From: murray foster <mrafoster@gmail.com>
Date: Sun, 9 Oct 2016 13:28:45 -0700
Subject: [PATCH] ASoC: cs4270: fix DAPM stream name mismatch

Mismatching stream names in DAPM route and widget definitions are
causing compilation errors. Fixing these names allows the cs4270
driver to compile and function.

[Errors must be at probe time not compile time -- broonie]

Signed-off-by: Murray Foster <mrafoster@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/cs4270.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 18baea2f7d65..84f86745c30e 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -148,11 +148,11 @@ SND_SOC_DAPM_OUTPUT("AOUTR"),
 };
 
 static const struct snd_soc_dapm_route cs4270_dapm_routes[] = {
-	{ "Capture", NULL, "AINA" },
-	{ "Capture", NULL, "AINB" },
+	{ "Capture", NULL, "AINL" },
+	{ "Capture", NULL, "AINR" },
 
-	{ "AOUTA", NULL, "Playback" },
-	{ "AOUTB", NULL, "Playback" },
+	{ "AOUTL", NULL, "Playback" },
+	{ "AOUTR", NULL, "Playback" },
 };
 
 /**
-- 
2.9.3
