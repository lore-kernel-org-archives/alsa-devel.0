From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Do not check dev_type
	for dmic link type" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:11 +0000
Message-ID: <E1eMdol-0004kq-JX@debutante>
References: <20171206110406.11400-5-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 49F4A267A1F
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:21 +0100 (CET)
In-Reply-To: <20171206110406.11400-5-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Do not check dev_type for dmic link type

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

>From e02b03303f13b6a571f01b4d84b69440696d2dde Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Wed, 6 Dec 2017 16:34:04 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Do not check dev_type for dmic link
 type

Some BIOS have inconsistent dev_type value for DMIC link type.
Since there is only one device type for DMIC link type, remove device
type check if link type is NHLT_LINK_DMIC.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index d14c50a60289..3eaac41090ca 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -119,11 +119,16 @@ static bool skl_check_ep_match(struct device *dev, struct nhlt_endpoint *epnt,
 
 	if ((epnt->virtual_bus_id == instance_id) &&
 			(epnt->linktype == link_type) &&
-			(epnt->direction == dirn) &&
-			(epnt->device_type == dev_type))
-		return true;
-	else
-		return false;
+			(epnt->direction == dirn)) {
+		/* do not check dev_type for DMIC link type */
+		if (epnt->linktype == NHLT_LINK_DMIC)
+			return true;
+
+		if (epnt->device_type == dev_type)
+			return true;
+	}
+
+	return false;
 }
 
 struct nhlt_specific_cfg
-- 
2.15.0
