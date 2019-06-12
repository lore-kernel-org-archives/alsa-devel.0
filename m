From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/19] ALSA: oxfw: code refactoring for stop
	condition of packet streaming
Date: Wed, 12 Jun 2019 17:44:14 +0900
Message-ID: <20190612084422.5344-12-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7518F89731
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:45 +0200 (CEST)
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

This commit unifies stop condition due to queueing error and unmatched
state of the target device.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index f230a9e44c3c..34ff673e6ff8 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -288,10 +288,6 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 	if (err < 0)
 		goto end;
 
-	/* packet queueing error */
-	if (amdtp_streaming_error(stream))
-		stop_stream(oxfw, stream);
-
 	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
 	if (err < 0)
 		goto end;
@@ -300,7 +296,8 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 	if (pcm_channels == 0)
 		pcm_channels = formation.pcm;
 
-	if ((formation.rate != rate) || (formation.pcm != pcm_channels)) {
+	if (formation.rate != rate || formation.pcm != pcm_channels ||
+	    amdtp_streaming_error(stream)) {
 		if (opposite != NULL) {
 			err = check_connection_used_by_others(oxfw, opposite);
 			if (err < 0)
-- 
2.20.1
