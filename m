From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] sound/isa: kill pnp_resource_change.
Date: Thu, 29 Nov 2007 02:10:33 +0100
Message-ID: <474E1189.9030701@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050600040609060202030000"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EB0324BD0
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 02:10:53 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1444595nfd
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 17:10:52 -0800 (PST)
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050600040609060202030000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This removes the pnp_resource_change use from the ALSA ISAPnP drivers. In
2.4 these were useful in providing an easy path to setting the resources,
but in 2.6 they retain function as a layering violation only.

This makes for a nice cleanup (-550 lines) of ALSA but moreover, ALSA is the
only remaining user of pnp_init_resource_table(), pnp_resource_change() and
pnp_manual_config_dev() (and, in fact, of "struct pnp_resource_table") in
the tree outide of drivers/pnp itself meaning it makes for more cleanup
potential inside the PnP layer.

Thomas Renninger acked their removal from that side, you did from the ALSA
side (CC list just copied from that thread).

Against current alsa-kernel HG. Many more potential cleanups in there, but 
this _only_ removes the pnp_resource_change code. Compile tested against 
current alsa-kernel HG and compile- and use-tested against 2.6.23.x (few 
offsets).

Signed-off-by: Rene Herman <rene.herman@gmail.com>

  Documentation/ALSA-Configuration.txt |   35 ------------
  isa/ad1816a/ad1816a.c                |   55 ++-----------------
  isa/als100.c                         |   49 ----------------
  isa/azt2320.c                        |   50 -----------------
  isa/cmi8330.c                        |   42 +-------------
  isa/cs423x/cs4236.c                  |  101 
+++++++----------------------------
  isa/dt019x.c                         |   48 +---------------
  isa/es18xx.c                         |   58 +++-----------------
  isa/gus/interwave.c                  |   39 +------------
  isa/opl3sa2.c                        |   36 ------------
  isa/opti9xx/opti92x-ad1848.c         |   50 +----------------
  isa/sb/es968.c                       |   27 ---------
  isa/sb/sb16.c                        |   39 -------------
  isa/wavefront/wavefront.c            |   55 +------------------
  14 files changed, 65 insertions(+), 619 deletions(-)




--------------050600040609060202030000
Content-Type: text/plain;
 name="alsa-kernel_pnp_resource_change.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-kernel_pnp_resource_change.diff"

diff --git a/Documentation/ALSA-Configuration.txt b/Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt
+++ b/Documentation/ALSA-Configuration.txt
@@ -150,13 +150,6 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on Analog Devices AD1816A/AD1815 ISA chips.
 
-    port	- port # for AD1816A chip (PnP setup)
-    mpu_port	- port # for MPU-401 UART (PnP setup)
-    fm_port	- port # for OPL3 (PnP setup)
-    irq		- IRQ # for AD1816A chip (PnP setup)
-    mpu_irq	- IRQ # for MPU-401 UART (PnP setup)
-    dma1	- first DMA # for AD1816A chip (PnP setup)
-    dma2	- second DMA # for AD1816A chip (PnP setup)
     clockfreq   - Clock frequency for AD1816A chip (default = 0, 33000Hz)
     
     This module supports multiple cards, autoprobe and PnP.
@@ -203,14 +196,6 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on Avance Logic ALS100/ALS120 ISA chips.
 
-    port	- port # for ALS100 (SB16) chip (PnP setup)
-    irq		- IRQ # for ALS100 (SB16) chip (PnP setup)
-    dma8	- 8-bit DMA # for ALS100 (SB16) chip (PnP setup)
-    dma16	- 16-bit DMA # for ALS100 (SB16) chip (PnP setup)
-    mpu_port	- port # for MPU-401 UART (PnP setup)
-    mpu_irq	- IRQ # for MPU-401 (PnP setup)
-    fm_port	- port # for OPL3 FM (PnP setup)
-    
     This module supports multiple cards, autoprobe and PnP.
 
     The power-management is supported.
@@ -304,15 +289,6 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on Aztech System AZT2320 ISA chip (PnP only).
 
-    port	- port # for AZT2320 chip (PnP setup)
-    wss_port	- port # for WSS (PnP setup)
-    mpu_port	- port # for MPU-401 UART (PnP setup)
-    fm_port	- FM port # for AZT2320 chip (PnP setup)
-    irq		- IRQ # for AZT2320 (WSS) chip (PnP setup)
-    mpu_irq	- IRQ # for MPU-401 UART (PnP setup)
-    dma1	- 1st DMA # for AZT2320 (WSS) chip (PnP setup)
-    dma2	- 2nd DMA # for AZT2320 (WSS) chip (PnP setup)
-    
     This module supports multiple cards, PnP and autoprobe.
     
     The power-management is supported.
@@ -504,13 +480,6 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for Diamond Technologies DT-019X / Avance Logic ALS-007 (PnP
     only)
