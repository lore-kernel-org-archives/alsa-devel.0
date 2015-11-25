From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: mark SND_SOC_BYTES_EXT as
	deprecated" to the asoc tree
Date: Wed, 25 Nov 2015 12:59:58 +0000
Message-ID: <E1a1Zfy-0002n4-FD@debutante>
References: <1448293951-32071-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A721260870
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:08 +0100 (CET)
In-Reply-To: <1448293951-32071-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: core: mark SND_SOC_BYTES_EXT as deprecated

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

>From 50a4f98d3452ea3818eb364f9c34a9de139df654 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 23 Nov 2015 21:22:29 +0530
Subject: [PATCH] ASoC: core: mark SND_SOC_BYTES_EXT as deprecated

Since we have SND_SOC_BYTES_TLV control to lets devices have
larger size data sent, we do not need SND_SOC_BYTES_EXT with 512
byte limitation so mark it deprecated

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8b4b9c8b1d2..6dbd24a36ef8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -293,6 +293,9 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
+/*
+ * SND_SOC_BYTES_EXT is deprecated, please USE SND_SOC_BYTES_TLV instead
+ */
 #define SND_SOC_BYTES_EXT(xname, xcount, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_bytes_info_ext, \
-- 
2.6.2
