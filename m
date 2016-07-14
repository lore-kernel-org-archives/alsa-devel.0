From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/34] pcm: change code formatting for
	_snd_pcm_softvol_open()
Date: Thu, 14 Jul 2016 23:07:38 +0900
Message-ID: <1468505271-5769-22-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 45CA72659DD
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit applies code format according to typical and moderate rule,
for _snd_pcm_softvol_open().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index fc45d6d..e2345b3 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -1085,8 +1085,7 @@ int _snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 		    sformat != SND_PCM_FORMAT_S24_3LE && 
 		    sformat != SND_PCM_FORMAT_S32_LE &&
 		    sformat != SND_PCM_FORMAT_S32_BE) {
-			SNDERR("only S16_LE, S16_BE, S24_3LE, S32_LE or S32_BE format "
-			       "is supported");
+			SNDERR("only S16_LE, S16_BE, S24_3LE, S32_LE or S32_BE format is supported");
 			snd_config_delete(sconf);
 			return -EINVAL;
 		}
@@ -1094,12 +1093,15 @@ int _snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 		snd_config_delete(sconf);
 		if (err < 0)
 			return err;
-		if ((err = snd_pcm_parse_control_id(control, ctl_id, &card, &cchannels, NULL)) < 0) {
+		err = snd_pcm_parse_control_id(control, ctl_id, &card,
+					       &cchannels, NULL);
+		if (err < 0) {
 			snd_pcm_close(spcm);
 			return err;
 		}
-		err = snd_pcm_softvol_open(pcmp, name, sformat, card, ctl_id, cchannels,
-					   min_dB, max_dB, resolution, spcm, 1);
+		err = snd_pcm_softvol_open(pcmp, name, sformat, card, ctl_id,
+					   cchannels, min_dB, max_dB,
+					   resolution, spcm, 1);
 		if (err < 0)
 			snd_pcm_close(spcm);
 	}
-- 
2.7.4
