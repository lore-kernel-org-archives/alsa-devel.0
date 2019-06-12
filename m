From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/19] ALSA: bebob: don't set XRUN in stop
	streaming
Date: Wed, 12 Jun 2019 17:44:05 +0900
Message-ID: <20190612084422.5344-3-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AADEF896E0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:31 +0200 (CEST)
In-Reply-To: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
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

When stopping packet streaming, no need to stop PCM substream with XRUN
state. This commit suppresses it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index fcc93156d0b7..d6e7f13ef42d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -687,10 +687,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob)
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 {
 	if (bebob->substreams_counter == 0) {
-		amdtp_stream_pcm_abort(&bebob->rx_stream);
 		amdtp_stream_stop(&bebob->rx_stream);
-
-		amdtp_stream_pcm_abort(&bebob->tx_stream);
 		amdtp_stream_stop(&bebob->tx_stream);
 
 		break_both_connections(bebob);
-- 
2.20.1
