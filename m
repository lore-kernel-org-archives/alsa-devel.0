From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH v3 2/3] ASoC: enable interrupt after dma buffer initialization
Date: Wed, 12 Sep 2018 13:44:41 -0600
Message-ID: <20180912194441.200564-1-yuzhao@google.com>
References: <20180912194343.200443-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912194343.200443-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>, Yu Zhao <yuzhao@google.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In snd_hdac_bus_init_chip(), we enable interrupt before
snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
been acquired and irq handler uses the dma buffer, kernel may crash
when interrupt comes in.

Fix the problem by postponing enabling irq after dma buffer
initialization. And warn once on null dma buffer pointer during the
initialization.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/hda/hdac_controller.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 560ec0986e1a..11057d9f84ec 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -40,6 +40,8 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
  */
 void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 {
+	WARN_ON_ONCE(!bus->rb.area);
+
 	spin_lock_irq(&bus->reg_lock);
 	/* CORB set up */
 	bus->corb.addr = bus->rb.addr;
@@ -479,13 +481,15 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 	/* reset controller */
 	azx_reset(bus, full_reset);
 
-	/* initialize interrupts */
+	/* clear interrupts */
 	azx_int_clear(bus);
-	azx_int_enable(bus);
 
 	/* initialize the codec command I/O */
 	snd_hdac_bus_init_cmd_io(bus);
 
+	/* enable interrupts after CORB/RIRB buffers are initialized above */
+	azx_int_enable(bus);
+
 	/* program the position buffer */
 	if (bus->use_posbuf && bus->posbuf.addr) {
 		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
