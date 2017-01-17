From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Use DMI name for sound card long
	name in Broadwell machine driver" to the asoc tree
Date: Tue, 17 Jan 2017 18:45:09 +0000
Message-ID: <E1cTYkn-0008Rg-Se@debutante>
References: <92fa36740f6bafbbdcbaf56c2edd56bcd182df21.1481856472.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 124BD2665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:20 +0100 (CET)
In-Reply-To: <92fa36740f6bafbbdcbaf56c2edd56bcd182df21.1481856472.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Use DMI name for sound card long name in Broadwell machine driver

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

>From 3122c66fd2159f4ab210da8d95465af2f145fad7 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Sat, 14 Jan 2017 16:13:09 +0800
Subject: [PATCH] ASoC: Intel: Use DMI name for sound card long name in
 Broadwell machine driver

Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to
use DMI info to make the sound card long name.

For example, here are the changed long name for two Broadwell-based
machines:
Dell XPS-13(2015): DellInc.-XPS139343-01-0310JH
Intel WilsonBeach: Intel Corp.-BroadwellClientplatform-0.1-WilsonBeachSDS

They still share the same card name "broadwell-rt286".

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 4d7e9decfa92..faf865bb1765 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -270,6 +270,8 @@ static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	broadwell_rt286.dev = &pdev->dev;
 
+	snd_soc_set_dmi_name(&broadwell_rt286, NULL);
+
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
-- 
2.11.0
