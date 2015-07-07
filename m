From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add subsequence in topology"
	to the asoc tree
Date: Tue, 07 Jul 2015 14:58:09 +0100
Message-ID: <E1ZCTNx-0005dd-Jq@finisterre>
References: <1435595806-7000-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73219265749
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:20 +0200 (CEST)
In-Reply-To: <1435595806-7000-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add subsequence in topology

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

>From f5a2ee50635baabcb88a559ae1ced69d5d8ef6eb Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 29 Jun 2015 17:36:44 +0100
Subject: [PATCH] ASoC: topology: Add subsequence in topology

Some widgets may need sorting within, So add this support in topology.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 1 +
 sound/soc/soc-topology.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 1221520..7ae13fb 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -347,6 +347,7 @@ struct snd_soc_tplg_dapm_widget {
 	__le32 reg;		/* negative reg = no direct dapm */
 	__le32 shift;		/* bits to shift */
 	__le32 mask;		/* non-shifted mask */
+	__le32 subseq;		/* sort within widget type */
 	__u32 invert;		/* invert the power bit */
 	__u32 ignore_suspend;	/* kept enabled over suspend */
 	__u16 event_flags;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d096068..f38f111 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1351,6 +1351,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	template.reg = w->reg;
 	template.shift = w->shift;
 	template.mask = w->mask;
+	template.subseq = w->subseq;
 	template.on_val = w->invert ? 0 : 1;
 	template.off_val = w->invert ? 1 : 0;
 	template.ignore_suspend = w->ignore_suspend;
-- 
2.1.4
