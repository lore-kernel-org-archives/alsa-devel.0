From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Unmap the address last"
	to the asoc tree
Date: Wed, 16 Mar 2016 10:09:19 +0000
Message-ID: <E1ag8OF-00061o-4f@debutante>
References: <1458035836-1843-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 540BB265DC8
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:09:27 +0100 (CET)
In-Reply-To: <1458035836-1843-5-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Unmap the address last

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

>From 077411e5eb8872736fdc5f3e7277719160918dde Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Mar 2016 16:39:26 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Unmap the address last

In Skylake destructor we unmap the hardware address and then free
links and streams. The stream free accesses hardware to write to
registers and predictably causes oops.

So change the order and unmap last in destructor.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 292d51db9a22..6e916c3c3a4b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -316,12 +316,13 @@ static int skl_free(struct hdac_ext_bus *ebus)
 
 	if (bus->irq >= 0)
 		free_irq(bus->irq, (void *)bus);
-	if (bus->remap_addr)
-		iounmap(bus->remap_addr);
-
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_stream_free_all(ebus);
 	snd_hdac_link_free_all(ebus);
+
+	if (bus->remap_addr)
+		iounmap(bus->remap_addr);
+
 	pci_release_regions(skl->pci);
 	pci_disable_device(skl->pci);
 
-- 
2.7.0
