From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 5/5] Echoaudio - add suspend/resume support
Date: Sun, 14 Feb 2010 18:16:18 +0100
Message-ID: <20100214181618.6588c1e1@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out108.alice.it (smtp-out108.alice.it [85.37.17.108])
	by alsa0.perex.cz (Postfix) with ESMTP id 42184103819
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 18:17:11 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


5/5 Patchin' patcher:
	This patch updates alsa-driver echoaudio.patch .

Short description:

This patch updates alsa-driver echoaudio.patch .


Signed-off-by: Giuliano Pochini <pochini@shiny.it>


--- alsa-driver-1.0.22.1/pci/echoaudio/echoaudio.patch__orig	2009-12-28 16:15:54.000000000 +0100
+++ alsa-driver-1.0.22.1/pci/echoaudio/echoaudio.patch	2010-01-29 23:35:16.000000000 +0100
@@ -1,6 +1,6 @@
---- ../../alsa-kernel/pci/echoaudio/echoaudio.c	2006-08-05 14:41:12.000000000 +0200
-+++ echoaudio.c	2006-10-07 20:30:53.000000000 +0200
-@@ -1926,6 +1926,7 @@
+--- ../../alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-29 23:17:31.000000000 +0100
++++ echoaudio.c	2010-01-29 23:28:45.000000000 +0100
+@@ -1943,6 +1943,7 @@ static __devinit int snd_echo_create(str
  	struct echoaudio *chip;
  	int err;
  	size_t sz;
@@ -8,7 +8,7 @@
  	static struct snd_device_ops ops = {
  		.dev_free = snd_echo_dev_free,
  	};
-@@ -1988,7 +1989,12 @@
+@@ -2014,7 +2015,12 @@ static __devinit int snd_echo_create(str
  	chip->comm_page_phys = chip->commpage_dma_buf.addr;
  	chip->comm_page = (struct comm_page *)chip->commpage_dma_buf.area;
  
@@ -19,6 +19,28 @@
 +	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);
 +#endif
 +	err = init_hw(chip, chip->pci->device, subsystem_device);
- 	if (err) {
- 		DE_INIT(("init_hw err=%d\n", err));
- 		snd_echo_free(chip);
+ 	if (err >= 0)
+ 		err = set_mixer_defaults(chip);
+ 	if (err < 0) {
+@@ -2245,6 +2251,7 @@ static int snd_echo_resume(struct pci_de
+ 	struct comm_page *commpage, *commpage_bak;
+ 	u32 pipe_alloc_mask;
+ 	int err;
++	u16 subsystem_device;
+ 
+ 	DE_INIT(("resume start\n"));
+ 	pci_restore_state(pci);
+@@ -2252,7 +2259,12 @@ static int snd_echo_resume(struct pci_de
+ 	commpage = chip->comm_page;
+ 	memcpy(commpage_bak, commpage, sizeof(struct comm_page));
+ 
+-	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 0)
++	subsystem_device = pci->subsystem_device;
++#else
++	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);
++#endif
++	err = init_hw(chip, chip->pci->device, subsystem_device);
+ 	if (err < 0) {
+ 		kfree(commpage_bak);
+ 		DE_INIT(("resume init_hw err=%d\n", err));


-- 
Giuliano.
