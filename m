From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm: fix error handling when
	try_module_get() fails." to the asoc tree
Date: Mon, 13 May 2019 13:30:34 +0100 (BST)
Message-ID: <20190513123034.2B09B1129232@debutante.sirena.org.uk>
References: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D42D3F89733
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm: fix error handling when try_module_get() fails.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7df8e234449a9a1cd2af5de728b7f811346c6fec Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Mon, 8 Apr 2019 12:30:25 -0700
Subject: [PATCH] ASoC: pcm: fix error handling when try_module_get() fails.

Handle error before returning when try_module_get() fails
to prevent inconsistent mutex lock/unlock.

Fixes: 52034add7 (ASoC: pcm: update module refcount if
		  module_get_upon_open is set)
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a810f6eeffee..69ea962de585 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -518,8 +518,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			continue;
 
 		if (component->driver->module_get_upon_open &&
-		    !try_module_get(component->dev->driver->owner))
-			return -ENODEV;
+		    !try_module_get(component->dev->driver->owner)) {
+			ret = -ENODEV;
+			goto module_err;
+		}
 
 		ret = component->driver->ops->open(substream);
 		if (ret < 0) {
@@ -636,7 +638,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 component_err:
 	soc_pcm_components_close(substream, component);
-
+module_err:
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 out:
-- 
2.20.1
