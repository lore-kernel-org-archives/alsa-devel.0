From: Martin Langer <martin-langer@gmx.de>
Subject: Re: snd_pci_compat_release_region fix for 2.2
Date: Sun, 23 Nov 2003 20:50:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031123195045.GB11908@tuba.home>
References: <20031123144557.GB583@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031123144557.GB583@tuba.home>
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

On Sun, Nov 23, 2003 at 03:45:57PM +0100, Martin Langer wrote:
> 
> here is another fix for 2.2 kernels:
> 
> --- acore/pci_compat_22.c.ORIGINAL	Sun Nov 23 14:41:21 2003
> +++ acore/pci_compat_22.c.FIX	Sun Nov 23 15:38:37 2003
> @@ -371,7 +371,7 @@
>  	return -EBUSY;
>  }
>  
> -void snd_pci_compat_release_region(struct pci_dev *pci, int bar)
> +void snd_pci_compat_release_region(struct pci_dev *pdev, int bar)

Ohhh. I should change the header, too

martin


--- compat_22.h.ORIGINAL	Sun Nov 23 20:29:58 2003
+++ compat_22.h	Sun Nov 23 20:30:15 2003
@@ -290,7 +290,7 @@
 void * snd_pci_compat_get_driver_data (struct pci_dev *dev);
 void snd_pci_compat_set_driver_data (struct pci_dev *dev, void *driver_data);
 int snd_pci_compat_request_region(struct pci_dev *pdev, int bar, char *res_name);
-void snd_pci_compat_release_region(struct pci_dev *pci, int bar);
+void snd_pci_compat_release_region(struct pci_dev *pdev, int bar);
 int snd_pci_compat_request_regions(struct pci_dev *pdev, char *res_name);
 void snd_pci_compat_release_regions(struct pci_dev *pdev);
 


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
