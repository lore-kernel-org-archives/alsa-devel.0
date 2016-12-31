From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to fail safely if
	module not available in path" to the asoc tree
Date: Sat, 31 Dec 2016 19:19:01 +0000
Message-ID: <E1cNPBF-0003r9-L8@debutante>
References: <1482218205-1067-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D7F62670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 20:19:08 +0100 (CET)
In-Reply-To: <1482218205-1067-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, vinod.koul@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to fail safely if module not available in path

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

>From 91ce54978ccece323aa6df930249ff84a7d233c7 Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Tue, 20 Dec 2016 12:46:45 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to fail safely if module not
 available in path

If a module is not available in a pipeline, fail safely rather than
causing oops.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 84b5101e6ca6..6c6b63a6b338 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -180,6 +180,9 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	snd_pcm_set_sync(substream);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+	if (!mconfig)
+		return -EINVAL;
+
 	skl_tplg_d0i3_get(skl, mconfig->d0i3_caps);
 
 	return 0;
-- 
2.11.0
