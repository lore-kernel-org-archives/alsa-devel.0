From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: cs46xx: Fix memory leak at destructor
Date: Wed, 22 Jan 2014 08:22:43 +0100
Message-ID: <1390375363-24935-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E75E2608CF
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 08:22:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 96E86AAD1
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 07:22:43 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The release of module object itself was forgotten.
Spotted by COVERIY CID 1162828.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index f18e5878f58b..062398ec5335 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -369,6 +369,7 @@ static void free_module_desc(struct dsp_module_desc *module)
 			kfree(module->segments[i].data);
 		kfree(module->segments);
 	}
+	kfree(module);
 }
 
 /* firmware binary format:
-- 
1.8.5.2
