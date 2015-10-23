From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove BE copier blob
	memcpy" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:49 +0900
Message-ID: <E1ZpgRR-0006Vu-21@finisterre>
References: <1445536362-26670-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD1A265051
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:57 +0200 (CEST)
In-Reply-To: <1445536362-26670-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Remove BE copier blob memcpy

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

>From bc03281a5c706f6372dfc2100b04aa4055a15c88 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:35 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove BE copier blob memcpy

The BE copier private data allowed endpoint configuration blobs, now these
are queried from BIOS, we don't need to copy the blob, but only capability.

Removing the blob from private data will not allocate memory for module
specific config in which case memcpy will fail. Fix is to assign the ptr
queried from the NHLT table for the endpoint configuration.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a5d8420..7c92085 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -926,7 +926,7 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 					params->s_freq, params->stream);
 	if (cfg) {
 		mconfig->formats_config.caps_size = cfg->size;
-		memcpy(mconfig->formats_config.caps, &cfg->caps, cfg->size);
+		mconfig->formats_config.caps = (u32 *) &cfg->caps;
 	} else {
 		dev_err(dai->dev, "Blob NULL for id %x type %d dirn %d\n",
 					mconfig->vbus_id, link_type,
-- 
2.6.1
