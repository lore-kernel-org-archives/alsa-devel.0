From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: set the resume point to
	LPIB" to the asoc tree
Date: Thu, 19 Jan 2017 18:03:50 +0000
Message-ID: <E1cUH3u-0004wy-K7@debutante>
References: <1480700509-23380-12-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 581BF2678E4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 19:04:01 +0100 (CET)
In-Reply-To: <1480700509-23380-12-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: set the resume point to LPIB

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

>From a700a1e65aa3ee76d2e8c58150ee7b7272d93608 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 10 Jan 2017 17:57:47 +0530
Subject: [PATCH] ASoC: Intel: Skylake: set the resume point to LPIB

In system suspend, the firmware pipelines will be deleted and there
is no need to save the pipeline context. Driver will save the DPIB and
LPIB pointers in suspend.

In system resume, the firmware pipelines will be created again and the
RD/RW pointers in the Firmware buffer points to the base address. So
need to fetch the non-played data again to firmware buffer. LPIB
indicates the HW rendered position.

Instead of setting DPIB as resume point, set it to LPIB to restore from
the HW render position so that DMA would fetch the non-played data one
more time.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index aefcfca810f4..ae7997ab19b1 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -474,7 +474,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			snd_hdac_ext_stream_drsm_enable(ebus, true,
 						hdac_stream(stream)->index);
 			snd_hdac_ext_stream_set_dpibr(ebus, stream,
-							stream->dpib);
+							stream->lpib);
 			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
 		}
 
-- 
2.11.0