-
-    port	- Port # (PnP setup)
-    mpu_port	- Port # for MPU-401 (PnP setup)
-    fm_port	- Port # for FM OPL-3 (PnP setup)
-    irq		- IRQ # (PnP setup)
-    mpu_irq	- IRQ # for MPU-401 (PnP setup)
-    dma8	- DMA # (PnP setup)
 
     This module supports multiple cards.  This module is enabled only with
     ISA PnP support.
@@ -609,10 +578,6 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on ESS ES968 chip (PnP only).
 
-    port	- port # for ES968 (SB8) chip (PnP setup)
-    irq		- IRQ # for ES968 (SB8) chip (PnP setup)
-    dma1	- DMA # for ES968 (SB8) chip (PnP setup)
-    
     This module supports multiple cards, PnP and autoprobe.
     
     The power-management is supported.
diff --git a/isa/ad1816a/ad1816a.c b/isa/ad1816a/ad1816a.c
--- a/isa/ad1816a/ad1816a.c
+++ b/isa/ad1816a/ad1816a.c
@@ -61,20 +61,6 @@ MODULE_PARM_DESC(id, "ID string for ad18
 MODULE_PARM_DESC(id, "ID string for ad1816a based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable ad1816a based soundcard.");
-module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for ad1816a driver.");
-module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for ad1816a driver.");
-module_param_array(fm_port, long, NULL, 0444);
-MODULE_PARM_DESC(fm_port, "FM port # for ad1816a driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for ad1816a driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for ad1816a driver.");
-module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "1st DMA # for ad1816a driver.");
-module_param_array(dma2, int, NULL, 0444);
-MODULE_PARM_DESC(dma2, "2nd DMA # for ad1816a driver.");
 module_param_array(clockfreq, int, NULL, 0444);
 MODULE_PARM_DESC(clockfreq, "Clock frequency for ad1816a driver (default = 0).");
 
@@ -117,16 +103,12 @@ static int __devinit snd_card_ad1816a_pn
 					  const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree(cfg);
+	if (acard->dev == NULL)
 		return -EBUSY;
-	}
+
 	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, NULL);
 	if (acard->devmpu == NULL) {
 		mpu_port[dev] = -1;
@@ -134,25 +116,10 @@ static int __devinit snd_card_ad1816a_pn
 	}
 
 	pdev = acard->dev;
-	pnp_init_resource_table(cfg);
-
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], port[dev], 16);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "AUDIO PnP configure failure\n");
-		kfree(cfg);
 		return -EBUSY;
 	}
 
@@ -162,20 +129,11 @@ static int __devinit snd_card_ad1816a_pn
 	dma2[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
 
-	if (acard->devmpu == NULL) {
-		kfree(cfg);
+	if (acard->devmpu == NULL)
 		return 0;
-	}
+
 	pdev = acard->devmpu;
-	pnp_init_resource_table(cfg);
-
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-	if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
-
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "MPU401 PnP configure failure\n");
@@ -186,7 +144,6 @@ static int __devinit snd_card_ad1816a_pn
 		mpu_irq[dev] = pnp_irq(pdev, 0);
 	}
 
-	kfree(cfg);
 	return 0;
 }
 
diff --git a/isa/als100.c b/isa/als100.c
--- a/isa/als100.c
+++ b/isa/als100.c
@@ -63,20 +63,6 @@ MODULE_PARM_DESC(id, "ID string for als1
 MODULE_PARM_DESC(id, "ID string for als100 based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable als100 based soundcard.");
-module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for als100 driver.");
-module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for als100 driver.");
-module_param_array(fm_port, long, NULL, 0444);
-MODULE_PARM_DESC(fm_port, "FM port # for als100 driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for als100 driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for als100 driver.");
-module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for als100 driver.");
-module_param_array(dma16, int, NULL, 0444);
-MODULE_PARM_DESC(dma16, "16-bit DMA # for als100 driver.");
 
 struct snd_card_als100 {
 	int dev_no;
@@ -111,38 +97,20 @@ static int __devinit snd_card_als100_pnp
 					 const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree(cfg);
+	if (acard->dev == NULL)
 		return -ENODEV;
-	}
+
 	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, acard->dev);
 	acard->devopl = pnp_request_card_device(card, id->devs[2].id, acard->dev);
 
 	pdev = acard->dev;
 
