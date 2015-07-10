From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add helper to update register
	bits with attr RWC" to the asoc tree
Date: Fri, 10 Jul 2015 01:25:43 +0100
Message-ID: <E1ZDM8N-0000Na-Al@debutante>
References: <1436458135-25537-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3E4F2664A5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 02:25:50 +0200 (CEST)
In-Reply-To: <1436458135-25537-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add helper to update register bits with attr RWC

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

>From d15b1ae17c79f682760483b56074e980720f52eb Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 9 Jul 2015 21:38:53 +0530
Subject: [PATCH] ASoC: Intel: Add helper to update register bits with attr RWC

For SKL IPC, we have some register bits with attribute RWC. So we need to
force update them. Add helper to force update this type of registers bits.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp.c | 28 ++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-dsp.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index cc25f4c202af..a627236dd1f5 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -197,6 +197,22 @@ int sst_dsp_shim_update_bits64_unlocked(struct sst_dsp *sst, u32 offset,
 }
 EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits64_unlocked);
 
+/* This is for registers bits with attribute RWC */
+void sst_dsp_shim_update_bits_forced_unlocked(struct sst_dsp *sst, u32 offset,
+				u32 mask, u32 value)
+{
+	unsigned int old, new;
+	u32 ret;
+
+	ret = sst_dsp_shim_read_unlocked(sst, offset);
+
+	old = ret;
+	new = (old & (~mask)) | (value & mask);
+
+	sst_dsp_shim_write_unlocked(sst, offset, new);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits_forced_unlocked);
+
 int sst_dsp_shim_update_bits(struct sst_dsp *sst, u32 offset,
 				u32 mask, u32 value)
 {
@@ -223,6 +239,18 @@ int sst_dsp_shim_update_bits64(struct sst_dsp *sst, u32 offset,
 }
 EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits64);
 
+/* This is for registers bits with attribute RWC */
+void sst_dsp_shim_update_bits_forced(struct sst_dsp *sst, u32 offset,
+				u32 mask, u32 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sst->spinlock, flags);
+	sst_dsp_shim_update_bits_forced_unlocked(sst, offset, mask, value);
+	spin_unlock_irqrestore(&sst->spinlock, flags);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits_forced);
+
 int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 			 u32 target, u32 timeout, char *operation)
 {
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index cc3197be4cf7..1f45f18715c0 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -230,6 +230,8 @@ void sst_dsp_shim_write64(struct sst_dsp *sst, u32 offset, u64 value);
 u64 sst_dsp_shim_read64(struct sst_dsp *sst, u32 offset);
 int sst_dsp_shim_update_bits64(struct sst_dsp *sst, u32 offset,
 				u64 mask, u64 value);
+void sst_dsp_shim_update_bits_forced(struct sst_dsp *sst, u32 offset,
+				u32 mask, u32 value);
 
 /* SHIM Read / Write Unlocked for callers already holding sst lock */
 void sst_dsp_shim_write_unlocked(struct sst_dsp *sst, u32 offset, u32 value);
@@ -240,6 +242,8 @@ void sst_dsp_shim_write64_unlocked(struct sst_dsp *sst, u32 offset, u64 value);
 u64 sst_dsp_shim_read64_unlocked(struct sst_dsp *sst, u32 offset);
 int sst_dsp_shim_update_bits64_unlocked(struct sst_dsp *sst, u32 offset,
 					u64 mask, u64 value);
+void sst_dsp_shim_update_bits_forced_unlocked(struct sst_dsp *sst, u32 offset,
+				u32 mask, u32 value);
 
 /* Internal generic low-level SST IO functions - can be overidden */
 void sst_shim32_write(void __iomem *addr, u32 offset, u32 value);
-- 
2.1.4
