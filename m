From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: fix sst_memcpy32 wrong with
	non-4x bytes issue" to the asoc tree
Date: Wed, 16 Dec 2015 13:26:46 +0000
Message-ID: <E1a9C6Q-0003IB-5m@debutante>
References: <1450103233-8304-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 076522657F9
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 14:26:56 +0100 (CET)
In-Reply-To: <1450103233-8304-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: fix sst_memcpy32 wrong with non-4x bytes issue

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

>From 1cf8dfd90fe50ac660f79d4b94f47b8e721a1178 Mon Sep 17 00:00:00 2001
From: Jie Yang <yang.jie@intel.com>
Date: Mon, 14 Dec 2015 22:27:13 +0800
Subject: [PATCH] ASoC: Intel: sst: fix sst_memcpy32 wrong with non-4x bytes
 issue

sst_memcpy32() only copied bytes/4 32bits, which means it dropped
the remaining bytes%4 bytes wrongly.

Here add copying those missing bytes, first to a 32bits tmp, and
then write the tmp to 32bits iomem.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-firmware.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index bee04a9707d8..ef4881e7753a 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -51,8 +51,22 @@ struct sst_dma {
 
 static inline void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
+	u32 tmp = 0;
+	int i, m, n;
+	const u8 *src_byte = src;
+
+	m = bytes / 4;
+	n = bytes % 4;
+
 	/* __iowrite32_copy use 32bit size values so divide by 4 */
-	__iowrite32_copy((void *)dest, src, bytes/4);
+	__iowrite32_copy((void *)dest, src, m);
+
+	if (n) {
+		for (i = 0; i < n; i++)
+			tmp |= (u32)*(src_byte + m * 4 + i) << (i * 8);
+		__iowrite32_copy((void *)(dest + m * 4), &tmp, 1);
+	}
+
 }
 
 static void sst_dma_transfer_complete(void *arg)
-- 
2.6.2
