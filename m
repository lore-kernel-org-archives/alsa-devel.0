From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/20] sound/pci/asihpi: Use kzalloc
Date: Thu, 13 May 2010 21:58:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005132157400.6282@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than the combination of kmalloc and memset.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,size,flags;
statement S;
@@

-x = kmalloc(size,flags);
+x = kzalloc(size,flags);
 if (x == NULL) S
-memset(x, 0, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/pci/asihpi/hpi6000.c |    3 +--
 sound/pci/asihpi/hpi6205.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -u -p a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -448,14 +448,13 @@ static void subsys_create_adapter(struct
 	if (phm->u.s.resource.r.pci->device_id != HPI_PCI_DEV_ID_PCI2040)
 		return;
 
-	ao.priv = kmalloc(sizeof(struct hpi_hw_obj), GFP_KERNEL);
+	ao.priv = kzalloc(sizeof(struct hpi_hw_obj), GFP_KERNEL);
 	if (!ao.priv) {
 		HPI_DEBUG_LOG(ERROR, "cant get mem for adapter object\n");
 		phr->error = HPI_ERROR_MEMORY_ALLOC;
 		return;
 	}
 
-	memset(ao.priv, 0, sizeof(struct hpi_hw_obj));
 	/* create the adapter object based on the resource information */
 	/*? memcpy(&ao.Pci,&phm->u.s.Resource.r.Pci,sizeof(ao.Pci)); */
 	ao.pci = *phm->u.s.resource.r.pci;
diff -u -p a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -482,13 +482,12 @@ static void subsys_create_adapter(struct
 	if (phm->u.s.resource.r.pci->device_id != HPI_PCI_DEV_ID_DSP6205)
 		return;
 
-	ao.priv = kmalloc(sizeof(struct hpi_hw_obj), GFP_KERNEL);
+	ao.priv = kzalloc(sizeof(struct hpi_hw_obj), GFP_KERNEL);
 	if (!ao.priv) {
 		HPI_DEBUG_LOG(ERROR, "cant get mem for adapter object\n");
 		phr->error = HPI_ERROR_MEMORY_ALLOC;
 		return;
 	}
-	memset(ao.priv, 0, sizeof(struct hpi_hw_obj));
 
 	ao.pci = *phm->u.s.resource.r.pci;
 	err = create_adapter_obj(&ao, &os_error_code);
