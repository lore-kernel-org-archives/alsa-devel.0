From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use device_register()" to the
	asoc tree
Date: Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Message-ID: <20190822183257.14831D02CD4@fitzroy.sirena.org.uk>
References: <878sro1ldw.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAC0AF803F3
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:33:06 +0200 (CEST)
In-Reply-To: <878sro1ldw.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Sridharan@sirena.org.uk, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: use device_register()

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

>From 4168ddabb480bef818c93f378428632fb681b500 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:04:49 +0900
Subject: [PATCH] ASoC: soc-core: use device_register()

It is easy to read code if it is cleanly using paired function/naming,
like start <-> stop, register <-> unregister, etc, etc.
But, current ALSA SoC code is very random, unbalance, not paired, etc.

soc-core.c is using device_unregiser(), but there is no its paired
device_regiser(). We can find its code at soc_post_component_init()
which is using device_initialize() and device_add().
Here, device_initialize() + device_add() = device_register().

	-- linux/drivers/base/core.c --
	int device_register(struct device *dev)
	{
		device_initialize(dev);
		return device_add(dev);
	}

device_initialize() is doing each dev member's initialization only,
not related to device parent/release/groups.
Thus, we can postpone it.
let's use device_register() instead of device_initialize()/device_add().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/878sro1ldw.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6df880be1622..3860d8521734 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1347,7 +1347,6 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!rtd->dev)
 		return -ENOMEM;
-	device_initialize(rtd->dev);
 	rtd->dev->parent = rtd->card->dev;
 	rtd->dev->release = rtd_release;
 	rtd->dev->groups = soc_dev_attr_groups;
@@ -1357,7 +1356,7 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].be_clients);
 	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].fe_clients);
 	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].fe_clients);
-	ret = device_add(rtd->dev);
+	ret = device_register(rtd->dev);
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-- 
2.20.1
