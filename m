From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: macro for uniperif tdm regs
	access" to the asoc tree
Date: Tue, 12 Apr 2016 03:01:05 +0100
Message-ID: <E1apnda-0002LM-02@debutante>
References: <1460021136-27822-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B705A26578F
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 04:01:10 +0200 (CEST)
In-Reply-To: <1460021136-27822-2-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: macro for uniperif tdm regs access

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

>From 38535e8e6962405b7d8a365f2f367f62bca98565 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:30 +0200
Subject: [PATCH] ASoC: sti: macro for uniperif tdm regs access

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 1f82faafb869..400788bc9190 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1101,6 +1101,118 @@
 		UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip), value)
 
 /*
+ * UNIPERIF_TDM_ENABLE
+ */
+#define UNIPERIF_TDM_ENABLE_OFFSET(ip) 0x0118
+#define GET_UNIPERIF_TDM_ENABLE(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
+#define SET_UNIPERIF_TDM_ENABLE(ip, value) \
+	writel_relaxed(value, ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
+
+/* TDM_ENABLE */
+#define UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip) 0x0
+#define UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip) 0x1
+#define GET_UNIPERIF_TDM_ENABLE_EN_TDM(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip))
+#define SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 1)
+#define SET_UNIPERIF_TDM_ENABLE_TDM_DISABLE(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 0)
+
+/*
+ * UNIPERIF_TDM_FS_REF_FREQ
+ */
+#define UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip) 0x011c
+#define GET_UNIPERIF_TDM_FS_REF_FREQ(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ(ip, value) \
+	writel_relaxed(value, ip->base + \
+			UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
+
+/* REF_FREQ */
+#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip) 0x0
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) 0
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) 1
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) 2
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) 3
+#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip) 0x3
+#define GET_UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip))
+
+/*
+ * UNIPERIF_TDM_FS_REF_DIV
+ */
+#define UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip) 0x0120
+#define GET_UNIPERIF_TDM_FS_REF_DIV(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
+#define SET_UNIPERIF_TDM_FS_REF_DIV(ip, value) \
+		writel_relaxed(value, ip->base + \
+			UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
+
+/* NUM_TIMESLOT */
+#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip) 0x0
+#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip) 0xff
+#define GET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip))
+#define SET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip, value) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip), value)
+
+/*
+ * UNIPERIF_TDM_WORD_POS_X_Y
+ * 32 bits of UNIPERIF_TDM_WORD_POS_X_Y register shall be set in 1 shot
+ */
+#define UNIPERIF_TDM_WORD_POS_1_2_OFFSET(ip) 0x013c
+#define UNIPERIF_TDM_WORD_POS_3_4_OFFSET(ip) 0x0140
+#define UNIPERIF_TDM_WORD_POS_5_6_OFFSET(ip) 0x0144
+#define UNIPERIF_TDM_WORD_POS_7_8_OFFSET(ip) 0x0148
+#define GET_UNIPERIF_TDM_WORD_POS(ip, words) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
+#define SET_UNIPERIF_TDM_WORD_POS(ip, words, value) \
+		writel_relaxed(value, ip->base + \
+		UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
+/*
  * uniperipheral IP capabilities
  */
 
-- 
2.8.0.rc3
