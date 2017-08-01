From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove return check for
	skl_codec_create()" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:39 +0100
Message-ID: <E1dcXyR-0008OG-6T@debutante>
References: <20170728104216.26859-3-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0F7267145
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:16:48 +0200 (CEST)
In-Reply-To: <20170728104216.26859-3-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove return check for skl_codec_create()

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

>From 693c0fb26a312d7cc866b1e9195187789b69e7e6 Mon Sep 17 00:00:00 2001
From: "guneshwor.o.singh@intel.com" <guneshwor.o.singh@intel.com>
Date: Fri, 28 Jul 2017 16:12:15 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove return check for
 skl_codec_create()

Since skl_codec_create() always returns 0, make it return void and remove
return check.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b9e1310673f0..ab651517e8b8 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -528,7 +528,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 }
 
 /* Codec initialization */
-static int skl_codec_create(struct hdac_ext_bus *ebus)
+static void skl_codec_create(struct hdac_ext_bus *ebus)
 {
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int c, max_slots;
@@ -559,8 +559,6 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 			}
 		}
 	}
-
-	return 0;
 }
 
 static const struct hdac_bus_ops bus_core_ops = {
@@ -612,9 +610,7 @@ static void skl_probe_work(struct work_struct *work)
 		dev_info(bus->dev, "no hda codecs found!\n");
 
 	/* create codec instances */
-	err = skl_codec_create(ebus);
-	if (err < 0)
-		goto out_err;
+	skl_codec_create(ebus);
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
-- 
2.13.2
