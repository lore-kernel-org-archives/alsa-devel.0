From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [RFC][PATCH] hda: track CIRB/CORB command/response
	states for each	codec
Date: Sat, 1 Aug 2009 18:45:16 +0800
Message-ID: <20090801104516.GA3741@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 71FB024397
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 12:45:28 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

Recently we hit a bug in our dev board, whose HDMI codec#3 may emit
redundant/spurious responses, which were then taken as responses to
command for another onboard Realtek codec#2, and mess up both codecs.

Extend the azx_rb.cmds and azx_rb.res to array and track each codec's
commands/responses separately. This helps keep good codec safe from
broken ones.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c |    2 
 sound/pci/hda/hda_codec.h |    2 
 sound/pci/hda/hda_intel.c |   76 +++++++++++++++++++++++++-----------
 3 files changed, 56 insertions(+), 24 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c
+++ sound-2.6/sound/pci/hda/hda_codec.c
@@ -185,7 +185,7 @@ static int codec_exec_verb(struct hda_co
 	mutex_lock(&bus->cmd_mutex);
 	err = bus->ops.command(bus, cmd);
 	if (!err && res)
-		*res = bus->ops.get_response(bus);
+		*res = bus->ops.get_response(bus, codec->addr);
 	mutex_unlock(&bus->cmd_mutex);
 	snd_hda_power_down(codec);
 	if (res && *res == -1 && bus->rirb_error) {
--- sound-2.6.orig/sound/pci/hda/hda_codec.h
+++ sound-2.6/sound/pci/hda/hda_codec.h
@@ -568,7 +568,7 @@ struct hda_bus_ops {
 	/* send a single command */
 	int (*command)(struct hda_bus *bus, unsigned int cmd);
 	/* get a response from the last command */
-	unsigned int (*get_response)(struct hda_bus *bus);
+	unsigned int (*get_response)(struct hda_bus *bus, unsigned int addr);
 	/* free the private data */
 	void (*private_free)(struct hda_bus *);
 	/* attach a PCM stream */
--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -260,7 +260,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO
 
 /* STATESTS int mask: S3,SD2,SD1,SD0 */
 #define AZX_MAX_CODECS		4
-#define STATESTS_INT_MASK	0x0f
+#define STATESTS_INT_MASK	((1 << AZX_MAX_CODECS) - 1)
 
 /* SD_CTL bits */
 #define SD_CTL_STREAM_RESET	0x01	/* stream reset bit */
@@ -368,8 +368,8 @@ struct azx_rb {
 	dma_addr_t addr;	/* physical address of CORB/RIRB buffer */
 	/* for RIRB */
 	unsigned short rp, wp;	/* read/write pointers */
-	int cmds;		/* number of pending requests */
-	u32 res;		/* last read value */
+	int cmds[AZX_MAX_CODECS];	/* number of pending requests */
+	u32 res[AZX_MAX_CODECS];	/* last read value */
 };
 
 struct azx {
@@ -538,7 +538,8 @@ static void azx_init_cmd_io(struct azx *
 	/* RIRB set up */
 	chip->rirb.addr = chip->rb.addr + 2048;
 	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
-	chip->rirb.wp = chip->rirb.rp = chip->rirb.cmds = 0;
+	chip->rirb.wp = chip->rirb.rp = 0;
+	memset(chip->rirb.cmds, 0, sizeof(chip->rirb.cmds));
 	azx_writel(chip, RIRBLBASE, (u32)chip->rirb.addr);
 	azx_writel(chip, RIRBUBASE, upper_32_bits(chip->rirb.addr));
 
@@ -559,10 +560,35 @@ static void azx_free_cmd_io(struct azx *
 	azx_writeb(chip, CORBCTL, 0);
 }
 
+static unsigned int azx_command_addr(u32 cmd)
+{
+	unsigned int addr = cmd >> 28;
+
+	if (addr >= AZX_MAX_CODECS) {
+		snd_BUG();
+		addr = 0;
+	}
+
+	return addr;
+}
+
+static unsigned int azx_response_addr(u32 res)
+{
+	unsigned int addr = res & 0xf;
+
+	if (addr >= AZX_MAX_CODECS) {
+		snd_BUG();
+		addr = 0;
+	}
+
+	return addr;
+}
+
 /* send a command */
 static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 {
 	struct azx *chip = bus->private_data;
+	unsigned int addr = azx_command_addr(val);
 	unsigned int wp;
 
 	/* add command to corb */
@@ -571,7 +597,7 @@ static int azx_corb_send_cmd(struct hda_
 	wp %= ICH6_MAX_CORB_ENTRIES;
 
 	spin_lock_irq(&chip->reg_lock);
-	chip->rirb.cmds++;
+	chip->rirb.cmds[addr]++;
 	chip->corb.buf[wp] = cpu_to_le32(val);
 	azx_writel(chip, CORBWP, wp);
 	spin_unlock_irq(&chip->reg_lock);
@@ -585,13 +611,14 @@ static int azx_corb_send_cmd(struct hda_
 static void azx_update_rirb(struct azx *chip)
 {
 	unsigned int rp, wp;
+	unsigned int addr;
 	u32 res, res_ex;
 
 	wp = azx_readb(chip, RIRBWP);
 	if (wp == chip->rirb.wp)
 		return;
 	chip->rirb.wp = wp;
-		
+
 	while (chip->rirb.rp != wp) {
 		chip->rirb.rp++;
 		chip->rirb.rp %= ICH6_MAX_RIRB_ENTRIES;
@@ -599,18 +626,20 @@ static void azx_update_rirb(struct azx *
 		rp = chip->rirb.rp << 1; /* an RIRB entry is 8-bytes */
 		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
 		res = le32_to_cpu(chip->rirb.buf[rp]);
+		addr = azx_response_addr(res_ex);
 		if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
 			snd_hda_queue_unsol_event(chip->bus, res, res_ex);
-		else if (chip->rirb.cmds) {
-			chip->rirb.res = res;
+		else if (chip->rirb.cmds[addr]) {
+			chip->rirb.res[addr] = res;
 			smp_wmb();
-			chip->rirb.cmds--;
+			chip->rirb.cmds[addr]--;
 		}
 	}
 }
 
 /* receive a response */
-static unsigned int azx_rirb_get_response(struct hda_bus *bus)
+static unsigned int azx_rirb_get_response(struct hda_bus *bus,
+					  unsigned int addr)
 {
 	struct azx *chip = bus->private_data;
 	unsigned long timeout;
@@ -623,10 +652,10 @@ static unsigned int azx_rirb_get_respons
 			azx_update_rirb(chip);
 			spin_unlock_irq(&chip->reg_lock);
 		}
-		if (!chip->rirb.cmds) {
+		if (!chip->rirb.cmds[addr]) {
 			smp_rmb();
 			bus->rirb_error = 0;
-			return chip->rirb.res; /* the last value */
+			return chip->rirb.res[addr]; /* the last value */
 		}
 		if (time_after(jiffies, timeout))
 			break;
@@ -699,7 +728,7 @@ static unsigned int azx_rirb_get_respons
  */
 
 /* receive a response */
-static int azx_single_wait_for_response(struct azx *chip)
+static int azx_single_wait_for_response(struct azx *chip, unsigned int addr)
 {
 	int timeout = 50;
 
@@ -707,7 +736,7 @@ static int azx_single_wait_for_response(
 		/* check IRV busy bit */
 		if (azx_readw(chip, IRS) & ICH6_IRS_VALID) {
 			/* reuse rirb.res as the response return value */
-			chip->rirb.res = azx_readl(chip, IR);
+			chip->rirb.res[addr] = azx_readl(chip, IR);
 			return 0;
 		}
 		udelay(1);
@@ -715,7 +744,7 @@ static int azx_single_wait_for_response(
 	if (printk_ratelimit())
 		snd_printd(SFX "get_response timeout: IRS=0x%x\n",
 			   azx_readw(chip, IRS));
-	chip->rirb.res = -1;
+	chip->rirb.res[addr] = -1;
 	return -EIO;
 }
 
@@ -723,6 +752,7 @@ static int azx_single_wait_for_response(
 static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
 {
 	struct azx *chip = bus->private_data;
+	unsigned int addr = azx_command_addr(val);
 	int timeout = 50;
 
 	bus->rirb_error = 0;
@@ -735,7 +765,7 @@ static int azx_single_send_cmd(struct hd
 			azx_writel(chip, IC, val);
 			azx_writew(chip, IRS, azx_readw(chip, IRS) |
 				   ICH6_IRS_BUSY);
-			return azx_single_wait_for_response(chip);
+			return azx_single_wait_for_response(chip, addr);
 		}
 		udelay(1);
 	}
@@ -746,10 +776,11 @@ static int azx_single_send_cmd(struct hd
 }
 
 /* receive a response */
-static unsigned int azx_single_get_response(struct hda_bus *bus)
+static unsigned int azx_single_get_response(struct hda_bus *bus,
+					    unsigned int addr)
 {
 	struct azx *chip = bus->private_data;
-	return chip->rirb.res;
+	return chip->rirb.res[addr];
 }
 
 /*
@@ -772,13 +803,14 @@ static int azx_send_cmd(struct hda_bus *
 }
 
 /* get a response */
-static unsigned int azx_get_response(struct hda_bus *bus)
+static unsigned int azx_get_response(struct hda_bus *bus,
+				     unsigned int addr)
 {
 	struct azx *chip = bus->private_data;
 	if (chip->single_cmd)
-		return azx_single_get_response(bus);
+		return azx_single_get_response(bus, addr);
 	else
-		return azx_rirb_get_response(bus);
+		return azx_rirb_get_response(bus, addr);
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -1252,7 +1284,7 @@ static int probe_codec(struct azx *chip,
 
 	chip->probing = 1;
 	azx_send_cmd(chip->bus, cmd);
-	res = azx_get_response(chip->bus);
+	res = azx_get_response(chip->bus, addr);
 	chip->probing = 0;
 	if (res == -1)
 		return -EIO;
