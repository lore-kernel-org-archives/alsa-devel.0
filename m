From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to ignore blob
	check if link type is HDA" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:35 +0900
Message-ID: <E1ZqwCV-0004w9-Ah@finisterre>
References: <1445905380-18167-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A675B2651B8
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:45 +0100 (CET)
In-Reply-To: <1445905380-18167-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to ignore blob check if link type is HDA

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

>From d38aca5910f665c09e7aeb006fcf19eb3aa789b7 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:48 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix to ignore blob check if link type
 is HDA

If link type is HDA, NHLT blob is null, as NHLT defines non HDA
links only.  So we should ignore blob query for HDA links.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 313a02d..e11a9e4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -921,6 +921,9 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 
 	memcpy(pipe->p_params, params, sizeof(*params));
 
+	if (link_type == NHLT_LINK_HDA)
+		return 0;
+
 	/* update the blob based on virtual bus_id*/
 	cfg = skl_get_ep_blob(skl, mconfig->vbus_id, link_type,
 					params->s_fmt, params->ch,
-- 
2.6.1
