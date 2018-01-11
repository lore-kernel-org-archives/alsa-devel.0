From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] sound: Remove leftover msnd init
	declarations
Date: Thu, 11 Jan 2018 17:13:33 +0100
Message-ID: <20180111161333.13349-2-tiwai@suse.de>
References: <20180111161333.13349-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E4326790E
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 17:13:35 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C5DD1AE50
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 16:13:34 +0000 (UTC)
In-Reply-To: <20180111161333.13349-1-tiwai@suse.de>
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

Some obsoleted functions are still declared in sound_core.c.
Get rid of them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sound_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 8b026b66cf18..b4efb22db561 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -119,13 +119,6 @@ struct sound_unit
 	char name[32];
 };
 
-#ifdef CONFIG_SOUND_MSNDCLAS
-extern int msnd_classic_init(void);
-#endif
-#ifdef CONFIG_SOUND_MSNDPIN
-extern int msnd_pinnacle_init(void);
-#endif
-
 /*
  * By default, OSS sound_core claims full legacy minor range (0-255)
  * of SOUND_MAJOR to trap open attempts to any sound minor and
-- 
2.15.1
