From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ISA: set 24-bit dma_mask for ISA devices.
Date: Sat, 31 May 2008 00:37:05 +0200
Message-ID: <48408191.6030104@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
	<200805301543.42208.bjorn.helgaas@hp.com>
	<48407B99.4080209@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050209050208090004020909"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 5589C2441D
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 00:34:02 +0200 (CEST)
In-Reply-To: <48407B99.4080209@keyaccess.nl>
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

This is a multi-part message in MIME format.
--------------050209050208090004020909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 31-05-08 00:11, Rene Herman wrote:

[ PNP: set the pnp_card dma_mask for use by ISAPnP cards. ]

> Thanks. I'll assume Andrew picks it up from the CC...

And here's the ISA one...

Rene.

--------------050209050208090004020909
Content-Type: text/plain;
 name="0001-ISA-set-24-bit-dma_mask-for-ISA-devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-ISA-set-24-bit-dma_mask-for-ISA-devices.patch"

>From 35f30388ad8536860719b3b44ea1f232b95ba42b Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Sat, 31 May 2008 00:31:40 +0200
Subject: [PATCH] ISA: set 24-bit dma_mask for ISA devices.

Set the ISA device dma_mask in preparation for using the actual device
with the DMA API.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
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


--------------050209050208090004020909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050209050208090004020909--
