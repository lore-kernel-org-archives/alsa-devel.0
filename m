From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxt: Add route change to
	da7219_max98357a machine" to the asoc tree
Date: Sat, 04 Feb 2017 13:12:46 +0100
Message-ID: <E1cZzCw-0004Rj-6r@finisterre>
References: <1474379180-7132-8-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F145D266C5B
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 13:13:05 +0100 (CET)
In-Reply-To: <1474379180-7132-8-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxt: Add route change to da7219_max98357a machine

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

>From 6d707a74a79c7698bd3b797586c2f6ae55eae56c Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 24 Jan 2017 21:49:13 +0530
Subject: [PATCH] ASoC: Intel: bxt: Add route change to da7219_max98357a
 machine

To support MST moved pin to port, this changes the routes based on
port. So change the route in bxt_da7219_max98357a machine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 02439ace3519..876d82d4a39e 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -84,9 +84,9 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 	{"codec0_in", NULL, "ssp1 Rx"},
 	{"ssp1 Rx", NULL, "Capture"},
 
-	{"HDMI1", NULL, "hif5 Output"},
-	{"HDMI2", NULL, "hif6 Output"},
-	{"HDMI3", NULL, "hif7 Output"},
+	{"HDMI1", NULL, "hif5-0 Output"},
+	{"HDMI2", NULL, "hif6-0 Output"},
+	{"HDMI2", NULL, "hif7-0 Output"},
 
 	{"hifi3", NULL, "iDisp3 Tx"},
 	{"iDisp3 Tx", NULL, "iDisp3_out"},
-- 
2.11.0
