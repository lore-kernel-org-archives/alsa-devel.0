From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: [PATCH 2/3] ALSA: intel8x0: improve virtual
	environment detection
Date: Wed, 9 Nov 2011 19:28:55 +0400
Message-ID: <1320852536-11786-3-git-send-email-kozerkov@parallels.com>
References: <1320852536-11786-1-git-send-email-kozerkov@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1320852536-11786-1-git-send-email-kozerkov@parallels.com>
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
Cc: "Denis V. Lunev" <den@openvz.org>, alsa-devel@alsa-project.org, Konstantin Ozerkov <kozerkov@parallels.com>
List-Id: alsa-devel@alsa-project.org

Detection code improved by PCI SSID usage. VM optimization
now enabled only for known devcices (skip host devices forwarded
to VM by VT-d or same kind of technology).
For debug/troubleshooting purposes optimization can be
forced (on/off) by module parameter: "inside_vm" (boolean).

Known devices (PCI SSID):
1af4:1100: Reserved for KVM devices. Note this is not yet
           implemented for KVM's ICH/AC'97 emulation.
1ab8:xxxx: Parallels ICH/AC'97 emulated sound.

Signed-off-by: Konstantin Ozerkov <kozerkov@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

diff --git a/pci/intel8x0.c b/pci/intel8x0.c
index d726d94..7db2a74 100644
--- a/pci/intel8x0.c
+++ b/pci/intel8x0.c
@@ -2930,20 +2930,41 @@ static unsigned int sis_codec_bits[3] = {
 	ICH_PCR, ICH_SCR, ICH_SIS_TCR
 };
 
-static int __devinit snd_intel8x0_inside_vm(void)
+static int __devinit snd_intel8x0_inside_vm(struct pci_dev *pci)
 {
-	int result = inside_vm;
+	int result  = inside_vm;
+	char* msg   = NULL;
 
-	if (result < 0) {
-		/* detect KVM and Parallels virtual environments */
-		result = kvm_para_available();
-#if defined(__i386__) || defined(__x86_64__)
-		result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
+	/* check module parameter first (override detection) */
+	if (result >= 0) {
+		msg = result ? "enable (forced) VM" : "disable (forced) VM";
+		goto fini;
+	}
+
+	/* detect KVM and Parallels virtual environments */
+	result = kvm_para_available();
+#ifdef X86_FEATURE_HYPERVISOR
+	result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
 #endif
+	if (!result)
+		goto fini;
+
+	/* check for known (emulated) devices */
+	if (pci->subsystem_vendor == 0x1af4 &&
+	    pci->subsystem_device == 0x1100) {
+		/* KVM emulated sound, PCI SSID: 1af4:1100 */
+		msg = "enable KVM";
+	} else if (pci->subsystem_vendor == 0x1ab8) {
+		/* Parallels VM emulated sound, PCI SSID: 1ab8:xxxx */
+		msg = "enable Parallels VM";
+	} else {
+		msg = "disable (unknown or VT-d) VM";
+		result = 0;
 	}
 
-	if (result)
-		printk(KERN_INFO "intel8x0: enable KVM optimization\n");
+fini:
+	if (msg != NULL)
+		printk(KERN_INFO "intel8x0: %s optimization\n", msg);
 
 	return result;
 }
@@ -3015,7 +3036,7 @@ static int __devinit snd_intel8x0_create(struct snd_card *card,
 	if (xbox)
 		chip->xbox = 1;
 
-	chip->inside_vm = snd_intel8x0_inside_vm();
+	chip->inside_vm = snd_intel8x0_inside_vm(pci);
 
 	if (pci->vendor == PCI_VENDOR_ID_INTEL &&
 	    pci->device == PCI_DEVICE_ID_INTEL_440MX)
-- 
1.7.1
