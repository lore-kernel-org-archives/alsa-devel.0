From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH][Trivial] sound/pci/riptide/riptide.c: remove
 trailing whitespace
Date: Mon, 9 Apr 2012 00:27:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204090024570.11747@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F74103B49
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 00:27:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Peter Gruber <nokos@gmx.net>, alsa-devel@alsa-project.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There's a bunch of trailing whitespace at the top of the
sound/pci/riptide/riptide.c file - this patch gets rid of it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/pci/riptide/riptide.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 0481d94..a8b07be 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -21,29 +21,29 @@
 /*
   History:
    - 02/15/2004 first release
-   
+
   This Driver is based on the OSS Driver version from Linuxant (riptide-0.6lnxtbeta03111100)
   credits from the original files:
-  
-  MODULE NAME:        cnxt_rt.h                       
+
+  MODULE NAME:        cnxt_rt.h
   AUTHOR:             K. Lazarev  (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           02/1/2000     KNL
 
-  MODULE NAME:     int_mdl.c                       
+  MODULE NAME:     int_mdl.c
   AUTHOR:          Konstantin Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/01/99      KNL
-	    
-  MODULE NAME:        riptide.h                       
+
+  MODULE NAME:        riptide.h
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/16/97      OLD
 
-  MODULE NAME:        Rp_Cmdif.cpp                       
+  MODULE NAME:        Rp_Cmdif.cpp
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
                       K. Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
@@ -51,7 +51,7 @@
             Adopted from NT4 driver            6/22/99      OLD
             Ported to Linux                    9/01/99      KNL
 
-  MODULE NAME:        rt_hw.c                       
+  MODULE NAME:        rt_hw.c
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
                       C. Lazarev    (Transcribed by CNL)
   HISTORY:         Major Revision               Date        By
@@ -73,13 +73,13 @@
             -----------------------------     --------     -----
             Created                           11/18/97      CNL
 
-  MODULE NAME:     rt_mdl.c                       
+  MODULE NAME:     rt_mdl.c
   AUTHOR:          Konstantin Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/01/99      KNL
 
-  MODULE NAME:        mixer.h                        
+  MODULE NAME:        mixer.h
   AUTHOR:             K. Kenney
   HISTORY:         Major Revision                   Date          By
             -----------------------------          --------     -----
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
