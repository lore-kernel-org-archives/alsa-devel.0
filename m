From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] sound: trivial warning fix for emu10k1
Date: Tue, 19 Apr 2005 23:45:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0504192338090.2074@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from saerimmer.dif.dk (mail.dif.dk [193.138.115.101])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C48BF1DA
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 23:42:14 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP id 294C3FF8EB
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 23:53:04 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10749-06 for <alsa-devel@alsa-project.org>;
 Tue, 19 Apr 2005 23:53:01 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP id CE5A8FF41C
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 23:53:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When building with gcc -W sound/pci/emu10k1/emupcm.c produces this little 
warning in 2.6.12-rc2-mm3 : 
  sound/pci/emu10k1/emupcm.c:265: warning: `inline' is not at beginning of declaration
No big deal, but trivial to fix.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 sound/pci/emu10k1/emupcm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3-orig/sound/pci/emu10k1/emupcm.c	2005-04-11 21:20:58.000000000 +0200
+++ linux-2.6.12-rc2-mm3/sound/pci/emu10k1/emupcm.c	2005-04-19 23:37:10.000000000 +0200
@@ -262,7 +262,7 @@ static unsigned int emu10k1_select_inter
  *
  * returns: cache invalidate size in samples
  */
-static int inline emu10k1_ccis(int stereo, int w_16)
+static inline int emu10k1_ccis(int stereo, int w_16)
 {
 	if (w_16) {
 		return stereo ? 24 : 26;




--- 
PS. Please CC me on replies.




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
