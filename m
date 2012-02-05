From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Sound,
 emu8000: Remove duplicate linux/moduleparam.h include from
 emu8000_patch.c
Date: Sun, 5 Feb 2012 01:27:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202050126080.30244@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 82CBA244B9
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2012 01:27:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The header 'linux/moduleparam.h' is included twice in
'sound/isa/sb/emu8000_patch.c'. Once is enough.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/isa/sb/emu8000_patch.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
index e09f144..c99c607 100644
--- a/sound/isa/sb/emu8000_patch.c
+++ b/sound/isa/sb/emu8000_patch.c
@@ -22,7 +22,6 @@
 #include "emu8000_local.h"
 #include <asm/uaccess.h>
 #include <linux/moduleparam.h>
-#include <linux/moduleparam.h>
 
 static int emu8000_reset_addr;
 module_param(emu8000_reset_addr, int, 0444);
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
