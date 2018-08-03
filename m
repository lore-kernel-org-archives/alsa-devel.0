From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: compress: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:33 +0200
Message-ID: <20180803143338.5363-2-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 184F32673A0
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:43 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EFE00ADC0
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 14:33:42 +0000 (UTC)
In-Reply-To: <20180803143338.5363-1-tiwai@suse.de>
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

For a sake of code simplification, remove the init and the exit
entries that do nothing.

Notes for readers: actually it's OK to remove *both* init and exit,
but not OK to remove the exit entry.  By removing only the exit while
keeping init, the module becomes permanently loaded; i.e. you cannot
unload it any longer!

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/compress_offload.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 4b01a37c836e..26b5e245b074 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1160,18 +1160,6 @@ int snd_compress_deregister(struct snd_compr *device)
 }
 EXPORT_SYMBOL_GPL(snd_compress_deregister);
 
-static int __init snd_compress_init(void)
-{
-	return 0;
-}
-
-static void __exit snd_compress_exit(void)
-{
-}
-
-module_init(snd_compress_init);
-module_exit(snd_compress_exit);
-
 MODULE_DESCRIPTION("ALSA Compressed offload framework");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0
