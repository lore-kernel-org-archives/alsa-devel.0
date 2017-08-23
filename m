From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to free correct dev
	id in free_irq" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:35 +0100
Message-ID: <E1dkTlz-00078Q-T2@debutante>
References: <1503400553-15377-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAA9B267247
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:43 +0200 (CEST)
In-Reply-To: <1503400553-15377-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to free correct dev id in free_irq

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

>From c360e0c3ab8ef8d0fd6b5501a407b9a2be4f204d Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 22 Aug 2017 16:45:52 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to free correct dev id in free_irq

The dev_id passed by the driver in request_threaded_irq is an ebus pointer,
whereas to free_irq it is hdac_bus. Fix by passing correct dev_id to
free_irq.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e612a4097275..d62ffbc93d54 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -415,7 +415,7 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	snd_hdac_ext_stop_streams(ebus);
 
 	if (bus->irq >= 0)
-		free_irq(bus->irq, (void *)bus);
+		free_irq(bus->irq, (void *)ebus);
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_stream_free_all(ebus);
 	snd_hdac_link_free_all(ebus);
-- 
2.14.1