-	pnp_init_resource_table(cfg);
-
-	/* override resources */
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (dma8[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
-	if (dma16[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma16[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
@@ -152,13 +120,6 @@ static int __devinit snd_card_als100_pnp
 
 	pdev = acard->devmpu;
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg);
-		if (mpu_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-			snd_printk(KERN_ERR PFX "MPU401 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0)
 			goto __mpu_error;
@@ -176,11 +137,6 @@ static int __devinit snd_card_als100_pnp
 
 	pdev = acard->devopl;
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg);
-		if (fm_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], fm_port[dev], 4);
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-			snd_printk(KERN_ERR PFX "OPL3 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0)
 			goto __fm_error;
@@ -195,7 +151,6 @@ static int __devinit snd_card_als100_pnp
 	     	fm_port[dev] = -1;
 	}
 
-	kfree(cfg);
 	return 0;
 }
 
diff --git a/isa/azt2320.c b/isa/azt2320.c
--- a/isa/azt2320.c
+++ b/isa/azt2320.c
@@ -72,22 +72,6 @@ MODULE_PARM_DESC(id, "ID string for azt2
 MODULE_PARM_DESC(id, "ID string for azt2320 based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable azt2320 based soundcard.");
-module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for azt2320 driver.");
-module_param_array(wss_port, long, NULL, 0444);
-MODULE_PARM_DESC(wss_port, "WSS Port # for azt2320 driver.");
-module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for azt2320 driver.");
-module_param_array(fm_port, long, NULL, 0444);
-MODULE_PARM_DESC(fm_port, "FM port # for azt2320 driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for azt2320 driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for azt2320 driver.");
-module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "1st DMA # for azt2320 driver.");
-module_param_array(dma2, int, NULL, 0444);
-MODULE_PARM_DESC(dma2, "2nd DMA # for azt2320 driver.");
 
 struct snd_card_azt2320 {
 	int dev_no;
@@ -121,43 +105,19 @@ static int __devinit snd_card_azt2320_pn
 					  const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
-
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree(cfg);
+	if (acard->dev == NULL)
 		return -ENODEV;
-	}
 
 	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, NULL);
 
 	pdev = acard->dev;
-	pnp_init_resource_table(cfg);
-
-	/* override resources */
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (wss_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], wss_port[dev], 4);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
 
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
@@ -169,13 +129,6 @@ static int __devinit snd_card_azt2320_pn
 
 	pdev = acard->devmpu;
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg);
-		if (mpu_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-			snd_printk(KERN_ERR PFX "MPU401 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0)
 			goto __mpu_error;
@@ -191,7 +144,6 @@ static int __devinit snd_card_azt2320_pn
 	     	mpu_port[dev] = -1;
 	}
 
-	kfree (cfg);
 	return 0;
 }
 
diff --git a/isa/cmi8330.c b/isa/cmi8330.c
--- a/isa/cmi8330.c
+++ b/isa/cmi8330.c
@@ -286,39 +286,21 @@ static int __devinit snd_cmi8330_pnp(int
 				     const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
 	acard->cap = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->cap == NULL) {
-		kfree(cfg);
+	if (acard->cap == NULL)
 		return -EBUSY;
-	}
+
 	acard->play = pnp_request_card_device(card, id->devs[1].id, NULL);
-	if (acard->play == NULL) {
-		kfree(cfg);
+	if (acard->play == NULL)
 		return -EBUSY;
-	}
 
 	pdev = acard->cap;
-	pnp_init_resource_table(cfg);
-	/* allocate AD1848 resources */
-	if (wssport[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], wssport[dev], 8);
-	if (wssdma[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], wssdma[dev], 1);
-	if (wssirq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], wssirq[dev], 1);
-
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR "CMI8330/C3D (AD1848) PnP manual resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "CMI8330/C3D (AD1848) PnP configure failure\n");
-		kfree(cfg);
 		return -EBUSY;
 	}
 	wssport[dev] = pnp_port_start(pdev, 0);
@@ -327,23 +309,10 @@ static int __devinit snd_cmi8330_pnp(int
 
 	/* allocate SB16 resources */
 	pdev = acard->play;
-	pnp_init_resource_table(cfg);
-	if (sbport[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], sbport[dev], 16);
-	if (sbdma8[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], sbdma8[dev], 1);
-	if (sbdma16[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], sbdma16[dev], 1);
-	if (sbirq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], sbirq[dev], 1);
-
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR "CMI8330/C3D (SB16) PnP manual resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "CMI8330/C3D (SB16) PnP configure failure\n");
-		kfree(cfg);
 		return -EBUSY;
 	}
 	sbport[dev] = pnp_port_start(pdev, 0);
@@ -351,7 +320,6 @@ static int __devinit snd_cmi8330_pnp(int
 	sbdma16[dev] = pnp_dma(pdev, 1);
 	sbirq[dev] = pnp_irq(pdev, 0);
 
-	kfree(cfg);
 	return 0;
 }
 #endif
