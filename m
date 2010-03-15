From: lieven moors <lievenmoors@gmail.com>
Subject: aconnect patch
Date: Mon, 15 Mar 2010 14:04:47 +0100
Message-ID: <4B9E306F.8070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id E5BE4103817
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 14:04:51 +0100 (CET)
Received: by ewy23 with SMTP id 23so547280ewy.4
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 06:04:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi everybody,

I'm a musician working intensively with Linux, and I like
writing programs.
Now I am working on a little command line utility to store
and restore all ALSA (midi) and JACK connections to/from an xml
file, and I've been using aconnect as an example for writing
the ALSA part.

I also needed a function to remove all connections, similar
to the remove_connections function in aconnect.
After using aconnect -x for some time, I noticed that it didn't
work as it should. Very often a number of connections were
left untouched after issuing this command.

After digging a little bit deeper, I think I found the reason for
the bug, and wrote a fix for it.

This is what I think happens in remove_connections:

Every time the for loop is executed, the index of the
snd_seq_query_subscribe_t is updated (+ 1).
If the connection has the right capabilities, it is removed.

When the connection is removed, I think the index gets
reassigned, and the next connection gets the position at index 0.
The result is that when one connection is removed, the
removal of the next connection is skipped (because the for
loop updates the index every time).

In the patch, I only update the index when unsubscribing fails,
or if it is unwanted because the capabilities or wrong.
This seems to solve the problems I had with aconnect -x,
and now it disconnects all connections as it should.

In the original function, connections are removed both ways.
First all ports with SND_SEQ_PORT_CAP_SUBS_READ are
checked, and associated connections removed, and then all
ports with SND_SEQ_PORT_CAP_SUBS_WRITE.

In the patch, I removed the second part, because I think it is
doing the same thing twice.

Please let me know what you think about this patch,
and if you think my reasoning is sane...

Greetings,

Lieven Moors



diff --git a/aconnect.c b/aconnect.c
index 1a50666..6092748 100644
--- a/aconnect.c
+++ b/aconnect.c
@@ -192,52 +192,33 @@ static void remove_connection(snd_seq_t *seq, 
snd_seq_client_info_t *cinfo,
                    snd_seq_port_info_t *pinfo, int count)
  {
      snd_seq_query_subscribe_t *query;
-
      snd_seq_query_subscribe_alloca(&query);
      snd_seq_query_subscribe_set_root(query, 
snd_seq_port_info_get_addr(pinfo));
-
      snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_READ);
      snd_seq_query_subscribe_set_index(query, 0);
-    for (; snd_seq_query_port_subscribers(seq, query) >= 0;
-         snd_seq_query_subscribe_set_index(query, 
snd_seq_query_subscribe_get_index(query) + 1)) {
+
+    while (snd_seq_query_port_subscribers(seq, query) >= 0)
+    {
          snd_seq_port_info_t *port;
          snd_seq_port_subscribe_t *subs;
          const snd_seq_addr_t *sender = 
snd_seq_query_subscribe_get_root(query);
          const snd_seq_addr_t *dest = 
snd_seq_query_subscribe_get_addr(query);
          snd_seq_port_info_alloca(&port);
-        if (snd_seq_get_any_port_info(seq, dest->client, dest->port, 
port) < 0)
-            continue;
-        if (!(snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_SUBS_WRITE))
-            continue;
-        if (snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_NO_EXPORT)
-            continue;
-        snd_seq_port_subscribe_alloca(&subs);
-        snd_seq_port_subscribe_set_queue(subs, 
snd_seq_query_subscribe_get_queue(query));
-        snd_seq_port_subscribe_set_sender(subs, sender);
-        snd_seq_port_subscribe_set_dest(subs, dest);
-        snd_seq_unsubscribe_port(seq, subs);
-    }

-    snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_WRITE);
-    snd_seq_query_subscribe_set_index(query, 0);
-    for (; snd_seq_query_port_subscribers(seq, query) >= 0;
-         snd_seq_query_subscribe_set_index(query, 
snd_seq_query_subscribe_get_index(query) + 1)) {
-        snd_seq_port_info_t *port;
-        snd_seq_port_subscribe_t *subs;
-        const snd_seq_addr_t *dest = 
snd_seq_query_subscribe_get_root(query);
-        const snd_seq_addr_t *sender = 
snd_seq_query_subscribe_get_addr(query);
-        snd_seq_port_info_alloca(&port);
-        if (snd_seq_get_any_port_info(seq, sender->client, 
sender->port, port) < 0)
-            continue;
-        if (!(snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_SUBS_READ))
-            continue;
-        if (snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_NO_EXPORT)
+        if ((snd_seq_get_any_port_info(seq, dest->client, dest->port, 
port) < 0) ||
+            !(snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_SUBS_WRITE) ||
+            (snd_seq_port_info_get_capability(port) & 
SND_SEQ_PORT_CAP_NO_EXPORT))
+        {
+            snd_seq_query_subscribe_set_index(query, 
snd_seq_query_subscribe_get_index(query) + 1);
              continue;
+        }
          snd_seq_port_subscribe_alloca(&subs);
          snd_seq_port_subscribe_set_queue(subs, 
snd_seq_query_subscribe_get_queue(query));
          snd_seq_port_subscribe_set_sender(subs, sender);
          snd_seq_port_subscribe_set_dest(subs, dest);
-        snd_seq_unsubscribe_port(seq, subs);
+        if(snd_seq_unsubscribe_port(seq, subs) < 0){
+            snd_seq_query_subscribe_set_index(query, 
snd_seq_query_subscribe_get_index(query) + 1);
+        }
      }
  }
