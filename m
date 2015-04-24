From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/21] ALSA: hda - Handle error from
	get_response bus ops directly
Date: Fri, 24 Apr 2015 14:38:33 +0200
Message-ID: <1429879133-32293-2-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C022605CC
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E5ACAB5F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... and drop bus->rirb_error flag.  This makes the code simpler.

We treat -EAGAIN from get_response ops as a special meaning: it allows
the caller to retry after bus reset.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 17 +++++++--------
 sound/pci/hda/hda_codec.h      |  3 +--
 sound/pci/hda/hda_controller.c | 47 +++++++++++++++++++++---------------------
 3 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e70a7fb393dd..c13d5c3e1d03 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -146,7 +146,7 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 	bus->no_response_fallback = 0;
 	mutex_unlock(&bus->core.cmd_mutex);
 	snd_hda_power_down_pm(codec);
-	if (!codec_in_pm(codec) && res && err < 0 && bus->rirb_error) {
+	if (!codec_in_pm(codec) && res && err == -EAGAIN) {
 		if (bus->response_reset) {
 			codec_dbg(codec,
 				  "resetting BUS due to fatal communication error\n");
@@ -436,9 +436,8 @@ static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 	    get_wcaps_type(wcaps) != AC_WID_PIN)
 		return 0;
 
-	parm = snd_hda_param_read(codec, nid, AC_PAR_DEVLIST_LEN);
-	if (parm == -1 && codec->bus->rirb_error)
-		parm = 0;
+	if (_snd_hdac_read_parm(&codec->core, nid, AC_PAR_DEVLIST_LEN, &parm))
+		return 0; /* error */
 	return parm & AC_DEV_LIST_LEN_MASK;
 }
 
@@ -467,10 +466,9 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 
 	devices = 0;
 	while (devices < dev_len) {
-		parm = snd_hda_codec_read(codec, nid, 0,
-					  AC_VERB_GET_DEVICE_LIST, devices);
-		if (parm == -1 && codec->bus->rirb_error)
-			break;
+		if (snd_hdac_read(&codec->core, nid,
+				  AC_VERB_GET_DEVICE_LIST, devices, &parm))
+			break; /* error */
 
 		for (i = 0; i < 8; i++) {
 			dev_list[devices] = (u8)parm;
@@ -520,8 +518,7 @@ static int _hda_bus_get_response(struct hdac_bus *_bus, unsigned int addr,
 				 unsigned int *res)
 {
 	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
-	*res = bus->ops.get_response(bus, addr);
-	return bus->rirb_error ? -EIO : 0;
+	return bus->ops.get_response(bus, addr, res);
 }
 
 static const struct hdac_bus_ops bus_ops = {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 9075ac28dc4b..fc4f76188a1d 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -45,7 +45,7 @@ struct hda_bus_ops {
 	/* send a single command */
 	int (*command)(struct hda_bus *bus, unsigned int cmd);
 	/* get a response from the last command */
-	unsigned int (*get_response)(struct hda_bus *bus, unsigned int addr);
+	int (*get_response)(struct hda_bus *bus, unsigned int addr, unsigned int *res);
 	/* free the private data */
 	void (*private_free)(struct hda_bus *);
 	/* attach a PCM stream */
@@ -92,7 +92,6 @@ struct hda_bus {
 	unsigned int allow_bus_reset:1;	/* allow bus reset at fatal error */
 	/* status for codec/controller */
 	unsigned int shutdown :1;	/* being unloaded */
-	unsigned int rirb_error:1;	/* error in codec communication */
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 26ce990592a0..b4474e27631d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1156,8 +1156,8 @@ static void azx_update_rirb(struct azx *chip)
 }
 
 /* receive a response */
-static unsigned int azx_rirb_get_response(struct hda_bus *bus,
-					  unsigned int addr)
+static int azx_rirb_get_response(struct hda_bus *bus, unsigned int addr,
+				 unsigned int *res)
 {
 	struct azx *chip = bus->private_data;
 	unsigned long timeout;
@@ -1175,11 +1175,12 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		}
 		if (!chip->rirb.cmds[addr]) {
 			smp_rmb();
-			bus->rirb_error = 0;
 
 			if (!do_poll)
 				chip->poll_count = 0;
-			return chip->rirb.res[addr]; /* the last value */
+			if (res)
+				*res = chip->rirb.res[addr]; /* the last value */
+			return 0;
 		}
 		if (time_after(jiffies, timeout))
 			break;
@@ -1192,7 +1193,7 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 	}
 
 	if (bus->no_response_fallback)
-		return -1;
+		return -EIO;
 
 	if (!chip->polling_mode && chip->poll_count < 2) {
 		dev_dbg(chip->card->dev,
@@ -1217,10 +1218,8 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 			 "No response from codec, disabling MSI: last cmd=0x%08x\n",
 			 chip->last_cmd[addr]);
 		if (chip->ops->disable_msi_reset_irq(chip) &&
-		    chip->ops->disable_msi_reset_irq(chip) < 0) {
-			bus->rirb_error = 1;
-			return -1;
-		}
+		    chip->ops->disable_msi_reset_irq(chip) < 0)
+			return -EIO;
 		goto again;
 	}
 
@@ -1229,16 +1228,15 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		 * phase, this is likely an access to a non-existing codec
 		 * slot.  Better to return an error and reset the system.
 		 */
-		return -1;
+		return -EIO;
 	}
 
 	/* a fatal communication error; need either to reset or to fallback
 	 * to the single_cmd mode
 	 */
-	bus->rirb_error = 1;
 	if (bus->allow_bus_reset && !bus->response_reset && !bus->in_reset) {
 		bus->response_reset = 1;
-		return -1; /* give a chance to retry */
+		return -EAGAIN; /* give a chance to retry */
 	}
 
 	dev_err(chip->card->dev,
@@ -1250,7 +1248,7 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 	azx_free_cmd_io(chip);
 	/* disable unsolicited responses */
 	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~AZX_GCTL_UNSOL);
-	return -1;
+	return -EIO;
 }
 
 /*
@@ -1291,7 +1289,6 @@ static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
 	unsigned int addr = azx_command_addr(val);
 	int timeout = 50;
 
-	bus->rirb_error = 0;
 	while (timeout--) {
 		/* check ICB busy bit */
 		if (!((azx_readw(chip, IRS) & AZX_IRS_BUSY))) {
@@ -1313,11 +1310,14 @@ static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
 }
 
 /* receive a response */
-static unsigned int azx_single_get_response(struct hda_bus *bus,
-					    unsigned int addr)
+static int azx_single_get_response(struct hda_bus *bus, unsigned int addr,
+				   unsigned int *res)
 {
 	struct azx *chip = bus->private_data;
-	return chip->rirb.res[addr];
+
+	if (res)
+		*res = chip->rirb.res[addr];
+	return 0;
 }
 
 /*
@@ -1342,16 +1342,16 @@ static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
 }
 
 /* get a response */
-static unsigned int azx_get_response(struct hda_bus *bus,
-				     unsigned int addr)
+static int azx_get_response(struct hda_bus *bus, unsigned int addr,
+			    unsigned int *res)
 {
 	struct azx *chip = bus->private_data;
 	if (chip->disabled)
 		return 0;
 	if (chip->single_cmd)
-		return azx_single_get_response(bus, addr);
+		return azx_single_get_response(bus, addr, res);
 	else
-		return azx_rirb_get_response(bus, addr);
+		return azx_rirb_get_response(bus, addr, res);
 }
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
@@ -1762,15 +1762,16 @@ static int probe_codec(struct azx *chip, int addr)
 {
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	int err;
 	unsigned int res;
 
 	mutex_lock(&chip->bus->core.cmd_mutex);
 	chip->probing = 1;
 	azx_send_cmd(chip->bus, cmd);
-	res = azx_get_response(chip->bus, addr);
+	err = azx_get_response(chip->bus, addr, &res);
 	chip->probing = 0;
 	mutex_unlock(&chip->bus->core.cmd_mutex);
-	if (res == -1)
+	if (err < 0 || res == -1)
 		return -EIO;
 	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);
 	return 0;
-- 
2.3.5
