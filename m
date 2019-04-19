From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm: save fixed-up hw_params of BE" to
	the asoc tree
Date: Fri, 19 Apr 2019 17:14:06 +0100 (BST)
Message-ID: <20190419161406.7FC34441D3D@finisterre.ee.mobilebroadband>
References: <1555638792-20848-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40AE7F896EC
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 18:14:17 +0200 (CEST)
In-Reply-To: <1555638792-20848-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: libin.yang@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm: save fixed-up hw_params of BE

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From ae061d2a857f84ad47b77b04c3ad37478651ab6c Mon Sep 17 00:00:00 2001
From: Libin Yang <libin.yang@intel.com>
Date: Fri, 19 Apr 2019 09:53:12 +0800
Subject: [PATCH] ASoC: pcm: save fixed-up hw_params of BE

Some drivers mandate setting up hw params after resuming from system sleep.
Since, the hw_params ioctl is not invoked upon resuming, the fixed-up BE
dai hw params should be saved so the driver can use it in its resume
sequence.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2d5d5cac4ba6..035dedee78f1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2156,6 +2156,10 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 			}
 		}
 
+		/* copy the fixed-up hw params for BE dai */
+		memcpy(&be->dpcm[stream].hw_params, &dpcm->hw_params,
+		       sizeof(struct snd_pcm_hw_params));
+
 		/* only allow hw_params() if no connected FEs are running */
 		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
 			continue;
-- 
2.20.1
