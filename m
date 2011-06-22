From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3.0-rc1 resend] ALSA: isight: add now required
 waking of DMA context
Date: Wed, 22 Jun 2011 08:59:50 +0200
Message-ID: <20110622085950.318eb630@stein>
References: <20110531110750.00a03563@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 144E524518
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 08:59:55 +0200 (CEST)
In-Reply-To: <20110531110750.00a03563@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Date: Tue, 31 May 2011 11:07:50 +0200

Since commit 13882a82ee16, upper-layer firewire drivers are required to
flush after queuing a batch of isochronous buffers.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 sound/firewire/isight.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/sound/firewire/isight.c
===================================================================
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -213,6 +213,7 @@ static void isight_packet(struct fw_iso_
 	if (++index >= QUEUE_LENGTH)
 		index = 0;
 	isight->packet_index = index;
+	fw_iso_context_queue_flush(isight->context);
 }
 
 static int isight_connect(struct isight *isight)


-- 
Stefan Richter
-=====-==-== -==- =-==-
http://arcgraph.de/sr/
