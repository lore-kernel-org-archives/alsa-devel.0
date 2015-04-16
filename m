From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/16] ALSA: hda - Move send_cmd / get_response
	to hdac_bus_ops
Date: Thu, 16 Apr 2015 18:14:20 +0200
Message-ID: <1429200870-5288-7-git-send-email-tiwai@suse.de>
References: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5562826155D
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
In-Reply-To: <1429200870-5288-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

One less redirection.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 22 ++--------------------
 sound/pci/hda/hda_codec.h      | 11 ++++++-----
 sound/pci/hda/hda_controller.c | 24 +++++++++++++++---------
 3 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b86e2f449e56..7e3dcaba6365 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -507,25 +507,6 @@ static int snd_hda_bus_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
-/* hdac_bus_ops translations */
-static int _hda_bus_command(struct hdac_bus *_bus, unsigned int cmd)
-{
-	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
-	return bus->ops.command(bus, cmd);
-}
-
-static int _hda_bus_get_response(struct hdac_bus *_bus, unsigned int addr,
-				 unsigned int *res)
-{
-	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
-	return bus->ops.get_response(bus, addr, res);
-}
-
-static const struct hdac_bus_ops bus_ops = {
-	.command = _hda_bus_command,
-	.get_response = _hda_bus_get_response,
-};
-
 /**
  * snd_hda_bus_new - create a HDA bus
  * @card: the card entry
@@ -534,6 +515,7 @@ static const struct hdac_bus_ops bus_ops = {
  * Returns 0 if successful, or a negative error code.
  */
 int snd_hda_bus_new(struct snd_card *card,
+		    const struct hdac_bus_ops *ops,
 		    struct hda_bus **busp)
 {
 	struct hda_bus *bus;
@@ -550,7 +532,7 @@ int snd_hda_bus_new(struct snd_card *card,
 	if (!bus)
 		return -ENOMEM;
 
-	err = snd_hdac_bus_init(&bus->core, card->dev, &bus_ops, NULL);
+	err = snd_hdac_bus_init(&bus->core, card->dev, ops, NULL);
 	if (err < 0) {
 		kfree(bus);
 		return err;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index fc4f76188a1d..b4261721d8f1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -42,10 +42,6 @@ struct hda_pcm_stream;
 
 /* bus operators */
 struct hda_bus_ops {
-	/* send a single command */
-	int (*command)(struct hda_bus *bus, unsigned int cmd);
-	/* get a response from the last command */
-	int (*get_response)(struct hda_bus *bus, unsigned int addr, unsigned int *res);
 	/* free the private data */
 	void (*private_free)(struct hda_bus *);
 	/* attach a PCM stream */
@@ -99,6 +95,9 @@ struct hda_bus {
 	int primary_dig_out_type;	/* primary digital out PCM type */
 };
 
+/* from hdac_bus to hda_bus */
+#define to_hda_bus(bus)		container_of(bus, struct hda_bus, core)
+
 /*
  * codec preset
  *
@@ -327,7 +326,9 @@ struct hda_codec {
 /*
  * constructors
  */
-int snd_hda_bus_new(struct snd_card *card, struct hda_bus **busp);
+int snd_hda_bus_new(struct snd_card *card,
+		    const struct hdac_bus_ops *ops,
+		    struct hda_bus **busp);
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 6b39f2e8c820..666dee232e95 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1328,8 +1328,9 @@ static int azx_single_get_response(struct hda_bus *bus, unsigned int addr,
  */
 
 /* send a command */
-static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
+static int azx_send_cmd(struct hdac_bus *_bus, unsigned int val)
 {
+	struct hda_bus *bus = to_hda_bus(_bus);
 	struct azx *chip = bus->private_data;
 
 	if (chip->disabled)
@@ -1342,9 +1343,10 @@ static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
 }
 
 /* get a response */
-static int azx_get_response(struct hda_bus *bus, unsigned int addr,
+static int azx_get_response(struct hdac_bus *_bus, unsigned int addr,
 			    unsigned int *res)
 {
+	struct hda_bus *bus = to_hda_bus(_bus);
 	struct azx *chip = bus->private_data;
 	if (chip->disabled)
 		return 0;
@@ -1354,6 +1356,11 @@ static int azx_get_response(struct hda_bus *bus, unsigned int addr,
 		return azx_rirb_get_response(bus, addr, res);
 }
 
+static const struct hdac_bus_ops bus_core_ops = {
+	.command = azx_send_cmd,
+	.get_response = azx_get_response,
+};
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 /*
  * DSP loading code (e.g. for CA0132)
@@ -1762,15 +1769,16 @@ static int probe_codec(struct azx *chip, int addr)
 {
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	struct hdac_bus *bus = &chip->bus->core;
 	int err;
 	unsigned int res;
 
-	mutex_lock(&chip->bus->core.cmd_mutex);
+	mutex_lock(&bus->cmd_mutex);
 	chip->probing = 1;
-	azx_send_cmd(chip->bus, cmd);
-	err = azx_get_response(chip->bus, addr, &res);
+	azx_send_cmd(bus, cmd);
+	err = azx_get_response(bus, addr, &res);
 	chip->probing = 0;
-	mutex_unlock(&chip->bus->core.cmd_mutex);
+	mutex_unlock(&bus->cmd_mutex);
 	if (err < 0 || res == -1)
 		return -EIO;
 	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);
@@ -1811,8 +1819,6 @@ static int get_jackpoll_interval(struct azx *chip)
 }
 
 static struct hda_bus_ops bus_ops = {
-	.command = azx_send_cmd,
-	.get_response = azx_get_response,
 	.attach_pcm = azx_attach_pcm_stream,
 	.bus_reset = azx_bus_reset,
 #ifdef CONFIG_SND_HDA_DSP_LOADER
@@ -1828,7 +1834,7 @@ int azx_bus_create(struct azx *chip, const char *model)
 	struct hda_bus *bus;
 	int err;
 
-	err = snd_hda_bus_new(chip->card, &bus);
+	err = snd_hda_bus_new(chip->card, &bus_core_ops, &bus);
 	if (err < 0)
 		return err;
 
-- 
2.3.5
