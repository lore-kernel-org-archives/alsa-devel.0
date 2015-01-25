From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/6] ALSA: seq: correctly report maximum number
	of ports
Date: Sun, 25 Jan 2015 14:34:57 +0100
Message-ID: <54C4F101.9010204@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CC7F7260437
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:34:59 +0100 (CET)
In-Reply-To: <54C4F0A1.2000907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Due to SNDRV_SEQ_ADDRESS_BROADCAST, not all 256 port number values can
be used.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/seq/seq_clientmgr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 225c7315..808918a 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1133,7 +1133,7 @@ static int snd_seq_ioctl_system_info(struct snd_seq_client *client, void __user
 	/* fill the info fields */
 	info.queues = SNDRV_SEQ_MAX_QUEUES;
 	info.clients = SNDRV_SEQ_MAX_CLIENTS;
-	info.ports = 256;	/* fixed limit */
+	info.ports = SNDRV_SEQ_MAX_PORTS;
 	info.channels = 256;	/* fixed limit */
 	info.cur_clients = client_usage.cur;
 	info.cur_queues = snd_seq_queue_get_cur_queues();
