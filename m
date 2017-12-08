From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Change kern log level to avoid
	unwanted messages" to the asoc tree
Date: Fri, 08 Dec 2017 18:50:05 +0000
Message-ID: <E1eNNin-0003Rb-8t@debutante>
References: <1512666160-30729-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7164B266D45
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 19:50:14 +0100 (CET)
In-Reply-To: <1512666160-30729-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, harshapriya.n@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Change kern log level to avoid unwanted messages

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

>From 4362934a75ff2a399fd0bcd75937907115770020 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Fri, 8 Dec 2017 09:30:18 +0530
Subject: [PATCH] ASoC: Intel: Change kern log level to avoid unwanted messages

patch suppresses the warning message "control load not supported"
as this is a debug information to help debug issues in topology.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a072bcf209d2..81923da18ac2 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2908,7 +2908,7 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 		break;
 
 	default:
-		dev_warn(bus->dev, "Control load not supported %d:%d:%d\n",
+		dev_dbg(bus->dev, "Control load not supported %d:%d:%d\n",
 			hdr->ops.get, hdr->ops.put, hdr->ops.info);
 		break;
 	}
-- 
2.15.1
