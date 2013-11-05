From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/31] ASoC: wm8900: Replace BUG() with
	snd_BUG()
Date: Tue,  5 Nov 2013 18:40:11 +0100
Message-ID: <1383673218-18405-25-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43EE8265238
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG() used in the driver is just to spit the stack trace on buggy
points, not really needed to stop the whole operation.  For that
purpose, it'd be more convenient to use snd_BUG() instead.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index de67e74dca0c..64c9a3d062d4 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -279,7 +279,7 @@ static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		snd_BUG();
 	}
 
 	return 0;
-- 
1.8.4.2
