From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Remove redundant
	assignments" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:01 +0000
Message-ID: <E1eMdob-0004im-Gq@debutante>
References: <20171206110406.11400-7-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9813C267A26
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:08 +0100 (CET)
In-Reply-To: <20171206110406.11400-7-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Puneeth Prabhu <puneethx.prabhu@intel.com>
Cc: alsa-devel@alsa-project.org, Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Remove redundant assignments

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

>From 45a6008bfcdc3e620dcf1b2330766345097afe9c Mon Sep 17 00:00:00 2001
From: Puneeth Prabhu <puneethx.prabhu@intel.com>
Date: Wed, 6 Dec 2017 16:34:06 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Remove redundant assignments

Assignments for start_nid, end_nid and num_nodes of hdac_device
structure are already done in init.  So, remove the redundant
assignments.

Signed-off-by: Puneeth Prabhu <puneethx.prabhu@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index b706547c46d5..68a4a6b4e68e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1465,10 +1465,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		return -EINVAL;
 	}
 
-	hdev->num_nodes = num_nodes;
-	hdev->start_nid = nid;
-
-	for (i = 0; i < hdev->num_nodes; i++, nid++) {
+	for (i = 0; i < num_nodes; i++, nid++) {
 		unsigned int caps;
 		unsigned int type;
 
@@ -1494,8 +1491,6 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		}
 	}
 
-	hdev->end_nid = nid;
-
 	if (!hdmi->num_pin || !hdmi->num_cvt) {
 		ret = -EIO;
 		goto free_widgets;
-- 
2.15.0
