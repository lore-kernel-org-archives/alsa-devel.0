From: linux@audioscience.com
Subject: [PATCH 25/28] Ensure all adapter data is cleared on
	device removal.
Date: Thu, 10 Feb 2011 17:26:18 +1300
Message-ID: <1297311981-30448-26-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpioctl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 0ea9aae..26186be 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -449,10 +449,8 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 		}
 	}
 
-	if (pa->p_buffer) {
-		pa->buffer_size = 0;
+	if (pa->p_buffer)
 		vfree(pa->p_buffer);
-	}
 
 	pci_set_drvdata(pci_dev, NULL);
 	if (1)
@@ -461,6 +459,8 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 			pci_dev->vendor, pci_dev->device,
 			pci_dev->subsystem_vendor, pci_dev->subsystem_device,
 			pci_dev->devfn, pa->index);
+
+	memset(pa, 0, sizeof(*pa));
 }
 
 void __init asihpi_init(void)
-- 
1.7.0.4
