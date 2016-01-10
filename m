From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hdac: Increase timeout value for link
	power check" to the asoc tree
Date: Sun, 10 Jan 2016 12:07:42 +0000
Message-ID: <E1aIEmc-0007Ot-Kk@debutante>
References: <1449816267-11910-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22BB82605FF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:48 +0100 (CET)
In-Reply-To: <1449816267-11910-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hdac: Increase timeout value for link power check

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

>From cf8fe58b1066cea668e030d0ab61e4b8eef8b219 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Fri, 18 Dec 2015 15:12:01 +0530
Subject: [PATCH] ALSA: hdac: Increase timeout value for link power check

HW recommends 180us for worst case values for link power up
delay, so change the current delay value from 50 (150us) to 150
(450us)

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/ext/hdac_ext_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 556267e75591..1a55a781270d 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -246,7 +246,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	int mask = (1 << AZX_MLCTL_CPA);
 
 	udelay(3);
-	timeout = 50;
+	timeout = 150;
 
 	do {
 		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
-- 
2.7.0.rc3