diff --git a/isa/cs423x/cs4236.c b/isa/cs423x/cs4236.c
--- a/isa/cs423x/cs4236.c
+++ b/isa/cs423x/cs4236.c
@@ -270,29 +270,9 @@ MODULE_DEVICE_TABLE(pnp_card, snd_cs423x
 MODULE_DEVICE_TABLE(pnp_card, snd_cs423x_pnpids);
 
 /* WSS initialization */
-static int __devinit snd_cs423x_pnp_init_wss(int dev, struct pnp_dev *pdev,
-					     struct pnp_resource_table *cfg)
-{
-	int err;
-
-	pnp_init_resource_table(cfg);
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 4);
-	if (fm_port[dev] != SNDRV_AUTO_PORT && fm_port[dev] > 0)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (sb_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], sb_port[dev], 16);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev] < 0 ? 4 : dma2[dev], 1);
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR IDENT " WSS PnP manual resources are invalid, using auto config\n");
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
+static int __devinit snd_cs423x_pnp_init_wss(int dev, struct pnp_dev *pdev)
+{
+	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " WSS PnP configure failed for WSS (out of resources?)\n");
 		return -EBUSY;
 	}
@@ -311,19 +291,9 @@ static int __devinit snd_cs423x_pnp_init
 }
 
 /* CTRL initialization */
-static int __devinit snd_cs423x_pnp_init_ctrl(int dev, struct pnp_dev *pdev,
-					      struct pnp_resource_table *cfg)
-{
-	int err;
-
-	pnp_init_resource_table(cfg);
-	if (cport[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], cport[dev], 8);
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR IDENT " CTRL PnP manual resources are invalid, using auto config\n");
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
+static int __devinit snd_cs423x_pnp_init_ctrl(int dev, struct pnp_dev *pdev)
+{
+	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " CTRL PnP configure failed for WSS (out of resources?)\n");
 		return -EBUSY;
 	}
@@ -333,21 +303,9 @@ static int __devinit snd_cs423x_pnp_init
 }
 
 /* MPU initialization */
-static int __devinit snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev,
-					     struct pnp_resource_table *cfg)
-{
-	int err;
-
-	pnp_init_resource_table(cfg);
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-	if (mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] >= 0)
-		pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR IDENT " MPU401 PnP manual resources are invalid, using auto config\n");
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
+static int __devinit snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
+{
+	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " MPU401 PnP configure failed for WSS (out of resources?)\n");
 		mpu_port[dev] = SNDRV_AUTO_PORT;
 		mpu_irq[dev] = SNDRV_AUTO_IRQ;
@@ -368,15 +326,8 @@ static int __devinit snd_card_cs4232_pnp
 static int __devinit snd_card_cs4232_pnp(int dev, struct snd_card_cs4236 *acard,
 					 struct pnp_dev *pdev)
 {
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
-
-	if (!cfg)
-		return -ENOMEM;
-	if (snd_cs423x_pnp_init_wss(dev, acard->wss, cfg) < 0) {
-		kfree(cfg);
+	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
 		return -EBUSY;
-	}
-	kfree(cfg);
 	cport[dev] = -1;
 	return 0;
 }
@@ -386,43 +337,33 @@ static int __devinit snd_card_cs423x_pnp
 					  struct pnp_card_link *card,
 					  const struct pnp_card_device_id *id)
 {
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
-
-	if (!cfg)
-		return -ENOMEM;
-
 	acard->wss = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (acard->wss == NULL)
-		goto error;
+		return -EBUSY;
 	acard->ctrl = pnp_request_card_device(card, id->devs[1].id, NULL);
 	if (acard->ctrl == NULL)
-		goto error;
+		return -EBUSY;
 	if (id->devs[2].id[0]) {
 		acard->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
 		if (acard->mpu == NULL)
-			goto error;
+			return -EBUSY;
 	}
 
 	/* WSS initialization */
-	if (snd_cs423x_pnp_init_wss(dev, acard->wss, cfg) < 0)
-		goto error;
+	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
+		return -EBUSY;
 
 	/* CTRL initialization */
 	if (acard->ctrl && cport[dev] > 0) {
-		if (snd_cs423x_pnp_init_ctrl(dev, acard->ctrl, cfg) < 0)
-			goto error;
+		if (snd_cs423x_pnp_init_ctrl(dev, acard->ctrl) < 0)
+			return -EBUSY;
 	}
 	/* MPU initialization */
 	if (acard->mpu && mpu_port[dev] > 0) {
-		if (snd_cs423x_pnp_init_mpu(dev, acard->mpu, cfg) < 0)
-			goto error;
-	}
-	kfree(cfg);
-	return 0;
-
- error:
-	kfree(cfg);
-	return -EBUSY;
+		if (snd_cs423x_pnp_init_mpu(dev, acard->mpu) < 0)
+			return -EBUSY;
+	}
+	return 0;
 }
 #endif /* CONFIG_PNP */
 
