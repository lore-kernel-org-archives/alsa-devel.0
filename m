From: "J. Scott Amort" <jsamort@shaw.ca>
Subject: Re: Problem loading module snd-emu10k1
Date: Thu, 06 Nov 2003 23:44:55 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1068191094.24931.2.camel@enlightenment.baobobmusic.ca>
References: <1068183010.16578.15.camel@enlightenment.baobobmusic.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1068183010.16578.15.camel@enlightenment.baobobmusic.ca>
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

Well, I seemed to have solved this - found this patch:

Index: alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.18
diff -u -r1.18 emumixer.c
--- alsa-kernel/pci/emu10k1/emumixer.c	23 Oct 2003 14:34:53 -0000	1.18
+++ alsa-kernel/pci/emu10k1/emumixer.c	2 Nov 2003 11:23:13 -0000
@@ -540,10 +540,6 @@
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
-		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_control, emu)) == NULL)
-			return -ENOMEM;
-		if ((err = snd_ctl_add(card, kctl)))
-			return err;
 	}
 
 	if (emu->audigy) {

,applied it and presto!  Also, I discovered that Fedora Core 1 ships
with two versions of gcc - 3.3.2 and 3.2.3, the latter for kernel
compiling.  So, in addition to applying the patch, I compiled with the
3.2.3 gcc version.  Anyways, it works now, so I am happy.

Best Regards,

Scott



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
