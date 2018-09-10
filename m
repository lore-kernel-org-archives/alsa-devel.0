From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH 3/3] sound: don't call skl_init_chip() to reset intel skl soc
Date: Mon, 10 Sep 2018 15:23:58 -0600
Message-ID: <20180910212358.203050-1-yuzhao@google.com>
References: <20180910212150.202655-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910212150.202655-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Yu Zhao <yuzhao@google.com>, Vinod Koul <vkoul@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/sound/hdaudio.h       | 1 +
 sound/hda/hdac_controller.c   | 7 ++++---
 sound/soc/intel/skylake/skl.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 6f1e1f3b3063..cd1773d0e08f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -412,6 +412,7 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus);
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
2.19.0.rc2.392.g5ba43deb5a-goog
