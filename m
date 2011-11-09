From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: [PATCH 1/3] ALSA: intel8x0: move virtual environment
	detection code into one place
Date: Wed, 9 Nov 2011 19:28:54 +0400
Message-ID: <1320852536-11786-2-git-send-email-kozerkov@parallels.com>
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

This is refactoring patch: preparation for add improved detection code.
Now all detection code placed in one place.

Signed-off-by: Konstantin Ozerkov <kozerkov@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

diff --git a/pci/intel8x0.c b/pci/intel8x0.c
index 45b2055..d726d94 100644
--- a/pci/intel8x0.c
+++ b/pci/intel8x0.c
@@ -2930,6 +2930,24 @@ static unsigned int sis_codec_bits[3] = {
 	ICH_PCR, ICH_SCR, ICH_SIS_TCR
 };
 
+static int __devinit snd_intel8x0_inside_vm(void)
+{
+	int result = inside_vm;
+
+	if (result < 0) {
+		/* detect KVM and Parallels virtual environments */
+		result = kvm_para_available();
+#if defined(__i386__) || defined(__x86_64__)
+		result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
+#endif
+	}
+
+	if (result)
+		printk(KERN_INFO "intel8x0: enable KVM optimization\n");
+
+	return result;
+}
+
 static int __devinit snd_intel8x0_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 unsigned long device_type,
@@ -2997,9 +3015,7 @@ static int __devinit snd_intel8x0_create(struct snd_card *card,
 	if (xbox)
 		chip->xbox = 1;
 
-	chip->inside_vm = inside_vm;
-	if (inside_vm)
-		printk(KERN_INFO "intel8x0: enable KVM optimization\n");
+	chip->inside_vm = snd_intel8x0_inside_vm();
 
 	if (pci->vendor == PCI_VENDOR_ID_INTEL &&
 	    pci->device == PCI_DEVICE_ID_INTEL_440MX)
@@ -3243,14 +3259,6 @@ static int __devinit snd_intel8x0_probe(struct pci_dev *pci,
 			buggy_irq = 0;
 	}
 
-	if (inside_vm < 0) {
-		/* detect KVM and Parallels virtual environments */
-		inside_vm = kvm_para_available();
-#if defined(__i386__) || defined(__x86_64__)
-		inside_vm = inside_vm || boot_cpu_has(X86_FEATURE_HYPERVISOR);
-#endif
-	}
-
 	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data,
 				       &chip)) < 0) {
 		snd_card_free(card);
-- 
1.7.1