diff --git a/isa/dt019x.c b/isa/dt019x.c
--- a/isa/dt019x.c
+++ b/isa/dt019x.c
@@ -56,18 +56,6 @@ MODULE_PARM_DESC(id, "ID string for DT-0
 MODULE_PARM_DESC(id, "ID string for DT-019X based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable DT-019X based soundcard.");
-module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for dt019x driver.");
-module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for dt019x driver.");
-module_param_array(fm_port, long, NULL, 0444);
-MODULE_PARM_DESC(fm_port, "FM port # for dt019x driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for dt019x driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for dt019x driver.");
-module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for dt019x driver.");
 
 struct snd_card_dt019x {
 	struct pnp_dev *dev;
@@ -95,36 +83,20 @@ static int __devinit snd_card_dt019x_pnp
 					 const struct pnp_card_device_id *pid)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
-
 	acard->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree (cfg);
+	if (acard->dev == NULL)
 		return -ENODEV;
-	}
+
 	acard->devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
 	acard->devopl = pnp_request_card_device(card, pid->devs[2].id, NULL);
 
 	pdev = acard->dev;
-	pnp_init_resource_table(cfg);
-
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (dma8[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-
-	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-		snd_printk(KERN_ERR PFX "DT-019X AUDIO the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "DT-019X AUDIO pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 
@@ -135,15 +107,7 @@ static int __devinit snd_card_dt019x_pnp
 			port[dev],irq[dev],dma8[dev]);
 
 	pdev = acard->devmpu;
-
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg);
-		if (mpu_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
-		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-			snd_printk(KERN_ERR PFX "DT-019X MPU401 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0) {
 			pnp_release_card_device(pdev);
@@ -162,11 +126,6 @@ static int __devinit snd_card_dt019x_pnp
 
 	pdev = acard->devopl;
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg);
-		if (fm_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], fm_port[dev], 4);
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-			snd_printk(KERN_ERR PFX "DT-019X OPL3 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0) {
 			pnp_release_card_device(pdev);
@@ -181,7 +140,6 @@ static int __devinit snd_card_dt019x_pnp
 		fm_port[dev] = -1;
 	}
 
-	kfree(cfg);
 	return 0;
 }
 
diff --git a/isa/es18xx.c b/isa/es18xx.c
--- a/isa/es18xx.c
+++ b/isa/es18xx.c
@@ -2035,31 +2035,9 @@ MODULE_DEVICE_TABLE(pnp, snd_audiodrive_
 MODULE_DEVICE_TABLE(pnp, snd_audiodrive_pnpbiosids);
 
 /* PnP main device initialization */
-static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev,
-						  struct pnp_resource_table *cfg)
-{
-	int err;
-
-	pnp_init_resource_table(cfg);
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], mpu_port[dev], 2);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if (pnp_device_is_isapnp(pdev)) {
-		err = pnp_manual_config_dev(pdev, cfg, 0);
-		if (err < 0)
-			snd_printk(KERN_ERR PFX "PnP manual resources are invalid, using auto config\n");
-	}
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
+static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
+{
+	if (pnp_activate_dev(pdev) < 0) {
 		snd_printk(KERN_ERR PFX "PnP configure failure (out of resources?)\n");
 		return -EBUSY;
 	}
@@ -2087,16 +2065,9 @@ static int __devinit snd_audiodrive_pnp(
 static int __devinit snd_audiodrive_pnp(int dev, struct snd_audiodrive *acard,
 					struct pnp_dev *pdev)
 {
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
-
-	if (!cfg)
-		return -ENOMEM;
 	acard->dev = pdev;
-	if (snd_audiodrive_pnp_init_main(dev, acard->dev, cfg) < 0) {
-		kfree(cfg);
+	if (snd_audiodrive_pnp_init_main(dev, acard->dev) < 0)
 		return -EBUSY;
-	}
-	kfree(cfg);
 	return 0;
 }
 
@@ -2125,33 +2096,24 @@ static int __devinit snd_audiodrive_pnpc
 					struct pnp_card_link *card,
 					const struct pnp_card_device_id *id)
 {
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
-
-	if (!cfg)
-		return -ENOMEM;
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree(cfg);
+	if (acard->dev == NULL)
 		return -EBUSY;
-	}
+
 	acard->devc = pnp_request_card_device(card, id->devs[1].id, NULL);
-	if (acard->devc == NULL) {
-		kfree(cfg);
+	if (acard->devc == NULL)
 		return -EBUSY;
-	}
+
 	/* Control port initialization */
 	if (pnp_activate_dev(acard->devc) < 0) {
-		kfree(cfg);
 		snd_printk(KERN_ERR PFX "PnP control configure failure (out of resources?)\n");
 		return -EAGAIN;
 	}
 	snd_printdd("pnp: port=0x%llx\n",
 			(unsigned long long)pnp_port_start(acard->devc, 0));
-	if (snd_audiodrive_pnp_init_main(dev, acard->dev, cfg) < 0) {
-		kfree(cfg);
+	if (snd_audiodrive_pnp_init_main(dev, acard->dev) < 0)
 		return -EBUSY;
-	}
-	kfree(cfg);
+
 	return 0;
 }
 #endif /* CONFIG_PNP */
