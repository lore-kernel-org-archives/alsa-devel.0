From: Martin Langer <martin-langer@gmx.de>
Subject: snd_pci_compat_release_region fix for 2.2
Date: Sun, 23 Nov 2003 15:45:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031123144557.GB583@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


here is another fix for 2.2 kernels:

martin


--- acore/pci_compat_22.c.ORIGINAL	Sun Nov 23 14:41:21 2003
+++ acore/pci_compat_22.c.FIX	Sun Nov 23 15:38:37 2003
@@ -371,7 +371,7 @@
 	return -EBUSY;
 }
 
-void snd_pci_compat_release_region(struct pci_dev *pci, int bar)
+void snd_pci_compat_release_region(struct pci_dev *pdev, int bar)
 {
 	int flags;
 	if (pci_resource_len(pdev, bar) == 0)



-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
