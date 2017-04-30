From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix unused variable
	warning" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:16 +0900
Message-ID: <E1d4oQa-00042f-7d@finisterre>
References: <1493275882-27708-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4745627877807569585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9808F266BEB
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 14:58:24 +0200 (CEST)
In-Reply-To: <1493275882-27708-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============4745627877807569585==
Content-Type: text/plain

The patch

   ASoC: Intel: Skylake: Fix unused variable warning

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

>From 9ed4aefe6f5f7e1dfe6abe8b15cfc8c48963b6c0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 27 Apr 2017 12:21:21 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix unused variable warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With compiler option W=1, we have one more warning in the driver for
'set but unused variable', so remove the unused variable to fix it.

sound/soc/intel/skylake/skl-pcm.c: In function ‘skl_platform_open’:
sound/soc/intel/skylake/skl-pcm.c:954:26: warning: variable ‘runtime’ set but not used [-Wunused-but-set-variable]
  struct snd_pcm_runtime *runtime;

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index d43d1976dd3b..e91bbcffc856 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -951,14 +951,12 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 
 static int skl_platform_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 
 	dev_dbg(rtd->cpu_dai->dev, "In %s:%s\n", __func__,
 					dai_link->cpu_dai_name);
 
-	runtime = substream->runtime;
 	snd_soc_set_runtime_hwparams(substream, &azx_pcm_hw);
 
 	return 0;
-- 
2.11.0


--===============4745627877807569585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4745627877807569585==--
