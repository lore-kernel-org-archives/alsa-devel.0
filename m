From: marcus hall <marcus@tuells.org>
Subject: Building for 2.4 kernel..
Date: Sun, 20 Jan 2008 17:28:45 -0700
Message-ID: <20080121002845.GA6526@bagatelle.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastille.tuells.org (unknown [204.188.108.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A827243FD
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 01:28:47 +0100 (CET)
Received: from bagatelle.tuells.org ([192.168.42.20])
	by bastille.tuells.org with esmtps (TLSv1:AES256-SHA:256) (Exim 4.68)
	(envelope-from <marcus@tuells.org>) id 1JGkWr-0008Nf-Gk
	for alsa-devel@alsa-project.org; Sun, 20 Jan 2008 17:28:46 -0700
Received: from marcus by bagatelle.tuells.org with local (Exim 4.68)
	(envelope-from <marcus@bagatelle.tuells.org>) id 1JGkWr-0001j2-GB
	for alsa-devel@alsa-project.org; Sun, 20 Jan 2008 17:28:45 -0700
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I support a product that is running the 2.4.18 linux kernel, and was trying
to install alsa-driver-1.0.15, and ran into a problem.

The alsa-kernel/pci/cs5535audio/cs5535audio_pm.c contains:

	if (pci_save_state(pci)) {
		...

and a similar line for pci_restore_state().

But, in include/adriver.h, pci_save_state is #defined to
snd_pci_compat_save_state, which is declared to return void, so the
compiler complains that the void return isn't being ignored.

Now, pci_save_state() appears to be supposed to return status, although
in the 2.4 kernel at least, it returns a constant 0.

Nevertheless, to get things to work, I changed snd_pci_compat_save_state(),
snd_pci_orig_save_state(), and the corresponding restore functions to return
an int with the following patch.  (The other obvious solution would be to
remove the test in cs5535audio_pm.c, but pci_save_state() is *supposed*
to return an int...)

--
Marcus Hall
marcus@tuells.org

---------

Index: alsa-driver/acore/misc_driver.c
===================================================================
RCS file: /usr/local/cvs_repos/almond/alsa/alsa-driver/acore/misc_driver.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- alsa-driver/acore/misc_driver.c	20 Jan 2008 16:52:35 -0000	1.1
+++ alsa-driver/acore/misc_driver.c	20 Jan 2008 17:14:23 -0000	1.2
@@ -105,14 +105,14 @@
 #ifdef CONFIG_PCI
 #ifndef CONFIG_HAVE_NEW_PCI_SAVE_STATE
 #ifdef CONFIG_HAVE_PCI_SAVED_CONFIG
-void snd_pci_compat_save_state(struct pci_dev *pci)
+int snd_pci_compat_save_state(struct pci_dev *pci)
 {
-	snd_pci_orig_save_state(pci, pci->saved_config_space);
+	return snd_pci_orig_save_state(pci, pci->saved_config_space);
 }
 EXPORT_SYMBOL(snd_pci_compat_save_state);
-void snd_pci_compat_restore_state(struct pci_dev *pci)
+int snd_pci_compat_restore_state(struct pci_dev *pci)
 {
-	snd_pci_orig_restore_state(pci, pci->saved_config_space);
+	return snd_pci_orig_restore_state(pci, pci->saved_config_space);
 }
 EXPORT_SYMBOL(snd_pci_compat_restore_state);
 #else /* !CONFIG_HAVE_PCI_SAVED_CONFIG */
@@ -122,7 +122,7 @@
 };
 static struct saved_config_tbl saved_tbl[16];
 
-void snd_pci_compat_save_state(struct pci_dev *pci)
+int snd_pci_compat_save_state(struct pci_dev *pci)
 {
 	int i;
 	/* FIXME: mutex needed for race? */
@@ -130,14 +130,15 @@
 		if (! saved_tbl[i].pci) {
 			saved_tbl[i].pci = pci;
 			snd_pci_orig_save_state(pci, saved_tbl[i].config);
-			return;
+			return 0;
 		}
 	}
 	printk(KERN_DEBUG "snd: no pci config space found!\n");
+	return 1;
 }
 EXPORT_SYMBOL(snd_pci_compat_save_state);
 
-void snd_pci_compat_restore_state(struct pci_dev *pci)
+int snd_pci_compat_restore_state(struct pci_dev *pci)
 {
 	int i;
 	/* FIXME: mutex needed for race? */
@@ -145,10 +146,11 @@
 		if (saved_tbl[i].pci == pci) {
 			saved_tbl[i].pci = NULL;
 			snd_pci_orig_restore_state(pci, saved_tbl[i].config);
-			return;
+			return 0;
 		}
 	}
 	printk(KERN_DEBUG "snd: no saved pci config!\n");
+	return 1;
 }
 EXPORT_SYMBOL(snd_pci_compat_restore_state);
 #endif /* CONFIG_HAVE_PCI_SAVED_CONFIG */
Index: alsa-driver/include/adriver.h
===================================================================
RCS file: /usr/local/cvs_repos/almond/alsa/alsa-driver/include/adriver.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- alsa-driver/include/adriver.h	20 Jan 2008 16:52:37 -0000	1.1
+++ alsa-driver/include/adriver.h	20 Jan 2008 17:14:23 -0000	1.2
@@ -1165,15 +1165,15 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
 #ifdef CONFIG_PCI
 #ifndef CONFIG_HAVE_NEW_PCI_SAVE_STATE
-void snd_pci_compat_save_state(struct pci_dev *pci);
-void snd_pci_compat_restore_state(struct pci_dev *pci);
-static inline void snd_pci_orig_save_state(struct pci_dev *pci, u32 *buffer)
+int snd_pci_compat_save_state(struct pci_dev *pci);
+int snd_pci_compat_restore_state(struct pci_dev *pci);
+static inline int snd_pci_orig_save_state(struct pci_dev *pci, u32 *buffer)
 {
-	pci_save_state(pci, buffer);
+	return pci_save_state(pci, buffer);
 }
-static inline void snd_pci_orig_restore_state(struct pci_dev *pci, u32 *buffer)
+static inline int snd_pci_orig_restore_state(struct pci_dev *pci, u32 *buffer)
 {
-	pci_restore_state(pci, buffer);
+	return pci_restore_state(pci, buffer);
 }
 
 #undef pci_save_state
