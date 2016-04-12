From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix ibs/obs calc for
	non-integral sampling rates" to the asoc tree
Date: Tue, 12 Apr 2016 07:30:52 +0100
Message-ID: <E1aprqe-0008DJ-TZ@debutante>
References: <1460437293-8509-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE4C2654E6
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 08:31:04 +0200 (CEST)
In-Reply-To: <1460437293-8509-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix ibs/obs calc for non-integral sampling rates

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

>From f0c8e1d9c4f473dfc771a613b602f1841afe8f8b Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 12 Apr 2016 10:31:23 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix ibs/obs calc for non-integral
 sampling rates

FW expects sampling rate rounded up to next higher integer value
when calculating ibs/obs. For example for 44.1k, it should be
rounded up to 45 to calculate ibs/obs.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 5a85f3a4699b..cdb78b7e5a14 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -239,6 +239,7 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 {
 	int multiplier = 1;
 	struct skl_module_fmt *in_fmt, *out_fmt;
+	int in_rate, out_rate;
 
 
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
@@ -249,15 +250,24 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
-	mcfg->ibs = (in_fmt->s_freq / 1000) *
-				(mcfg->in_fmt->channels) *
-				(mcfg->in_fmt->bit_depth >> 3) *
-				multiplier;
-
-	mcfg->obs = (mcfg->out_fmt->s_freq / 1000) *
-				(mcfg->out_fmt->channels) *
-				(mcfg->out_fmt->bit_depth >> 3) *
-				multiplier;
+
+	if (in_fmt->s_freq % 1000)
+		in_rate = (in_fmt->s_freq / 1000) + 1;
+	else
+		in_rate = (in_fmt->s_freq / 1000);
+
+	mcfg->ibs = in_rate * (mcfg->in_fmt->channels) *
+			(mcfg->in_fmt->bit_depth >> 3) *
+			multiplier;
+
+	if (mcfg->out_fmt->s_freq % 1000)
+		out_rate = (mcfg->out_fmt->s_freq / 1000) + 1;
+	else
+		out_rate = (mcfg->out_fmt->s_freq / 1000);
+
+	mcfg->obs = out_rate * (mcfg->out_fmt->channels) *
+			(mcfg->out_fmt->bit_depth >> 3) *
+			multiplier;
 }
 
 static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
-- 
2.8.0.rc3
