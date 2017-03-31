From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Avoid tricky macros
Date: Fri, 31 Mar 2017 10:49:28 +0200
Message-ID: <20170331084930.813-2-tiwai@suse.de>
References: <20170331084930.813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8AC2671E9
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 10:49:32 +0200 (CEST)
In-Reply-To: <20170331084930.813-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

The macros _snd_hdac_chip_read() and *_write() expand to different
types (b,w,l) per their argument.  They were thought to be used only
internally for other snd_hdac_chip_*() macros, but in some situations
we need to call these directly, and they are way too ugly.

Instead of saving a few lines, we just write these macros explicitly
with the types, so that they can be used in a saner way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h     | 28 ++++++++++++++++++----------
 sound/hda/hdac_controller.c |  2 +-
 sound/hda/hdac_stream.c     |  4 ++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 56004ec8d441..96546b30e900 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -368,24 +368,32 @@ void snd_hdac_bus_free_stream_pages(struct hdac_bus *bus);
 /*
  * macros for easy use
  */
-#define _snd_hdac_chip_write(type, chip, reg, value) \
-	((chip)->io_ops->reg_write ## type(value, (chip)->remap_addr + (reg)))
-#define _snd_hdac_chip_read(type, chip, reg) \
-	((chip)->io_ops->reg_read ## type((chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_writeb(chip, reg, value) \
+	((chip)->io_ops->reg_writeb(value, (chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_readb(chip, reg) \
+	((chip)->io_ops->reg_readb((chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_writew(chip, reg, value) \
+	((chip)->io_ops->reg_writew(value, (chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_readw(chip, reg) \
+	((chip)->io_ops->reg_readw((chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_writel(chip, reg, value) \
+	((chip)->io_ops->reg_writel(value, (chip)->remap_addr + (reg)))
+#define _snd_hdac_chip_readl(chip, reg) \
+	((chip)->io_ops->reg_readl((chip)->remap_addr + (reg)))
 
 /* read/write a register, pass without AZX_REG_ prefix */
 #define snd_hdac_chip_writel(chip, reg, value) \
-	_snd_hdac_chip_write(l, chip, AZX_REG_ ## reg, value)
+	_snd_hdac_chip_writel(chip, AZX_REG_ ## reg, value)
 #define snd_hdac_chip_writew(chip, reg, value) \
-	_snd_hdac_chip_write(w, chip, AZX_REG_ ## reg, value)
+	_snd_hdac_chip_writew(chip, AZX_REG_ ## reg, value)
 #define snd_hdac_chip_writeb(chip, reg, value) \
-	_snd_hdac_chip_write(b, chip, AZX_REG_ ## reg, value)
+	_snd_hdac_chip_writeb(chip, AZX_REG_ ## reg, value)
 #define snd_hdac_chip_readl(chip, reg) \
-	_snd_hdac_chip_read(l, chip, AZX_REG_ ## reg)
+	_snd_hdac_chip_readl(chip, AZX_REG_ ## reg)
 #define snd_hdac_chip_readw(chip, reg) \
-	_snd_hdac_chip_read(w, chip, AZX_REG_ ## reg)
+	_snd_hdac_chip_readw(chip, AZX_REG_ ## reg)
 #define snd_hdac_chip_readb(chip, reg) \
-	_snd_hdac_chip_read(b, chip, AZX_REG_ ## reg)
+	_snd_hdac_chip_readb(chip, AZX_REG_ ## reg)
 
 /* update a register, pass without AZX_REG_ prefix */
 #define snd_hdac_chip_updatel(chip, reg, mask, val) \
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 043065867656..d15b653de0bf 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -272,7 +272,7 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
 
 	/* Lets walk the linked capabilities list */
 	do {
-		cur_cap = _snd_hdac_chip_read(l, bus, offset);
+		cur_cap = _snd_hdac_chip_readl(bus, offset);
 
 		dev_dbg(bus->dev, "Capability version: 0x%x\n",
 			(cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index c6994ebb4567..e1472c7ab6c1 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -555,12 +555,12 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
 
 	if (!reg)
 		reg = AZX_REG_SSYNC;
-	val = _snd_hdac_chip_read(l, bus, reg);
+	val = _snd_hdac_chip_readl(bus, reg);
 	if (set)
 		val |= streams;
 	else
 		val &= ~streams;
-	_snd_hdac_chip_write(l, bus, reg, val);
+	_snd_hdac_chip_writel(bus, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_sync_trigger);
 
-- 
2.11.1
