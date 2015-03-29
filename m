From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 76/86] sound/pci: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 15:42:59 +0200
Message-ID: <1427635734-24786-77-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 sound/pci/ctxfi/xfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index f2f3277..7e26876 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/initval.h>
-- 
MST
