From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Bug 2552 typo in ice1724.c
Date: Mon, 5 Jan 2009 11:29:21 +0000
Message-ID: <200901051129.21564.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R8eYJBzeO9xZPnk"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 35D0C103801
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 12:16:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_R8eYJBzeO9xZPnk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I noticed this trivial typo report on bugtrack, -no 2552 and thought it may as 
well be fixed, and the bug closed.  Patch inline & attached.  Not sure if it 
needs a sign-off?

Alan

ice1724.c-name-typo-fix.diff

Fix trivial name string typo as reported in bug 2552

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--- alsa-kernel/pci/ice1712/ice1724-orig.c	2008-06-27 09:11:58.000000000 +0100
+++ alsa-kernel/pci/ice1712/ice1724.c	2009-01-05 11:11:33.000000000 +0000
@@ -1239,7 +1239,7 @@
 	if (ice->force_pdma4 || ice->force_rdma1)
 		name = "ICE1724 Secondary";
 	else
-		name = "IEC1724 IEC958";
+		name = "ICE1724 IEC958";
 	err = snd_pcm_new(ice->card, name, device, play, capt, &pcm);
 	if (err < 0)
 		return err;




--Boundary-00=_R8eYJBzeO9xZPnk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ice1724.c-bug2552-name-typo-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1724.c-bug2552-name-typo-fix.diff"

--- alsa-kernel/pci/ice1712/ice1724-orig.c	2008-06-27 09:11:58.000000000 +0100
+++ alsa-kernel/pci/ice1712/ice1724.c	2009-01-05 11:11:33.000000000 +0000
@@ -1239,7 +1239,7 @@
 	if (ice->force_pdma4 || ice->force_rdma1)
 		name = "ICE1724 Secondary";
 	else
-		name = "IEC1724 IEC958";
+		name = "ICE1724 IEC958";
 	err = snd_pcm_new(ice->card, name, device, play, capt, &pcm);
 	if (err < 0)
 		return err;

--Boundary-00=_R8eYJBzeO9xZPnk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_R8eYJBzeO9xZPnk--
