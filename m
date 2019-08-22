From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add NOTE to
	snd_soc_rtdcom_lookup()" to the asoc tree
Date: Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Message-ID: <20190822183257.02AD2D02CD3@fitzroy.sirena.org.uk>
References: <874l2c1ldi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F33E6F803D5
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:33:05 +0200 (CEST)
In-Reply-To: <874l2c1ldi.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: add NOTE to snd_soc_rtdcom_lookup()

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

>From a33c0d166cc5bcb3b9718649b84974216709acb1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:05:02 +0900
Subject: [PATCH] ASoC: soc-core: add NOTE to snd_soc_rtdcom_lookup()

We can find specified name component via snd_soc_rtdcom_lookup().
But, it is not enough under multi CPU/Codec/Platform, because many
components which have same driver name might be connected to same rtd.

Not using this function as much as possible is best solution,
but some drivers are already deeply depended to it.

We can expand this function, for example having "num" which specifies
found order at parameter, etc (In such case, it need to have fixed
probing order).
Or, use different driver name in such component, etc.

We will have such issue if multi CPU/Codec/Platform were supported.
To indicate it, this patch adds NOTE to this function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/874l2c1ldi.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3860d8521734..0ed6576bfef4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -315,6 +315,14 @@ struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
 	if (!driver_name)
 		return NULL;
 
+	/*
+	 * NOTE
+	 *
+	 * snd_soc_rtdcom_lookup() will find component from rtd by using
+	 * specified driver name.
+	 * But, if many components which have same driver name are connected
+	 * to 1 rtd, this function will return 1st found component.
+	 */
 	for_each_rtdcom(rtd, rtdcom) {
 		const char *component_name = rtdcom->component->driver->name;
 
-- 
2.20.1
