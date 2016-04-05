From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: intel8x0: Drop superfluous VM checks
Date: Tue,  5 Apr 2016 16:53:14 +0200
Message-ID: <1459867994-22143-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D70ED26055E
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 16:53:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>, Konstantin Ozerkov <kozerkov@parallels.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

intel8x0 driver has the inside_vm check for skipping a buggy hardware
workaround in the PCM pointer callback in the commit [228cf79376f1:
ALSA: intel8x0: Improve performance in virtual environment].  This was
originally applied to all devices on known VMs, but the code was
switched to use the PCI  ID matching for applying to only known
devices (KVM and Parallels), in order to avoid applying wrongly to
VT-d and other such cases, in the commit [7fb4f392bd27: ALSA:
intel8x0: improve virtual environment detection].

Meanwhile, the original VM check was kept even after switching to the
PCI ID matching.  It was partly because we weren't 100% sure whether
we had covered all well, and partly because this would help
identifying the issue once when a user of another VM hit the same
problem or a regression.  Currently the VM check is used only for
showing the kernel message that the VM-optimization isn't applied, and
the VM check itself doesn't change the actual driver behavior at all.

Despite the relatively safe driver behavior, the code caught attention
of developers badly and brought many confusion / misunderstanding.
Since we've got neither regression nor enhancement report for other
VMs for five years long, it's likely safe to drop this superfluous VM
check now.

The module option is still kept, so if a user still needs to adjust,
it can be applied as was.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Konstantin Ozerkov <kozerkov@parallels.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 8151318a69a2..9720a30dbfff 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -42,12 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 
-#ifdef CONFIG_KVM_GUEST
-#include <linux/kvm_para.h>
-#else
-#define kvm_para_available() (0)
-#endif
-
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; SiS 7012; Ali 5455");
 MODULE_LICENSE("GPL");
@@ -2972,25 +2966,17 @@ static int snd_intel8x0_inside_vm(struct pci_dev *pci)
 		goto fini;
 	}
 
-	/* detect KVM and Parallels virtual environments */
-	result = kvm_para_available();
-#ifdef X86_FEATURE_HYPERVISOR
-	result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
-#endif
-	if (!result)
-		goto fini;
-
 	/* check for known (emulated) devices */
+	result = 0;
 	if (pci->subsystem_vendor == PCI_SUBVENDOR_ID_REDHAT_QUMRANET &&
 	    pci->subsystem_device == PCI_SUBDEVICE_ID_QEMU) {
 		/* KVM emulated sound, PCI SSID: 1af4:1100 */
 		msg = "enable KVM";
+		result = 1;
 	} else if (pci->subsystem_vendor == 0x1ab8) {
 		/* Parallels VM emulated sound, PCI SSID: 1ab8:xxxx */
 		msg = "enable Parallels VM";
-	} else {
-		msg = "disable (unknown or VT-d) VM";
-		result = 0;
+		result = 1;
 	}
 
 fini:
-- 
2.7.4
