From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix to handle correct stream for
	PCM playback
Date: Mon, 26 Aug 2019 22:55:15 +0900
Message-ID: <20190826135515.28019-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28F61F801ED
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 15:55:23 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When userspace application calls ioctl(2) to configure hardware for PCM
playback substream, ALSA OXFW driver handles incoming AMDTP stream.
In this case, outgoing AMDTP stream should be handled.

This commit fixes the bug for v5.3-rc kernel.

Fixes: 4f380d007052 ("ALSA: oxfw: configure packet format in pcm.hw_params callback")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 9ea39348cdf5..7c6d1c277d4d 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -248,7 +248,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		unsigned int channels = params_channels(hw_params);
 
 		mutex_lock(&oxfw->mutex);
-		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream,
+		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->rx_stream,
 						     rate, channels);
 		if (err >= 0)
 			++oxfw->substreams_count;
-- 
2.20.1
