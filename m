From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: lx6464es - include mac address in device
	name
Date: Fri, 24 Jun 2011 17:36:20 +0200
Message-ID: <33902511f2861df4ef513785464b0db0a8ab2133.1308929468.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 77102103B55
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 17:36:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

each device has a unique mac address, which can be used to distinguish
multiple devices in the same machine. we therefore include the full mac
address in the device shortname and the last 6 bytes in the device id.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.c |   21 +++++++++++++--------
 sound/pci/lx6464es/lx6464es.h |    2 ++
 sound/pci/lx6464es/lx_core.c  |   14 +++++++-------
 sound/pci/lx6464es/lx_core.h  |    2 +-
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 1bd7a54..2736cf1 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -762,7 +762,6 @@ static int lx_set_granularity(struct lx6464es *chip, u32 gran)
 static int __devinit lx_init_dsp(struct lx6464es *chip)
 {
 	int err;
-	u8 mac_address[6];
 	int i;
 
 	snd_printdd("->lx_init_dsp\n");
@@ -787,11 +786,11 @@ static int __devinit lx_init_dsp(struct lx6464es *chip)
 	/** \todo the mac address should be ready by not, but it isn't,
 	 *  so we wait for it */
 	for (i = 0; i != 1000; ++i) {
-		err = lx_dsp_get_mac(chip, mac_address);
+		err = lx_dsp_get_mac(chip);
 		if (err)
 			return err;
-		if (mac_address[0] || mac_address[1] || mac_address[2] ||
-		    mac_address[3] || mac_address[4] || mac_address[5])
+		if (chip->mac_address[0] || chip->mac_address[1] || chip->mac_address[2] ||
+		    chip->mac_address[3] || chip->mac_address[4] || chip->mac_address[5])
 			goto mac_ready;
 		msleep(1);
 	}
@@ -800,8 +799,8 @@ static int __devinit lx_init_dsp(struct lx6464es *chip)
 mac_ready:
 	snd_printd(LXP "mac address ready read after: %dms\n", i);
 	snd_printk(LXP "mac address: %02X.%02X.%02X.%02X.%02X.%02X\n",
-		   mac_address[0], mac_address[1], mac_address[2],
-		   mac_address[3], mac_address[4], mac_address[5]);
+		   chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
+		   chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
 
 	err = lx_init_get_version_features(chip);
 	if (err)
@@ -1108,8 +1107,14 @@ static int __devinit snd_lx6464es_probe(struct pci_dev *pci,
 		goto out_free;
 	}
 
-	strcpy(card->driver, "lx6464es");
-	strcpy(card->shortname, "Digigram LX6464ES");
+	strcpy(card->driver, "LX6464ES");
+	sprintf(card->id, "LX6464ES_%02X%02X%02X",
+		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
+
+	sprintf(card->shortname, "LX6464ES %02X.%02X.%02X.%02X.%02X.%02X",
+		chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
+		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
+
 	sprintf(card->longname, "%s at 0x%lx, 0x%p, irq %i",
 		card->shortname, chip->port_plx,
 		chip->port_dsp_bar, chip->irq);
diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.h
index aea621e..e2a124a 100644
--- a/sound/pci/lx6464es/lx6464es.h
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -69,6 +69,8 @@ struct lx6464es {
 	struct pci_dev         *pci;
 	int			irq;
 
+	u8			mac_address[6];
+
 	spinlock_t		lock;        /* interrupt spinlock */
 	struct mutex            setup_mutex; /* mutex used in hw_params, open
 					      * and close */
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 617f98b..5c8717e 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -424,7 +424,7 @@ int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 	return ret;
 }
 
-int lx_dsp_get_mac(struct lx6464es *chip, u8 *mac_address)
+int lx_dsp_get_mac(struct lx6464es *chip)
 {
 	u32 macmsb, maclsb;
 
@@ -432,12 +432,12 @@ int lx_dsp_get_mac(struct lx6464es *chip, u8 *mac_address)
 	maclsb = lx_dsp_reg_read(chip, eReg_ADMACESLSB) & 0x00FFFFFF;
 
 	/* todo: endianess handling */
-	mac_address[5] = ((u8 *)(&maclsb))[0];
-	mac_address[4] = ((u8 *)(&maclsb))[1];
-	mac_address[3] = ((u8 *)(&maclsb))[2];
-	mac_address[2] = ((u8 *)(&macmsb))[0];
-	mac_address[1] = ((u8 *)(&macmsb))[1];
-	mac_address[0] = ((u8 *)(&macmsb))[2];
+	chip->mac_address[5] = ((u8 *)(&maclsb))[0];
+	chip->mac_address[4] = ((u8 *)(&maclsb))[1];
+	chip->mac_address[3] = ((u8 *)(&maclsb))[2];
+	chip->mac_address[2] = ((u8 *)(&macmsb))[0];
+	chip->mac_address[1] = ((u8 *)(&macmsb))[1];
+	chip->mac_address[0] = ((u8 *)(&macmsb))[2];
 
 	return 0;
 }
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
index 6bd9cbb..1dd5629 100644
--- a/sound/pci/lx6464es/lx_core.h
+++ b/sound/pci/lx6464es/lx_core.h
@@ -116,7 +116,7 @@ int __devinit lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version);
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq);
 int lx_dsp_set_granularity(struct lx6464es *chip, u32 gran);
 int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data);
-int lx_dsp_get_mac(struct lx6464es *chip, u8 *mac_address);
+int lx_dsp_get_mac(struct lx6464es *chip);
 
 
 /* low-level pipe handling */
-- 
1.7.4.1
