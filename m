From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: jack: Remove MODULE_*() macros
Date: Thu, 21 May 2015 11:33:44 +0200
Message-ID: <1432200824-29510-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A6B82654B2
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 11:33:46 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 094DEAABA
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 09:33:46 +0000 (UTC)
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

The jack interface is statically included in sound core.  Having
doubly module information is rather confusing.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/jack.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index eb66327b5f1c..7237acbdcbbc 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -372,7 +372,3 @@ void snd_jack_report(struct snd_jack *jack, int status)
 
 }
 EXPORT_SYMBOL(snd_jack_report);
-
-MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-MODULE_DESCRIPTION("Jack detection support for ALSA");
-MODULE_LICENSE("GPL");
-- 
2.4.1
