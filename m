From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: pcm: add ALH support" to the asoc
	tree
Date: Fri, 16 Aug 2019 13:14:52 +0100 (BST)
Message-ID: <20190816121452.540B227430D6@ypsilon.sirena.org.uk>
References: <20190815192018.30570-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com
 [209.85.128.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CA0BF801DB
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 14:14:53 +0200 (CEST)
Received: by mail-wm1-f99.google.com with SMTP id g67so3902735wme.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 05:14:53 -0700 (PDT)
In-Reply-To: <20190815192018.30570-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: pcm: add ALH support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 6e3360cd07ec2d4a53919dc62947f9769d8fdac4 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 15 Aug 2019 14:20:18 -0500
Subject: [PATCH] ASoC: SOF: pcm: add ALH support

Even if ALH has no specific configuration, we still need to handle the
common parameters for all DAIs

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190815192018.30570-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 8612896673a5..e3f6a6dc0f36 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -675,6 +675,9 @@ static int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 	case SOF_DAI_INTEL_HDA:
 		/* do nothing for HDA dai_link */
 		break;
+	case SOF_DAI_INTEL_ALH:
+		/* do nothing for ALH dai_link */
+		break;
 	default:
 		dev_err(sdev->dev, "error: invalid DAI type %d\n",
 			dai->dai_config->type);
-- 
2.20.1
