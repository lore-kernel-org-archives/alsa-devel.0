From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: [PATCH] correct bug  [ALSA - driver 0001282] hda-intel driver, LFE
 mute does not work
Date: Thu, 28 Jul 2005 22:15:58 +0200
Message-ID: <42E93CFE.5000503@wanadoo.fr>
References: <361fa1fe47eda3d154a5a24eff83d340@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix3-1.free.fr (postfix3-1.free.fr [213.228.0.44])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B462515D
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 22:15:59 +0200 (MEST)
Received: from localhost.localdomain (rob92-2-82-66-38-107.fbx.proxad.net [82.66.38.107])
	by postfix3-1.free.fr (Postfix) with ESMTP id 2576E1734E5
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 22:15:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.52)
	id 1DyEnO-0006Al-Mc
	for alsa-devel@alsa-project.org; Thu, 28 Jul 2005 22:15:58 +0200
In-Reply-To: <361fa1fe47eda3d154a5a24eff83d340@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch correct the bug of updating mute switch of LFE 

Signed-off-by: Nicolas Graziano <nicolas.graziano@wanadoo.fr>

cf bug : <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1282> 


Index: pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.20
diff -u -r1.20 hda_codec.c
--- pci/hda/hda_codec.c	13 Jun 2005 13:16:39 -0000	1.20
+++ pci/hda/hda_codec.c	28 Jul 2005 20:04:22 -0000
@@ -801,7 +801,8 @@
 						  0x80, *valp ? 0 : 0x80);
 	if (chs & 2)
 		change |= snd_hda_codec_amp_update(codec, nid, 1, dir, idx,
-						   0x80, valp[1] ? 0 : 0x80);
+						   0x80, valp[chs==3 ? 1 : 0 ] ? 0 : 0x80);
+	
 	return change;
 }





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
