From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/12] ALSA: firewire-digi00x: simplify error
	path to begin streaming session
Date: Tue, 11 Jun 2019 22:21:09 +0900
Message-ID: <20190611132118.8378-4-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74951F80791
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:29 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
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

This commit is a part of preparation to perform allocation/release
of isochronous resources in pcm.hw_params/hw_free callbacks.

The caller of begin_session() calls finish_session() in its error path,
thus no need to call finish_session() in error path of begin_session().

This commit simplifies error path of begin_session().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 90e31b63ac2f..8104af94aed5 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -159,13 +159,13 @@ static int begin_session(struct snd_dg00x *dg00x)
 				 DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
 				 &data, sizeof(data), 0);
 	if (err < 0)
-		goto error;
+		return err;
 
 	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
 				 DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_STATE,
 				 &data, sizeof(data), 0);
 	if (err < 0)
-		goto error;
+		return err;
 	curr = be32_to_cpu(data);
 
 	if (curr == 0)
@@ -180,15 +180,12 @@ static int begin_session(struct snd_dg00x *dg00x)
 					 DG00X_OFFSET_STREAMING_SET,
 					 &data, sizeof(data), 0);
 		if (err < 0)
-			goto error;
+			break;
 
 		msleep(20);
 		curr--;
 	}
 
-	return 0;
-error:
-	finish_session(dg00x);
 	return err;
 }
 
-- 
2.20.1
