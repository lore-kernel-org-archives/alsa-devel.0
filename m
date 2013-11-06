From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/9] ASoC: wm5100: Replace BUG() with WARN()
Date: Wed,  6 Nov 2013 11:07:11 +0100
Message-ID: <1383732439-31441-2-git-send-email-tiwai@suse.de>
References: <1383732439-31441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F1DF526164C
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:07:22 +0100 (CET)
In-Reply-To: <1383732439-31441-1-git-send-email-tiwai@suse.de>
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
purpose, it'd be more convenient to use WARN() instead with more
error information.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm5100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4cf91deabc02..288e0ff33a2b 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1621,7 +1621,7 @@ static int wm5100_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		break;
 
 	default:
-		BUG();
+		WARN(1, "Invalid freq %d\n", freq);
 		audio_rate = 0;
 		break;
 	}
-- 
1.8.4.2
