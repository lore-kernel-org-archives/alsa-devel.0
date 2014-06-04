From: Adam Goode <agoode@google.com>
Subject: [PATCH v2 1/1] ALSA: seq: Continue broadcasting events
	to ports if one of them fails
Date: Wed,  4 Jun 2014 11:20:55 -0400
Message-ID: <1401895255-25348-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B349B265071
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 17:21:06 +0200 (CEST)
Received: by mail-yh0-f43.google.com with SMTP id v1so6528344yhn.30
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 08:21:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sometimes PORT_EXIT messages are lost when a process is exiting.
This happens if you subscribe to the announce port with client A,
then subscribe to the announce port with client B, then kill client A.
Client B will not see the PORT_EXIT message because client A's port is
closing and is earlier in the announce port subscription list. The
for each loop will try to send the announcement to client A and fail,
then will stop trying to broadcast to other ports. Killing B works fine
since the announcement will already have gone to A. The CLIENT_EXIT
message does not get lost.

How to reproduce problem:

*** termA
$ aseqdump -p 0:1
  0:1   Port subscribed            0:1 -> 128:0

*** termB
$ aseqdump -p 0:1

*** termA
  0:1   Client start               client 129
  0:1   Port start                 129:0
  0:1   Port subscribed            0:1 -> 129:0

*** termB
  0:1   Port subscribed            0:1 -> 129:0

*** termA
^C

*** termB
  0:1   Client exit                client 128
   <--- expected Port exit as well (before client exit)

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9ca5e64..225c7315 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -660,7 +660,7 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 				  int atomic, int hop)
 {
 	struct snd_seq_subscribers *subs;
-	int err = 0, num_ev = 0;
+	int err, result = 0, num_ev = 0;
 	struct snd_seq_event event_saved;
 	struct snd_seq_client_port *src_port;
 	struct snd_seq_port_subs_info *grp;
@@ -685,8 +685,12 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 						  subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIME_REAL);
 		err = snd_seq_deliver_single_event(client, event,
 						   0, atomic, hop);
-		if (err < 0)
-			break;
+		if (err < 0) {
+			/* save first error that occurs and continue */
+			if (!result)
+				result = err;
+			continue;
+		}
 		num_ev++;
 		/* restore original event record */
 		*event = event_saved;
@@ -697,7 +701,7 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 		up_read(&grp->list_mutex);
 	*event = event_saved; /* restore */
 	snd_seq_port_unlock(src_port);
-	return (err < 0) ? err : num_ev;
+	return (result < 0) ? result : num_ev;
 }
 
 
@@ -709,7 +713,7 @@ static int port_broadcast_event(struct snd_seq_client *client,
 				struct snd_seq_event *event,
 				int atomic, int hop)
 {
-	int num_ev = 0, err = 0;
+	int num_ev = 0, err, result = 0;
 	struct snd_seq_client *dest_client;
 	struct snd_seq_client_port *port;
 
@@ -724,14 +728,18 @@ static int port_broadcast_event(struct snd_seq_client *client,
 		err = snd_seq_deliver_single_event(NULL, event,
 						   SNDRV_SEQ_FILTER_BROADCAST,
 						   atomic, hop);
-		if (err < 0)
-			break;
+		if (err < 0) {
+			/* save first error that occurs and continue */
+			if (!result)
+				result = err;
+			continue;
+		}
 		num_ev++;
 	}
 	read_unlock(&dest_client->ports_lock);
 	snd_seq_client_unlock(dest_client);
 	event->dest.port = SNDRV_SEQ_ADDRESS_BROADCAST; /* restore */
-	return (err < 0) ? err : num_ev;
+	return (result < 0) ? result : num_ev;
 }
 
 /*
@@ -741,7 +749,7 @@ static int port_broadcast_event(struct snd_seq_client *client,
 static int broadcast_event(struct snd_seq_client *client,
 			   struct snd_seq_event *event, int atomic, int hop)
 {
-	int err = 0, num_ev = 0;
+	int err, result = 0, num_ev = 0;
 	int dest;
 	struct snd_seq_addr addr;
 
@@ -760,12 +768,16 @@ static int broadcast_event(struct snd_seq_client *client,
 			err = snd_seq_deliver_single_event(NULL, event,
 							   SNDRV_SEQ_FILTER_BROADCAST,
 							   atomic, hop);
-		if (err < 0)
-			break;
+		if (err < 0) {
+			/* save first error that occurs and continue */
+			if (!result)
+				result = err;
+			continue;
+		}
 		num_ev += err;
 	}
 	event->dest = addr; /* restore */
-	return (err < 0) ? err : num_ev;
+	return (result < 0) ? result : num_ev;
 }
 
 
-- 
2.0.0.526.g5318336
