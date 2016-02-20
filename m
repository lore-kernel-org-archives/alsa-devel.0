From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix pointer scaling" to
	the asoc tree
Date: Sun, 21 Feb 2016 02:16:25 +0900
Message-ID: <E1aXB8r-0008Tl-Dm@finisterre>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D6962651FD
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:30 +0100 (CET)
In-Reply-To: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix pointer scaling

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

>From 65b4bcb82967fd5a60694c3477e58a04a9170aea Mon Sep 17 00:00:00 2001
From: Alan <gnomes@lxorguk.ukuu.org.uk>
Date: Fri, 19 Feb 2016 11:42:32 +0530
Subject: [PATCH] ASoC: Intel: Skylake: fix pointer scaling

skl_tplg_tlv_control_set does pointer maths on data but forgets that data
is not uint8_t so the maths is already scaled in the pointer type.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 4624556..b77c253 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -950,7 +950,7 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 				return -EFAULT;
 		} else {
 			if (copy_from_user(ac->params,
-					   data + 2 * sizeof(u32), size))
+					   data + 2, size))
 				return -EFAULT;
 		}
 
-- 
2.7.0
