From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/19] ALSA: bebob: obsolete useless member of
	private structure
Date: Wed, 12 Jun 2019 17:44:06 +0900
Message-ID: <20190612084422.5344-4-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B7B5F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:33 +0200 (CEST)
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

The private structure of this driver has 'connected' member but nowadays
it's useless. This commit removes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h        | 2 --
 sound/firewire/bebob/bebob_stream.c | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index c30ed44aced9..20ed2dbd8d61 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -93,8 +93,6 @@ struct snd_bebob {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
-	bool connected;
-
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index d6e7f13ef42d..c3cc31df49e0 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -422,9 +422,6 @@ static int make_both_connections(struct snd_bebob *bebob)
 {
 	int err = 0;
 
-	if (bebob->connected)
-		return 0;
-
 	err = cmp_connection_establish(&bebob->out_conn,
 			amdtp_stream_get_max_payload(&bebob->tx_stream));
 	if (err < 0)
@@ -437,8 +434,6 @@ static int make_both_connections(struct snd_bebob *bebob)
 		return err;
 	}
 
-	bebob->connected = true;
-
 	return 0;
 }
 
@@ -448,8 +443,6 @@ break_both_connections(struct snd_bebob *bebob)
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
 
-	bebob->connected = false;
-
 	/* These models seems to be in transition state for a longer time. */
 	if (bebob->maudio_special_quirk != NULL)
 		msleep(200);
-- 
2.20.1
