From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix KERNEL_QUOTE event handling
Date: Mon, 23 Feb 2004 10:04:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231001140.20713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Timestamping (if enabled on a subscription or a port) is not applied
to the quoted event but to the quoting event.  This patch adds a
function to copy only selected fields into the event to be delivered.


- fix KERNEL_QUOTE event timestamping
- fix typo in port_broadcast_event

Index: alsa-kernel/core/seq/seq_clientmgr.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_clientmgr.c,v
retrieving revision 1.27
diff -u -r1.27 seq_clientmgr.c
--- alsa-kernel/core/seq/seq_clientmgr.c	5 Feb 2004 15:38:42 -0000	1.27
+++ alsa-kernel/core/seq/seq_clientmgr.c	23 Feb 2004 08:27:41 -0000
@@ -547,6 +547,36 @@


 /*
+ * expand a quoted event.
+ */
+static int expand_quoted_event(snd_seq_event_t *event)
+{
+	snd_seq_event_t *quoted;
+
+	quoted = event->data.quote.event;
+	if (quoted == NULL) {
+		snd_printd("seq: quoted event is NULL\n");
+		return -EINVAL;
+	}
+
+	event->type = quoted->type;
+	event->tag = quoted->tag;
+	event->source = quoted->source;
+	/* don't use quoted destination */
+	event->data = quoted->data;
+	/* use quoted timestamp only if subscription/port didn't update it */
+	if (event->queue == SNDRV_SEQ_QUEUE_DIRECT) {
+		event->flags = quoted->flags;
+		event->queue = quoted->queue;
+		event->time = quoted->time;
+	} else {
+		event->flags = (event->flags & SNDRV_SEQ_TIME_STAMP_MASK)
+			| (quoted->flags & ~SNDRV_SEQ_TIME_STAMP_MASK);
+	}
+	return 0;
+}
+
+/*
  * deliver an event to the specified destination.
  * if filter is non-zero, client filter bitmap is tested.
  *
@@ -581,12 +611,9 @@
 		update_timestamp_of_queue(event, dest_port->time_queue,
 					  dest_port->time_real);

-	/* expand the quoted event */
 	if (event->type == SNDRV_SEQ_EVENT_KERNEL_QUOTE) {
 		quoted = 1;
-		event = event->data.quote.event;
-		if (event == NULL) {
-			snd_printd("seq: quoted event is NULL\n");
+		if (expand_quoted_event(event) < 0) {
 			result = 0; /* do not send bounce error */
 			goto __skip;
 		}
@@ -694,8 +721,8 @@
 	if (dest_client == NULL)
 		return 0; /* no matching destination */

-	read_lock(&client->ports_lock);
-	list_for_each(p, &client->ports_list_head) {
+	read_lock(&dest_client->ports_lock);
+	list_for_each(p, &dest_client->ports_list_head) {
 		client_port_t *port = list_entry(p, client_port_t, list);
 		event->dest.port = port->addr.port;
 		/* pass NULL as source client to avoid error bounce */
@@ -706,7 +733,7 @@
 			break;
 		num_ev++;
 	}
-	read_unlock(&client->ports_lock);
+	read_unlock(&dest_client->ports_lock);
 	snd_seq_client_unlock(dest_client);
 	event->dest.port = SNDRV_SEQ_ADDRESS_BROADCAST; /* restore */
 	return (err < 0) ? err : num_ev;




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
