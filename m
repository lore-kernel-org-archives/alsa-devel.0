From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Revert "Fix DMIC
	map headsetmic mapping"" to the asoc tree
Date: Mon,  7 Jan 2019 19:24:39 +0000 (GMT)
Message-ID: <20190107192439.2B9991127491@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9F62266C04
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 20:24:39 +0100 (CET)
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
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Revert "Fix DMIC map headsetmic mapping"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From aee48a9ffa5a128bf4e433c57c39e015ea5b0208 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 30 Dec 2018 00:00:22 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Revert "Fix DMIC map headsetmic
 mapping"

Commit 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map
headsetmic mapping"), changed the headsetmic mapping from IN3P to IN2P,
this was based on the observation that all bytcr_rt5651 devices I have
access to (7 devices) where all using IN3P for the headsetmic. This was
an attempt to unifify / simplify the mapping, but it was wrong.

None of those devices was actually using a digital internal mic. Now I've
access to a Point of View TAB-P1006W-232 (v1.0) tabler, which does use a
DMIC and it does have its headsetmic connected to IN2P, showing that the
original mapping was correct, so this commit reverts the change changing
the mapping back to IN2P.

Fixes: 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map ... mapping")
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e528995668b7..0ed844f2ad01 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -266,7 +266,7 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 	{"DMIC L1", NULL, "Internal Mic"},
 	{"DMIC R1", NULL, "Internal Mic"},
-	{"IN3P", NULL, "Headset Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
-- 
2.20.1
