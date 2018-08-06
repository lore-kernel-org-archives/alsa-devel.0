From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix wrong copy to rx parameters
	for Alesis iO26
Date: Mon,  6 Aug 2018 16:14:06 +0900
Message-ID: <20180806071406.24684-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7218F267692
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 09:14:15 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so6396108pfn.13
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2018 00:14:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A commit 28b208f600a3 ('ALSA: dice: add parameters of stream formats for
models produced by Alesis') adds wrong copy to rx parameters instead of
tx parameters for Alesis iO26.

This commit fixes the bug for v4.18-rc8.

Fixes: 28b208f600a3 ('ALSA: dice: add parameters of stream formats for models produced by Alesis')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-alesis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-alesis.c b/sound/firewire/dice/dice-alesis.c
index b2efb1c71a98..218292bdace6 100644
--- a/sound/firewire/dice/dice-alesis.c
+++ b/sound/firewire/dice/dice-alesis.c
@@ -37,7 +37,7 @@ int snd_dice_detect_alesis_formats(struct snd_dice *dice)
 				MAX_STREAMS * SND_DICE_RATE_MODE_COUNT *
 				sizeof(unsigned int));
 	} else {
-		memcpy(dice->rx_pcm_chs, alesis_io26_tx_pcm_chs,
+		memcpy(dice->tx_pcm_chs, alesis_io26_tx_pcm_chs,
 				MAX_STREAMS * SND_DICE_RATE_MODE_COUNT *
 				sizeof(unsigned int));
 	}
-- 
2.17.1
