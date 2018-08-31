From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas6424: Save last fault register even
	when clear" to the asoc tree
Date: Fri, 31 Aug 2018 16:24:20 +0100 (BST)
Message-ID: <20180831152420.ECD3311226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5615A267965
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:24:21 +0200 (CEST)
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
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas6424: Save last fault register even when clear

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

>From d40e3e9e44db4b3c8777f3b515ba6097ba26e3b2 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Fri, 31 Aug 2018 10:14:05 -0500
Subject: [PATCH] ASoC: tas6424: Save last fault register even when clear

When there is no fault bit set in a fault register we skip the fault
reporting section for that register. This also skips over saving that
registers value. We save the value so we will not double report an
error, but if an error clears then returns we will also not report it
as we did not save the all cleared register value. Fix this by saving
the fault register value in the all clear path.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/tas6424.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 14999b999fd3..0d6145549a98 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -424,8 +424,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_FAULT_PVDD_UV |
 	       TAS6424_FAULT_VBAT_UV;
 
-	if (reg)
+	if (!reg) {
+		tas6424->last_fault1 = reg;
 		goto check_global_fault2_reg;
+	}
 
 	/*
 	 * Only flag errors once for a given occurrence. This is needed as
@@ -461,8 +463,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_FAULT_OTSD_CH3 |
 	       TAS6424_FAULT_OTSD_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_fault2 = reg;
 		goto check_warn_reg;
+	}
 
 	if ((reg & TAS6424_FAULT_OTSD) && !(tas6424->last_fault2 & TAS6424_FAULT_OTSD))
 		dev_crit(dev, "experienced a global overtemp shutdown\n");
@@ -497,8 +501,10 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	       TAS6424_WARN_VDD_OTW_CH3 |
 	       TAS6424_WARN_VDD_OTW_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_warn = reg;
 		goto out;
+	}
 
 	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
 		dev_warn(dev, "experienced a VDD under voltage condition\n");
-- 
2.19.0.rc1
