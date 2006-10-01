From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] emu10k1: Fix outl() in
	snd_emu10k1_resume_regs()
Date: Sun, 01 Oct 2006 20:39:33 +0200
Message-ID: <857izjdgnu.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx.duckcorp.org (orfeo.duckcorp.org [195.5.254.194])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6ABF016C
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Oct 2006 20:39:42 +0200 (MEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 27691218FF
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Oct 2006 20:39:42 +0200 (CEST)
Received: from mx.duckcorp.org ([127.0.0.1])
	by localhost (smtp.duckcorp.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tyMXctNphUt for <alsa-devel@alsa-project.org>;
	Sun,  1 Oct 2006 20:39:33 +0200 (CEST)
Received: from orfeo.duckcorp.org (localhost.localdomain [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id C7CB5218EC
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Oct 2006 20:39:33 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hi,


I've given a try to S3/S4 states on my box at home and it turned out
that I had to reenable the Analog/Digital output switch to get sound
again.
A quick look at the resume code showed that it was trying to restore the
A_IOCFG and HCFG ports content with arguments to outl() reversed.
My trivial patch fixes this issue.


Regards,
Arnaud


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=emu10k1_hcfg_regs_resume_fix.patch

The emu10k1 driver saves the A_IOCFG and HCFG register on suspend and restores
it on resumes. Unfortunately, this doesn't work as the arguments to outl() are
reversed.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

---
 sound/pci/emu10k1/emu10k1_main.c |    4 	2 +	2 -	0 !
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc7/sound/pci/emu10k1/emu10k1_main.c
===================================================================
--- linux-2.6.18-rc7.orig/sound/pci/emu10k1/emu10k1_main.c	2006-10-01 19:49:28.000000000 +0200
+++ linux-2.6.18-rc7/sound/pci/emu10k1/emu10k1_main.c	2006-10-01 20:21:08.000000000 +0200
@@ -1460,8 +1460,8 @@ void snd_emu10k1_resume_regs(struct snd_
 
 	/* resore for spdif */
 	if (emu->audigy)
-		outl(emu->port + A_IOCFG, emu->saved_a_iocfg);
-	outl(emu->port + HCFG, emu->saved_hcfg);
+		outl(emu->saved_a_iocfg, emu->port + A_IOCFG);
+	outl(emu->saved_hcfg, emu->port + HCFG);
 
 	val = emu->saved_ptr;
 	for (reg = saved_regs; *reg != 0xff; reg++)

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
