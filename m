From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: alsa-driver-1.0.0pre3 with linux-2.2.25: pci_name?
Date: Wed, 26 Nov 2003 23:45:52 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031126234552.50CEA4955@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

Takashi Iwai <tiwai@suse.de> wrote on Tue, 25 Nov 2003:
> right now the ALSA 1.0.0pre3 packages are released.
[...]
> The 2.2 kernel is still not tested well.  If you can test it, please
> let us know.

alsa-driver-1.0.0pre3/acore/pci_compat_22.c:line 371, refers to

	char *pci_name(struct pci_dev *)

which does not appear in the linux-2.2.x kernels.

In linux-2.4.x/include/linux/pci.h, struct pci_dev includes a
slot_name entry that doesn't appear in the linux-2.2.25 version.

Without fully appreciating the code, the alsa-driver successfully
builds by changing acore/pci_compat_22.c: line 371, like this

-		pci_name(pdev));
+		res_name);

Unfortunately, the snd-interwave modules fails to load afterwards.
The temporary fix above is surely not the cause of this, but I'll
say more in a separate message.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
