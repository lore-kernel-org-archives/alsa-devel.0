From: Mark Brown <broonie@kernel.org>
Subject: Applied "sound: don't call skl_init_chip() to reset
	intel skl soc" to the asoc tree
Date: Thu, 13 Sep 2018 12:34:47 +0100 (BST)
Message-ID: <20180913113447.DD2371121CA5@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A0E2677BB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:34:48 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yu Zhao <yuzhao@google.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   sound: don't call skl_init_chip() to reset intel skl soc

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

>From 75383f8d39d4c0fb96083dd460b7b139fbdac492 Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 11 Sep 2018 15:15:16 -0600
Subject: [PATCH] sound: don't call skl_init_chip() to reset intel skl soc

Internally, skl_init_chip() calls snd_hdac_bus_init_chip() which
1) sets bus->chip_init to prevent multiple entrances before device
is stopped; 2) enables interrupt.

We shouldn't use it for the purpose of resetting device only because
1) when we really want to initialize device, we won't be able to do
so; 2) we are ready to handle interrupt yet, and kernel crashes when
interrupt comes in.

Rename azx_reset() to snd_hdac_bus_reset_link(), and use it to reset
device properly.

Fixes: 60767abcea3d ("ASoC: Intel: Skylake: Reset the controller in probe")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/hdaudio.h       | 1 +
 sound/hda/hdac_controller.c   | 7 ++++---
 sound/soc/intel/skylake/skl.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index ab5ee3ef2198..207e816ce6e1 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -384,6 +384,7 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus);
 void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus);
 void snd_hdac_bus_enter_link_reset(struct hdac_bus *bus);
 void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus);
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset);
 
 void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
 int snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 11057d9f84ec..74244d8e2909 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -385,7 +385,7 @@ void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus)
 EXPORT_SYMBOL_GPL(snd_hdac_bus_exit_link_reset);
 
 /* reset codec link */
-static int azx_reset(struct hdac_bus *bus, bool full_reset)
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 {
 	if (!full_reset)
 		goto skip_reset;
@@ -410,7 +410,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_reset)
  skip_reset:
 	/* check to see if controller is ready */
 	if (!snd_hdac_chip_readb(bus, GCTL)) {
-		dev_dbg(bus->dev, "azx_reset: controller not ready!\n");
+		dev_dbg(bus->dev, "controller not ready!\n");
 		return -EBUSY;
 	}
 
@@ -425,6 +425,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_reset)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hdac_bus_reset_link);
 
 /* enable interrupts */
 static void azx_int_enable(struct hdac_bus *bus)
@@ -479,7 +480,7 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 		return false;
 
 	/* reset controller */
-	azx_reset(bus, full_reset);
+	snd_hdac_bus_reset_link(bus, full_reset);
 
 	/* clear interrupts */
 	azx_int_clear(bus);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dce649485649..1d17be0f78a0 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -834,7 +834,7 @@ static int skl_first_init(struct hdac_bus *bus)
 		return -ENXIO;
 	}
 
-	skl_init_chip(bus, true);
+	snd_hdac_bus_reset_link(bus, true);
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-- 
2.19.0.rc2
