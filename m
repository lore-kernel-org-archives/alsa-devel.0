From: Martin Langer <martin-langer@gmx.de>
Subject: Re: problems on alpha
Date: Sun, 23 Nov 2003 15:27:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031123142740.GA583@tuba.home>
References: <20031116175117.GA1174@tuba.home> <s5hvfpjjlqg.wl@alsa2.suse.de> <20031117212653.GB545@tuba.home> <s5hu152httj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu152httj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2003 at 11:09:12AM +0100, Takashi Iwai wrote:
> At Mon, 17 Nov 2003 22:26:54 +0100,
> Martin Langer wrote:
> (snip)
> > > grrr, they don't exist on 2.2 kernels...
> > > we need a wrapper for them.
> > > 
> > 
> > It's time to say good-bye to 2.2 users...
> 
> i fixed (part of) these problems on cvs tree.
> still i don't figure out why pmd_table() is not defined...

Thanks, Takashi.

But snd_pci_compat_pci_request_region in pre2 looks like a typo to me.
(because it doesn't fit to the entry in acore/memalloc.inc1)



--- alsa-driver/include/compat_22.h.ORIGI	Sun Nov 23 14:54:37 2003
+++ alsa-driver/include/compat_22.h	Sun Nov 23 14:55:14 2003
@@ -289,7 +289,7 @@
 int snd_pci_compat_set_dma_mask(struct pci_dev *, unsigned long mask);
 void * snd_pci_compat_get_driver_data (struct pci_dev *dev);
 void snd_pci_compat_set_driver_data (struct pci_dev *dev, void *driver_data);
-int snd_pci_compat_pci_request_region(struct pci_dev *pdev, int bar, char *res_name);
+int snd_pci_compat_request_region(struct pci_dev *pdev, int bar, char *res_name);
 void snd_pci_compat_release_region(struct pci_dev *pci, int bar);
 int snd_pci_compat_request_regions(struct pci_dev *pdev, char *res_name);
 void snd_pci_compat_release_regions(struct pci_dev *pdev);


--- alsa-driver/acore/pci_compat_22.c.ORIGINAL	Sun Nov 23 14:41:21 2003
+++ alsa-driver/acore/pci_compat_22.c	Sun Nov 23 14:41:44 2003
@@ -343,7 +343,7 @@
 
 /*
  */
-int snd_pci_compat_pci_request_region(struct pci_dev *pdev, int bar, char *res_name)
+int snd_pci_compat_request_region(struct pci_dev *pdev, int bar, char *res_name)
 {
 	int flags;
 


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
