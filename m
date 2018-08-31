From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas6424: Print full register name in
	error message" to the asoc tree
Date: Fri, 31 Aug 2018 16:24:26 +0100 (BST)
Message-ID: <20180831152426.932A511226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 274A2267965
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:24:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas6424: Print full register name in error message

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

>From 919869214b8e0b24926a278e121879f60df485bb Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Fri, 31 Aug 2018 10:14:06 -0500
Subject: [PATCH] ASoC: tas6424: Print full register name in error message

The current short version of the register name may be
ambiguous when another fault register detection is added.
Use the full name.

While here fix comment about clearing faults, the CLEAR_FAULT
register actually only clears sticky bits, which are only
warnings, fault bits can only cleared by resolving the fault.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas6424.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 14999b999fd3..3315ce8a15e6 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -408,7 +408,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT1, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT1 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT1 register: %d\n", ret);
 		goto out;
 	}
 
@@ -451,7 +451,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 check_global_fault2_reg:
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT2, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT2 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT2 register: %d\n", ret);
 		goto out;
 	}
 
@@ -524,7 +524,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	/* Store current warn value so we can detect any changes next time */
 	tas6424->last_warn = reg;
 
-	/* Clear any faults by toggling the CLEAR_FAULT control bit */
+	/* Clear any warnings by toggling the CLEAR_FAULT control bit */
 	ret = regmap_write_bits(tas6424->regmap, TAS6424_MISC_CTRL3,
 				TAS6424_CLEAR_FAULT, TAS6424_CLEAR_FAULT);
 	if (ret < 0)
-- 
2.19.0.rc1
