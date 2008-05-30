From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] PNP: set the pnp_card dma_mask for use by
	ISAPnP cards
Date: Sat, 31 May 2008 01:54:10 +0200
Message-ID: <484093A2.8060304@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
	<200805301543.42208.bjorn.helgaas@hp.com>
	<48407B99.4080209@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050004000406080804070800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AC33224431
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 01:51:07 +0200 (CEST)
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
--------------050004000406080804070800
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit




--------------050004000406080804070800
Content-Type: text/plain;
 name="0001-PNP-set-the-pnp_card-dma_mask-for-use-by-ISAPnP-c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-PNP-set-the-pnp_card-dma_mask-for-use-by-ISAPnP-c.patch"

>From 801c13fb3e8564221a1fb21892dbe13add3d7cea Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Fri, 30 May 2008 23:10:23 +0200
Subject: [PATCH] PNP: set the pnp_card dma_mask for use by ISAPnP cards.

dma_alloc_coherent() on x86 currently takes a passed in NULL device
pointer to mean that it should allocate an ISA compatible (24-bit)
buffer which is a bit of a hack.

The ALSA ISA drivers are the main consumers of this but have a struct
device in fact readily available.

For the PnP drivers, the specific pnp_dev->dev device pointer is not
always available at the right time so for now we want to pass the
pnp_card->dev instead which is always available. Set its dma_mask in
preparation for doing so.

This does not fix a current bug -- 2.6.26-rc1 stumbled over the NULL
hack in dma_alloc_coherent() but this has already been fixed in commit
4a367f3a9dbf2e7ffcee4702203479809236ee6e by Takashi Iwai.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/pnp/card.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index a762a41..b00ef10 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -8,6 +8,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/pnp.h>
+#include <linux/dma-mapping.h>
 #include "base.h"
 
 LIST_HEAD(pnp_cards);
@@ -167,6 +168,9 @@ struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnp
 	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
 		card->number);
 
+	card->dev.coherent_dma_mask = DMA_24BIT_MASK;
+	card->dev.dma_mask = &card->dev.coherent_dma_mask;
+
 	dev_id = pnp_add_card_id(card, pnpid);
 	if (!dev_id) {
 		kfree(card);
-- 
1.5.2.2


--------------050004000406080804070800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050004000406080804070800--
