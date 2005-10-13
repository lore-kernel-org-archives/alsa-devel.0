From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH 13/14] Big kfree NULL check cleanup - sound
Date: Thu, 13 Oct 2005 21:30:43 +0200
Message-ID: <200510132130.43423.jesper.juhl__38935.3405488238$1129232220$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.199])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F28516D
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2005 21:27:54 +0200 (MEST)
Received: by xproxy.gmail.com with SMTP id h26so296121wxd
        for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2005 12:27:53 -0700 (PDT)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Kyle McMartin <kyle@parisc-linux.org>, Thibaut Varene <varenet@parisc-linux.org>, perex@suse.cz, alsa-devel@alsa-project.org, Jesper Juhl <jesper.juhl@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is the sound/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in sound/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 sound/pci/ad1889.c        |    3 +--
 sound/pci/rme9652/hdspm.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc4-orig/sound/pci/rme9652/hdspm.c	2005-10-11 22:41:41.000000000 +0200
+++ linux-2.6.14-rc4/sound/pci/rme9652/hdspm.c	2005-10-13 11:49:26.000000000 +0200
@@ -3563,8 +3563,7 @@ static int snd_hdspm_free(hdspm_t * hdsp
 		free_irq(hdspm->irq, (void *) hdspm);
 
 
-	if (hdspm->mixer)
-		kfree(hdspm->mixer);
+	kfree(hdspm->mixer);
 
 	if (hdspm->iobase)
 		iounmap(hdspm->iobase);
--- linux-2.6.14-rc4-orig/sound/pci/ad1889.c	2005-10-11 22:41:36.000000000 +0200
+++ linux-2.6.14-rc4/sound/pci/ad1889.c	2005-10-13 11:49:33.000000000 +0200
@@ -982,8 +982,7 @@ snd_ad1889_create(snd_card_t *card,
 	return 0;
 
 free_and_ret:
-	if (chip)
-		kfree(chip);
+	kfree(chip);
 	pci_disable_device(pci);
 
 	return err;





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