diff --git a/isa/gus/interwave.c b/isa/gus/interwave.c
--- a/isa/gus/interwave.c
+++ b/isa/gus/interwave.c
@@ -560,50 +560,27 @@ static int __devinit snd_interwave_pnp(i
 				       const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
 	iwcard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (iwcard->dev == NULL) {
-		kfree(cfg);
+	if (iwcard->dev == NULL)
 		return -EBUSY;
-	}
+
 #ifdef SNDRV_STB
 	iwcard->devtc = pnp_request_card_device(card, id->devs[1].id, NULL);
-	if (iwcard->devtc == NULL) {
-		kfree(cfg);
+	if (iwcard->devtc == NULL)
 		return -EBUSY;
-	}
 #endif
 	/* Synth & Codec initialization */
 	pdev = iwcard->dev;
-	pnp_init_resource_table(cfg);
-	if (port[dev] != SNDRV_AUTO_PORT) {
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-		pnp_resource_change(&cfg->port_resource[1], port[dev] + 0x100, 12);
-		pnp_resource_change(&cfg->port_resource[2], port[dev] + 0x10c, 4);
-	}
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (dma2[dev] < 0)
-		pnp_resource_change(&cfg->dma_resource[1], 4, 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-        if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR "InterWave - Synth - the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
-		kfree(cfg);
 		snd_printk(KERN_ERR "InterWave PnP configure failure (out of resources?)\n");
 		return err;
 	}
 	if (pnp_port_start(pdev, 0) + 0x100 != pnp_port_start(pdev, 1) ||
 	    pnp_port_start(pdev, 0) + 0x10c != pnp_port_start(pdev, 2)) {
-		kfree(cfg);
 		snd_printk(KERN_ERR "PnP configure failure (wrong ports)\n");
 		return -ENOENT;
 	}
@@ -620,21 +597,15 @@ static int __devinit snd_interwave_pnp(i
 #ifdef SNDRV_STB
 	/* Tone Control initialization */
 	pdev = iwcard->devtc;
-	pnp_init_resource_table(cfg);
-	if (port_tc[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port_tc[dev], 1);
-        if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR "InterWave - ToneControl - the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
-		kfree(cfg);
 		snd_printk(KERN_ERR "InterWave ToneControl PnP configure failure (out of resources?)\n");
 		return err;
 	}
 	port_tc[dev] = pnp_port_start(pdev, 0);
 	snd_printdd("isapnp IW: tone control port=0x%lx\n", port_tc[dev]);
 #endif
-	kfree(cfg);
 	return 0;
 }
 #endif /* CONFIG_PNP */
diff --git a/isa/opl3sa2.c b/isa/opl3sa2.c
--- a/isa/opl3sa2.c
+++ b/isa/opl3sa2.c
@@ -610,39 +610,8 @@ static int __devinit snd_opl3sa2_pnp(int
 static int __devinit snd_opl3sa2_pnp(int dev, struct snd_opl3sa2 *chip,
 				     struct pnp_dev *pdev)
 {
-	struct pnp_resource_table * cfg;
-	int err;
-
-	cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
-	if (!cfg) {
-		snd_printk(KERN_ERR PFX "cannot allocate pnp cfg\n");
-		return -ENOMEM;
-	}
-	/* PnP initialization */
-	pnp_init_resource_table(cfg);
-	if (sb_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], sb_port[dev], 16);
-	if (wss_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], wss_port[dev], 8);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], fm_port[dev], 4);
-	if (midi_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[3], midi_port[dev], 2);
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[4], port[dev], 2);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_WARNING "PnP manual resources are invalid, using auto config\n");
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
-		kfree(cfg);
-		snd_printk(KERN_ERR "PnP configure failure (out of resources?) err = %d\n", err);
+	if (pnp_activate_dev(pdev) < 0) {
+		snd_printk(KERN_ERR "PnP configure failure (out of resources?)\n");
 		return -EBUSY;
 	}
 	sb_port[dev] = pnp_port_start(pdev, 0);
@@ -657,7 +626,6 @@ static int __devinit snd_opl3sa2_pnp(int
 		pnp_device_is_pnpbios(pdev) ? "BIOS" : "ISA", sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
 	snd_printdd("%sPnP OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, irq=%i\n",
 		pnp_device_is_pnpbios(pdev) ? "BIOS" : "ISA", port[dev], dma1[dev], dma2[dev], irq[dev]);
-	kfree(cfg);
 	return 0;
 }
 #endif /* CONFIG_PNP */
