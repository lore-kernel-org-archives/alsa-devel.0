From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] sound/isa : check __copy_to_user in sscape_upload_bootblock()
Date: Sun, 28 Nov 2004 22:35:23 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0411282225200.3389@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.dif.dk (mail.dif.dk [193.138.115.101])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98BA5297
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 22:25:38 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by mail.dif.dk (Postfix) with ESMTP id 2DE0DFF416
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 22:27:21 +0100 (CET)
Received: from mail.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21709-08 for <alsa-devel@alsa-project.org>;
 Sun, 28 Nov 2004 22:27:20 +0100 (CET)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by mail.dif.dk (Postfix) with ESMTP id 7FCBAFF413
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 22:27:20 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


__copy_to_user() is called without checking its return value in 
sound/isa/sscape.c::sscape_upload_bootblock . 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -p -U 5 linux-2.6.10-rc2-bk11-orig/sound/isa/sscape.c linux-2.6.10-rc2-bk11/sound/isa/sscape.c
--- linux-2.6.10-rc2-bk11-orig/sound/isa/sscape.c	2004-11-17 01:20:39.000000000 +0100
+++ linux-2.6.10-rc2-bk11/sound/isa/sscape.c	2004-11-28 22:24:14.000000000 +0100
@@ -570,11 +570,12 @@ static int sscape_upload_bootblock(struc
 	if (ret == 0) {
 		if (data < 0) {
 			snd_printk(KERN_ERR "sscape: timeout reading firmware version\n");
 			ret = -EAGAIN;
 		} else {
-			__copy_to_user(&bb->version, &data, sizeof(bb->version));
+			if (__copy_to_user(&bb->version, &data, sizeof(bb->version)))
+				ret = -EFAULT;
 		}
 	}
 
 	return ret;
 }



-- 
Jesper Juhl

PS. Please CC me on replies from alsa-devel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
