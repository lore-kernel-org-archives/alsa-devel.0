From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/7] ALSA: seq: Delete unnecessary checks in
 snd_seq_ioctl_subscribe_port()
Date: Tue, 24 Jan 2017 11:24:08 +0100
Message-ID: <eeeeb8a9-70a2-8d44-674c-9a5aa6de78b2@users.sourceforge.net>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jan 2017 09:06:38 +0100

Four checks were repeated by the snd_seq_ioctl_subscribe_port() function
despite of pointer determinations for the used variables at the beginning.

* Adjust jump targets according to the Linux coding style convention.

* Delete extra variable initialisations and the repeated checks
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/seq/seq_clientmgr.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index ba26d622cb71..b9518e7cb623 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1423,36 +1423,36 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
 {
 	struct snd_seq_port_subscribe *subs = arg;
 	int result = -EINVAL;
-	struct snd_seq_client *receiver = NULL, *sender = NULL;
-	struct snd_seq_client_port *sport = NULL, *dport = NULL;
+	struct snd_seq_client *receiver, *sender;
+	struct snd_seq_client_port *sport, *dport;
 
 	if ((receiver = snd_seq_client_use_ptr(subs->dest.client)) == NULL)
-		goto __end;
+		goto exit;
 	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
-		goto __end;
+		goto unlock_receiver;
 	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
-		goto __end;
+		goto unlock_sender;
 	if ((dport = snd_seq_port_use_ptr(receiver, subs->dest.port)) == NULL)
-		goto __end;
+		goto unlock_sport;
 
 	result = check_subscription_permission(client, sport, dport, subs);
 	if (result < 0)
-		goto __end;
+		goto unlock_dport;
 
 	/* connect them */
 	result = snd_seq_port_connect(client, sender, sport, receiver, dport, subs);
 	if (! result) /* broadcast announce */
 		snd_seq_client_notify_subscription(SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
 						   subs, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
-      __end:
-      	if (sport)
-		snd_seq_port_unlock(sport);
-	if (dport)
-		snd_seq_port_unlock(dport);
-	if (sender)
-		snd_seq_client_unlock(sender);
-	if (receiver)
-		snd_seq_client_unlock(receiver);
+unlock_dport:
+	snd_seq_port_unlock(dport);
+unlock_sport:
+	snd_seq_port_unlock(sport);
+unlock_sender:
+	snd_seq_client_unlock(sender);
+unlock_receiver:
+	snd_seq_client_unlock(receiver);
+exit:
 	return result;
 }
 
-- 
2.11.0