diff --git a/isa/opti9xx/opti92x-ad1848.c b/isa/opti9xx/opti92x-ad1848.c
--- a/isa/opti9xx/opti92x-ad1848.c
+++ b/isa/opti9xx/opti92x-ad1848.c
@@ -1690,53 +1690,19 @@ static int __devinit snd_card_opti9xx_pn
 					  const struct pnp_card_device_id *pid)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
 	chip->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
-	if (chip->dev == NULL) {
-		kfree(cfg);
+	if (chip->dev == NULL)
 		return -EBUSY;
-	}
+
 	chip->devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
 
 	pdev = chip->dev;
-	pnp_init_resource_table(cfg);
-
-#ifdef OPTi93X
-	if (port != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port + 4, 4);
-#else
-	if (pid->driver_data != 0x0924 && port != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], port, 4);
-#endif	/* OPTi93X */
-	if (irq != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq, 1);
-	if (dma1 != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1, 1);
-#if defined(CS4231) || defined(OPTi93X)
-	if (dma2 != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2, 1);
-#else
-#ifdef snd_opti9xx_fixup_dma2
-	snd_opti9xx_fixup_dma2(pdev);
-#endif
-#endif	/* CS4231 || OPTi93X */
-#ifdef OPTi93X
-	if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port, 4);
-#else
-	if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], fm_port, 4);
-#endif
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR "AUDIO the requested resources are invalid, using auto config\n");
+
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "AUDIO pnp configure failure: %d\n", err);
-		kfree(cfg);
 		return err;
 	}
 
@@ -1756,15 +1722,6 @@ static int __devinit snd_card_opti9xx_pn
 
 	pdev = chip->devmpu;
 	if (pdev && mpu_port > 0) {
-		pnp_init_resource_table(cfg);
-
-		if (mpu_port != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], mpu_port, 2);
-		if (mpu_irq != SNDRV_AUTO_IRQ)
-			pnp_resource_change(&cfg->irq_resource[0], mpu_irq, 1);
-
-		if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-			snd_printk(KERN_ERR "AUDIO the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0) {
 			snd_printk(KERN_ERR "AUDIO pnp configure failure\n");
@@ -1775,7 +1732,6 @@ static int __devinit snd_card_opti9xx_pn
 			mpu_irq = pnp_irq(pdev, 0);
 		}
 	}
-	kfree(cfg);
 	return pid->driver_data;
 }
 #endif	/* CONFIG_PNP */
