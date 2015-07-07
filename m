From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: add private data to manifest"
	to the asoc tree
Date: Tue, 07 Jul 2015 14:58:08 +0100
Message-ID: <E1ZCTNw-0005dA-Gr@finisterre>
References: <1435595806-7000-4-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A49726574A
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:21 +0200 (CEST)
In-Reply-To: <1435595806-7000-4-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: add private data to manifest

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

>From cabb9294a5a9a856a75ec5270a9930e66d28b001 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 29 Jun 2015 17:36:46 +0100
Subject: [PATCH] ASoC: topology: add private data to manifest

The topology file manifest should include a private data field. This
allows vendors to specify vendor data in the manifest, like
timestamps, hashes, additional information for removing platform
configuration out of drivers and making these configurable per platform

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 7ae13fb..d550c8d 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -238,6 +238,7 @@ struct snd_soc_tplg_manifest {
 	__le32 graph_elems;	/* number of graph elements */
 	__le32 dai_elems;	/* number of DAI elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 /*
-- 
2.1.4
