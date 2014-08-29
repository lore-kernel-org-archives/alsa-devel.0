From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: dice: fix wrong channel mappping at
	higher sampling rate
Date: Fri, 29 Aug 2014 13:40:44 +0900
Message-ID: <1409287245-15184-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1409287245-15184-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 24EFF266705
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 06:40:59 +0200 (CEST)
In-Reply-To: <1409287245-15184-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: drobbins@funtoo.org, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The channel mapping is initialized by amdtp_stream_set_parameters(), however
Dice driver set it before calling this function. Furthermore, the setting is
wrong because the index is the value of array, and vice versa.

This commit moves codes for channel mapping after the function and set it correctly.

Reported-by: Daniel Robbins <drobbins@funtoo.org>
Fixes: 10550bea44a8 ("ALSA: dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index a9a30c0..4cf8eb7 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -579,11 +579,6 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 			return err;
 		}
 
-		for (i = 0; i < channels; i++) {
-			dice->stream.pcm_positions[i * 2] = i;
-			dice->stream.pcm_positions[i * 2 + 1] = i + channels;
-		}
-
 		rate /= 2;
 		channels *= 2;
 	}
@@ -591,6 +586,15 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	mode = rate_index_to_mode(rate_index);
 	amdtp_stream_set_parameters(&dice->stream, rate, channels,
 				    dice->rx_midi_ports[mode]);
+	if (rate_index > 4) {
+		channels /= 2;
+
+		for (i = 0; i < channels; i++) {
+			dice->stream.pcm_positions[i] = i * 2;
+			dice->stream.pcm_positions[i + channels] = i * 2 + 1;
+		}
+	}
+
 	amdtp_stream_set_pcm_format(&dice->stream,
 				    params_format(hw_params));
 
-- 
1.9.1