diff --git a/isa/sb/es968.c b/isa/sb/es968.c
--- a/isa/sb/es968.c
+++ b/isa/sb/es968.c
@@ -49,12 +49,6 @@ MODULE_PARM_DESC(id, "ID string for es96
 MODULE_PARM_DESC(id, "ID string for es968 based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable es968 based soundcard.");
-module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for es968 driver.");
-module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for es968 driver.");
-module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for es968 driver.");
 
 struct snd_card_es968 {
 	struct pnp_dev *dev;
@@ -86,40 +80,23 @@ static int __devinit snd_card_es968_pnp(
 					const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
-	if (!cfg)
-		return -ENOMEM;
+
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) {
-		kfree(cfg);
+	if (acard->dev == NULL)
 		return -ENODEV;
-	}
 
 	pdev = acard->dev;
 
-	pnp_init_resource_table(cfg);
-
-	/* override resources */
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (dma8[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
 	dma8[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
 
-	kfree(cfg);
 	return 0;
 }
 
diff --git a/isa/sb/sb16.c b/isa/sb/sb16.c
--- a/isa/sb/sb16.c
+++ b/isa/sb/sb16.c
@@ -257,44 +257,21 @@ static int __devinit snd_card_sb16_pnp(i
 				       const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
 	int err;
 
-	if (!cfg) 
-		return -ENOMEM; 
 	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL) { 
-		kfree(cfg); 
+	if (acard->dev == NULL)
 		return -ENODEV; 
-	} 
+
 #ifdef SNDRV_SBAWE_EMU8000
 	acard->devwt = pnp_request_card_device(card, id->devs[1].id, acard->dev);
 #endif
 	/* Audio initialization */
 	pdev = acard->dev;
 
-	pnp_init_resource_table(cfg); 
-	 
-	/* override resources */ 
-
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], mpu_port[dev], 2);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], fm_port[dev], 4);
-	if (dma8[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
-	if (dma16[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma16[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0) 
-		snd_printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n"); 
 	err = pnp_activate_dev(pdev); 
 	if (err < 0) { 
 		snd_printk(KERN_ERR PFX "AUDIO pnp configure failure\n"); 
-		kfree(cfg);
 		return err; 
 	} 
 	port[dev] = pnp_port_start(pdev, 0);
@@ -311,17 +288,6 @@ static int __devinit snd_card_sb16_pnp(i
 	/* WaveTable initialization */
 	pdev = acard->devwt;
 	if (pdev != NULL) {
-		pnp_init_resource_table(cfg); 
-	 
-		/* override resources */ 
-
-		if (awe_port[dev] != SNDRV_AUTO_PORT) {
-			pnp_resource_change(&cfg->port_resource[0], awe_port[dev], 4);
-			pnp_resource_change(&cfg->port_resource[1], awe_port[dev] + 0x400, 4);
-			pnp_resource_change(&cfg->port_resource[2], awe_port[dev] + 0x800, 4);
-		}
-		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0) 
-			snd_printk(KERN_ERR PFX "WaveTable the requested resources are invalid, using auto config\n"); 
 		err = pnp_activate_dev(pdev); 
 		if (err < 0) { 
 			goto __wt_error; 
@@ -339,7 +305,6 @@ __wt_error:
 		awe_port[dev] = -1;
 	}
 #endif
-	kfree(cfg);
 	return 0;
 }
 
diff --git a/isa/wavefront/wavefront.c b/isa/wavefront/wavefront.c
--- a/isa/wavefront/wavefront.c
+++ b/isa/wavefront/wavefront.c
@@ -104,21 +104,15 @@ snd_wavefront_pnp (int dev, snd_wavefron
 		   const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
-	struct pnp_resource_table *cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
 	int err;
 
-	if (!cfg)
-		return -ENOMEM;
-
 	/* Check for each logical device. */
 
 	/* CS4232 chip (aka "windows sound system") is logical device 0 */
 
 	acard->wss = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->wss == NULL) {
-		kfree(cfg);
+	if (acard->wss == NULL)
 		return -EBUSY;
-	}
 
 	/* there is a game port at logical device 1, but we ignore it completely */
 
@@ -133,25 +127,19 @@ snd_wavefront_pnp (int dev, snd_wavefron
 
 	if (use_cs4232_midi[dev]) {
 		acard->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
-		if (acard->mpu == NULL) {
-			kfree(cfg);
+		if (acard->mpu == NULL)
 			return -EBUSY;
-		}
 	}
 
 	/* The ICS2115 synth is logical device 4 */
 
 	acard->synth = pnp_request_card_device(card, id->devs[3].id, NULL);
-	if (acard->synth == NULL) {
-		kfree(cfg);
+	if (acard->synth == NULL)
 		return -EBUSY;
-	}
 
 	/* PCM/FM initialization */
 
 	pdev = acard->wss;
-
-	pnp_init_resource_table(cfg);
 
 	/* An interesting note from the Tropez+ FAQ:
 
@@ -165,23 +153,9 @@ snd_wavefront_pnp (int dev, snd_wavefron
 
 	*/
 
-	if (cs4232_pcm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], cs4232_pcm_port[dev], 4);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (cs4232_pcm_irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], cs4232_pcm_irq[dev], 1);
-
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR "PnP WSS the requested resources are invalid, using auto config\n");
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "PnP WSS pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 
@@ -195,22 +169,9 @@ snd_wavefront_pnp (int dev, snd_wavefron
 
 	pdev = acard->synth;
 	
-	pnp_init_resource_table(cfg);
-
-	if (ics2115_port[dev] != SNDRV_AUTO_PORT) {
-		pnp_resource_change(&cfg->port_resource[0], ics2115_port[dev], 16);
-	}
-		
-	if (ics2115_port[dev] != SNDRV_AUTO_IRQ) {
-		pnp_resource_change(&cfg->irq_resource[0], ics2115_irq[dev], 1);
-	}
-
-	if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-		snd_printk(KERN_ERR "PnP ICS2115 the requested resources are invalid, using auto config\n");
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "PnP ICS2115 pnp configure failure\n");
-		kfree(cfg);
 		return err;
 	}
 
@@ -226,15 +187,6 @@ snd_wavefront_pnp (int dev, snd_wavefron
 
 		pdev = acard->mpu;
 
-		pnp_init_resource_table(cfg);
-
-		if (cs4232_mpu_port[dev] != SNDRV_AUTO_PORT)
-			pnp_resource_change(&cfg->port_resource[0], cs4232_mpu_port[dev], 2);
-		if (cs4232_mpu_irq[dev] != SNDRV_AUTO_IRQ)
-			pnp_resource_change(&cfg->port_resource[0], cs4232_mpu_irq[dev], 1);
-
-		if (pnp_manual_config_dev(pdev, cfg, 0) < 0)
-			snd_printk(KERN_ERR "PnP MPU401 the requested resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0) {
 			snd_printk(KERN_ERR "PnP MPU401 pnp configure failure\n");
@@ -258,7 +210,6 @@ snd_wavefront_pnp (int dev, snd_wavefron
 		    ics2115_port[dev], 
 		    ics2115_irq[dev]);
 	
-	kfree(cfg);
 	return 0;
 }
 

--------------050600040609060202030000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050600040609060202030000--
