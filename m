From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: fixup
	try_module_get()/module_put() timing" to the asoc tree
Date: Tue, 21 May 2019 22:04:00 +0100 (BST)
Message-ID: <20190521210400.5590D1126D16@debutante.sirena.org.uk>
References: <87imu5zzh7.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2F83F8079B
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 23:04:03 +0200 (CEST)
In-Reply-To: <87imu5zzh7.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: fixup try_module_get()/module_put() timing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 428306c3b3fe107b1d059ceecf6fda09a1fcedf5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 May 2019 10:42:39 +0900
Subject: [PATCH] ASoC: soc-pcm: fixup try_module_get()/module_put() timing

soc_pcm_components_open/close() try to call
try_module_get()/module_put() based on
component->driver->module_get_upon_open.

Here, the purpose why we need to call these functions are to
checking module reference.
Thus, we need to call try_module_open() even though it doesn't
have .open callback.

The same reason, we need to call module_put() even though it
doesn't have .close

This patch calls try_module_get()/module_put() regardless of
.open/.close

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 74c7d38af2c6..4a7096a22b28 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -458,10 +458,6 @@ static int soc_pcm_components_open(struct snd_pcm_substream *substream,
 		component = rtdcom->component;
 		*last = component;
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->open)
-			continue;
-
 		if (component->driver->module_get_upon_open &&
 		    !try_module_get(component->dev->driver->owner)) {
 			dev_err(component->dev,
@@ -470,6 +466,10 @@ static int soc_pcm_components_open(struct snd_pcm_substream *substream,
 			return -ENODEV;
 		}
 
+		if (!component->driver->ops ||
+		    !component->driver->ops->open)
+			continue;
+
 		ret = component->driver->ops->open(substream);
 		if (ret < 0) {
 			dev_err(component->dev,
@@ -495,11 +495,9 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 		if (component == last)
 			break;
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->close)
-			continue;
-
-		component->driver->ops->close(substream);
+		if (component->driver->ops &&
+		    component->driver->ops->close)
+			component->driver->ops->close(substream);
 
 		if (component->driver->module_get_upon_open)
 			module_put(component->dev->driver->owner);
-- 
2.20.1
