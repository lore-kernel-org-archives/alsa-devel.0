From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/19] ALSA: fireworks: don't set XRUN in stop
	streaming
Date: Wed, 12 Jun 2019 17:44:13 +0900
Message-ID: <20190612084422.5344-11-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12936F8973B
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:44 +0200 (CEST)
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
 sound/firewire/fireworks/fireworks_stream.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 1abc15760513..61342c49dc38 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -43,7 +43,6 @@ init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 static void
 stop_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 {
-	amdtp_stream_pcm_abort(stream);
 	amdtp_stream_stop(stream);
 
 	if (stream == &efw->tx_stream)
-- 
2.20.1
