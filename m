From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/31] ASoC: sh: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:40:06 +0100
Message-ID: <1383673218-18405-20-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7482A265272
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sh/siu_dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 9dc24ffa892a..d55babee14f8 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -543,7 +543,8 @@ static void siu_dai_shutdown(struct snd_pcm_substream *substream,
 	/* Stop the siu if the other stream is not using it */
 	if (!port_info->play_cap) {
 		/* during stmread or stmwrite ? */
-		BUG_ON(port_info->playback.rw_flg || port_info->capture.rw_flg);
+		if (WARN_ON(port_info->playback.rw_flg || port_info->capture.rw_flg))
+			return;
 		siu_dai_spbstop(port_info);
 		siu_dai_stop(port_info);
 	}
-- 
1.8.4.2
