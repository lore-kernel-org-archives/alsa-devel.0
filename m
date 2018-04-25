From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] sound: usb: usx2y: Change return type to vm_fault_t
Date: Wed, 25 Apr 2018 09:44:45 +0530
Message-ID: <20180425041445.GA21283@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, viro@zeniv.linux.org.uk, johan@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 sound/usb/usx2y/us122l.c        | 2 +-
 sound/usb/usx2y/usX2Yhwdep.c    | 2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index ebcab5c..8082f7b 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -139,7 +139,7 @@ static void usb_stream_hwdep_vm_open(struct vm_area_struct *area)
 	snd_printdd(KERN_DEBUG "%i\n", atomic_read(&us122l->mmap_count));
 }

-static int usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
+static vm_fault_t usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page *page;
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index d8bd7c9..c1dd9a7 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -31,7 +31,7 @@
 #include "usbusx2y.h"
 #include "usX2Yhwdep.h"

-static int snd_us428ctls_vm_fault(struct vm_fault *vmf)
+static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page * page;
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 0d05052..4fd9276 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -652,7 +652,7 @@ static void snd_usX2Y_hwdep_pcm_vm_close(struct vm_area_struct *area)
 }


-static int snd_usX2Y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
+static vm_fault_t snd_usX2Y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	void *vaddr;
--
1.9.1
