From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: sh: Put missing KERN_* prefix
Date: Thu, 31 Aug 2017 11:33:34 +0200
Message-ID: <20170831093334.9050-7-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A312672C1
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:39 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 92DD9AF10
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
In-Reply-To: <20170831093334.9050-1-tiwai@suse.de>
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

sh audio driver prints its presence at probe function but a proper
KERN_ prefix is missing.  Put KERN_INFO there as it's merely an
advertisement.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/sh_dac_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index e71e6a718802..834b2574786f 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -424,7 +424,7 @@ static int snd_sh_dac_probe(struct platform_device *devptr)
 	if (err < 0)
 		goto probe_error;
 
-	snd_printk("ALSA driver for SuperH DAC audio");
+	snd_printk(KERN_INFO "ALSA driver for SuperH DAC audio");
 
 	platform_set_drvdata(devptr, card);
 	return 0;
-- 
2.14.1
