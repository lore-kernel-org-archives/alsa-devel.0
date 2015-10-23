From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix return for
	pm_runtime_get_sync()" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:50 +0900
Message-ID: <E1ZpgRS-0006WN-4Q@finisterre>
References: <1445536362-26670-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 730BD2650FA
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:59 +0200 (CEST)
In-Reply-To: <1445536362-26670-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix return for pm_runtime_get_sync()

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

>From 9270b7b92615324ecda2b3fa0be98b4ab6c3e361 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:34 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix return for pm_runtime_get_sync()

pm_runtime_get_sync() will return a negative value in case of
error and can return postive value for success.  The return check
for pm_runtime_get_sync() must be less than 0, so fix it

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a8f53da..a2f94ce 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -116,7 +116,7 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 	ret = pm_runtime_get_sync(dai->dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	stream = snd_hdac_ext_stream_assign(ebus, substream,
-- 
2.6.1
