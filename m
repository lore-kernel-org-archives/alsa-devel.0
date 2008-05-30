From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ISA: set 24-bit dma_mask for ISA devices.
Date: Sat, 31 May 2008 01:55:52 +0200
Message-ID: <48409408.8090901@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
	<200805301543.42208.bjorn.helgaas@hp.com>
	<48407B99.4080209@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A69924438
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 01:52:46 +0200 (CEST)
In-Reply-To: <48407B99.4080209@keyaccess.nl>
Content-Disposition: inline;
	filename="0002-ISA-set-24-bit-dma_mask-for-ISA-devices.patch"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

>From 56e4b14aa58612aeb41b51d73a75f85dd72127a1 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Sat, 31 May 2008 00:31:40 +0200
Subject: [PATCH] ISA: set 24-bit dma_mask for ISA devices.

dma_alloc_coherent() on x86 currently takes a passed in NULL device
pointer to mean that it should allocate an ISA compatible (24-bit)
buffer which is a bit of a hack.

The ALSA ISA drivers are the main consumers of this but have a struct
device in fact readily available.

For the legacy drivers, this sets the device dma_mask in preparation
for using the actual device with the DMA API so as to eventually not
need the NULL hack in dma_alloc_coherent().

This does not fix a current bug -- 2.6.26-rc1 stumbled over the NULL
hack in dma_alloc_coherent() but this has already been fixed in commit
4a367f3a9dbf2e7ffcee4702203479809236ee6e by Takashi Iwai.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/base/isa.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index d222239..efd5775 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <linux/isa.h>
 
 static struct device isa_bus = {
@@ -141,6 +142,9 @@ int isa_register_driver(struct isa_driver *isa_driver, unsigned int ndev)
 		isa_dev->dev.release		= isa_dev_release;
 		isa_dev->id			= id;
 
+		isa_dev->dev.coherent_dma_mask = DMA_24BIT_MASK;
+		isa_dev->dev.dma_mask = &isa_dev->dev.coherent_dma_mask;
+
 		error = device_register(&isa_dev->dev);
 		if (error) {
 			put_device(&isa_dev->dev);
-- 
1.5.2.2
