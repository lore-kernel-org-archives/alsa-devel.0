From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v4 3/4] ALSA: seq: change ioctl command
	operation to get data in kernel space
Date: Sat, 13 Aug 2016 10:13:35 +0900
Message-ID: <1471050816-26416-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1471050816-26416-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 78520265FED
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 03:13:44 +0200 (CEST)
In-Reply-To: <1471050816-26416-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In previous commit, a new table for functions with data in kernel space
is added to replace current table.

This commit changes existent functions to fit the table. These functions
are added to the new table and removed from the old table.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 606 +++++++++++++++++------------------------
 1 file changed, 248 insertions(+), 358 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index cf37003..e07a539 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1128,59 +1128,69 @@ static unsigned int snd_seq_poll(struct file *file, poll_table * wait)
 
 /*-----------------------------------------------------*/
 
+static int snd_seq_ioctl_pversion(struct snd_seq_client *client, void *arg)
+{
+	int *pversion = arg;
+
+	*pversion = SNDRV_SEQ_VERSION;
+	return 0;
+}
+
+static int snd_seq_ioctl_client_id(struct snd_seq_client *client, void *arg)
+{
+	int *client_id = arg;
+
+	*client_id = client->number;
+	return 0;
+}
 
 /* SYSTEM_INFO ioctl() */
-static int snd_seq_ioctl_system_info(struct snd_seq_client *client, void __user *arg)
+static int snd_seq_ioctl_system_info(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_system_info info;
+	struct snd_seq_system_info *info = arg;
 
-	memset(&info, 0, sizeof(info));
+	memset(info, 0, sizeof(*info));
 	/* fill the info fields */
-	info.queues = SNDRV_SEQ_MAX_QUEUES;
-	info.clients = SNDRV_SEQ_MAX_CLIENTS;
-	info.ports = SNDRV_SEQ_MAX_PORTS;
-	info.channels = 256;	/* fixed limit */
-	info.cur_clients = client_usage.cur;
-	info.cur_queues = snd_seq_queue_get_cur_queues();
-
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
+	info->queues = SNDRV_SEQ_MAX_QUEUES;
+	info->clients = SNDRV_SEQ_MAX_CLIENTS;
+	info->ports = SNDRV_SEQ_MAX_PORTS;
+	info->channels = 256;	/* fixed limit */
+	info->cur_clients = client_usage.cur;
+	info->cur_queues = snd_seq_queue_get_cur_queues();
+
 	return 0;
 }
 
 
 /* RUNNING_MODE ioctl() */
-static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void __user *arg)
+static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void  *arg)
 {
-	struct snd_seq_running_info info;
+	struct snd_seq_running_info *info = arg;
 	struct snd_seq_client *cptr;
 	int err = 0;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(info.client);
+	cptr = snd_seq_client_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
 #ifdef SNDRV_BIG_ENDIAN
-	if (! info.big_endian) {
+	if (!info->big_endian) {
 		err = -EINVAL;
 		goto __err;
 	}
 #else
-	if (info.big_endian) {
+	if (info->big_endian) {
 		err = -EINVAL;
 		goto __err;
 	}
 
 #endif
-	if (info.cpu_mode > sizeof(long)) {
+	if (info->cpu_mode > sizeof(long)) {
 		err = -EINVAL;
 		goto __err;
 	}
-	cptr->convert32 = (info.cpu_mode < sizeof(long));
+	cptr->convert32 = (info->cpu_mode < sizeof(long));
  __err:
 	snd_seq_client_unlock(cptr);
 	return err;
@@ -1214,51 +1224,43 @@ static void get_client_info(struct snd_seq_client *cptr,
 }
 
 static int snd_seq_ioctl_get_client_info(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_client_info *client_info = arg;
 	struct snd_seq_client *cptr;
-	struct snd_seq_client_info client_info;
-
-	if (copy_from_user(&client_info, arg, sizeof(client_info)))
-		return -EFAULT;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(client_info.client);
+	cptr = snd_seq_client_use_ptr(client_info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
-	get_client_info(cptr, &client_info);
+	get_client_info(cptr, client_info);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &client_info, sizeof(client_info)))
-		return -EFAULT;
 	return 0;
 }
 
 
 /* CLIENT_INFO ioctl() */
 static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_client_info client_info;
-
-	if (copy_from_user(&client_info, arg, sizeof(client_info)))
-		return -EFAULT;
+	struct snd_seq_client_info *client_info = arg;
 
 	/* it is not allowed to set the info fields for an another client */
-	if (client->number != client_info.client)
+	if (client->number != client_info->client)
 		return -EPERM;
 	/* also client type must be set now */
-	if (client->type != client_info.type)
+	if (client->type != client_info->type)
 		return -EINVAL;
 
 	/* fill the info fields */
-	if (client_info.name[0])
-		strlcpy(client->name, client_info.name, sizeof(client->name));
+	if (client_info->name[0])
+		strlcpy(client->name, client_info->name, sizeof(client->name));
 
-	client->filter = client_info.filter;
-	client->event_lost = client_info.event_lost;
-	memcpy(client->event_filter, client_info.event_filter, 32);
+	client->filter = client_info->filter;
+	client->event_lost = client_info->event_lost;
+	memcpy(client->event_filter, client_info->event_filter, 32);
 
 	return 0;
 }
@@ -1267,30 +1269,26 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 /* 
  * CREATE PORT ioctl() 
  */
-static int snd_seq_ioctl_create_port(struct snd_seq_client *client,
-				     void __user *arg)
+static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
 	struct snd_seq_port_callback *callback;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
 	/* it is not allowed to create the port for an another client */
-	if (info.addr.client != client->number)
+	if (info->addr.client != client->number)
 		return -EPERM;
 
-	port = snd_seq_create_port(client, (info.flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT) ? info.addr.port : -1);
+	port = snd_seq_create_port(client, (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT) ? info->addr.port : -1);
 	if (port == NULL)
 		return -ENOMEM;
 
-	if (client->type == USER_CLIENT && info.kernel) {
+	if (client->type == USER_CLIENT && info->kernel) {
 		snd_seq_delete_port(client, port->addr.port);
 		return -EINVAL;
 	}
 	if (client->type == KERNEL_CLIENT) {
-		if ((callback = info.kernel) != NULL) {
+		if ((callback = info->kernel) != NULL) {
 			if (callback->owner)
 				port->owner = callback->owner;
 			port->private_data = callback->private_data;
@@ -1303,37 +1301,29 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client,
 		}
 	}
 
-	info.addr = port->addr;
+	info->addr = port->addr;
 
-	snd_seq_set_port_info(port, &info);
+	snd_seq_set_port_info(port, info);
 	snd_seq_system_client_ev_port_start(port->addr.client, port->addr.port);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
 /* 
  * DELETE PORT ioctl() 
  */
-static int snd_seq_ioctl_delete_port(struct snd_seq_client *client,
-				     void __user *arg)
+static int snd_seq_ioctl_delete_port(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_port_info info;
+	struct snd_seq_port_info *info = arg;
 	int err;
 
-	/* set passed parameters */
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	
 	/* it is not allowed to remove the port for an another client */
-	if (info.addr.client != client->number)
+	if (info->addr.client != client->number)
 		return -EPERM;
 
-	err = snd_seq_delete_port(client, info.addr.port);
+	err = snd_seq_delete_port(client, info->addr.port);
 	if (err >= 0)
-		snd_seq_system_client_ev_port_exit(client->number, info.addr.port);
+		snd_seq_system_client_ev_port_exit(client->number, info->addr.port);
 	return err;
 }
 
@@ -1341,32 +1331,27 @@ static int snd_seq_ioctl_delete_port(struct snd_seq_client *client,
 /* 
  * GET_PORT_INFO ioctl() (on any client) 
  */
-static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client,
-				       void __user *arg)
+static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	cptr = snd_seq_client_use_ptr(info.addr.client);
+	cptr = snd_seq_client_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
-	port = snd_seq_port_use_ptr(cptr, info.addr.port);
+	port = snd_seq_port_use_ptr(cptr, info->addr.port);
 	if (port == NULL) {
 		snd_seq_client_unlock(cptr);
 		return -ENOENT;			/* don't change */
 	}
 
 	/* get port info */
-	snd_seq_get_port_info(port, &info);
+	snd_seq_get_port_info(port, info);
 	snd_seq_port_unlock(port);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1374,20 +1359,16 @@ static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client,
 /* 
  * SET_PORT_INFO ioctl() (only ports on this/own client) 
  */
-static int snd_seq_ioctl_set_port_info(struct snd_seq_client *client,
-				       void __user *arg)
+static int snd_seq_ioctl_set_port_info(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client_port *port;
-	struct snd_seq_port_info info;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	if (info.addr.client != client->number) /* only set our own ports ! */
+	if (info->addr.client != client->number) /* only set our own ports ! */
 		return -EPERM;
-	port = snd_seq_port_use_ptr(client, info.addr.port);
+	port = snd_seq_port_use_ptr(client, info->addr.port);
 	if (port) {
-		snd_seq_set_port_info(port, &info);
+		snd_seq_set_port_info(port, info);
 		snd_seq_port_unlock(port);
 	}
 	return 0;
@@ -1453,34 +1434,31 @@ int snd_seq_client_notify_subscription(int client, int port,
  * add to port's subscription list IOCTL interface 
  */
 static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result = -EINVAL;
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
-	struct snd_seq_port_subscribe subs;
-
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
 
-	if ((receiver = snd_seq_client_use_ptr(subs.dest.client)) == NULL)
+	if ((receiver = snd_seq_client_use_ptr(subs->dest.client)) == NULL)
 		goto __end;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
 		goto __end;
-	if ((sport = snd_seq_port_use_ptr(sender, subs.sender.port)) == NULL)
+	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
 		goto __end;
-	if ((dport = snd_seq_port_use_ptr(receiver, subs.dest.port)) == NULL)
+	if ((dport = snd_seq_port_use_ptr(receiver, subs->dest.port)) == NULL)
 		goto __end;
 
-	result = check_subscription_permission(client, sport, dport, &subs);
+	result = check_subscription_permission(client, sport, dport, subs);
 	if (result < 0)
 		goto __end;
 
 	/* connect them */
-	result = snd_seq_port_connect(client, sender, sport, receiver, dport, &subs);
+	result = snd_seq_port_connect(client, sender, sport, receiver, dport, subs);
 	if (! result) /* broadcast announce */
 		snd_seq_client_notify_subscription(SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
-						   &subs, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
+						   subs, SNDRV_SEQ_EVENT_PORT_SUBSCRIBED);
       __end:
       	if (sport)
 		snd_seq_port_unlock(sport);
@@ -1498,33 +1476,30 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
  * remove from port's subscription list 
  */
 static int snd_seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result = -ENXIO;
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
-	struct snd_seq_port_subscribe subs;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
-	if ((receiver = snd_seq_client_use_ptr(subs.dest.client)) == NULL)
+	if ((receiver = snd_seq_client_use_ptr(subs->dest.client)) == NULL)
 		goto __end;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
 		goto __end;
-	if ((sport = snd_seq_port_use_ptr(sender, subs.sender.port)) == NULL)
+	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
 		goto __end;
-	if ((dport = snd_seq_port_use_ptr(receiver, subs.dest.port)) == NULL)
+	if ((dport = snd_seq_port_use_ptr(receiver, subs->dest.port)) == NULL)
 		goto __end;
 
-	result = check_subscription_permission(client, sport, dport, &subs);
+	result = check_subscription_permission(client, sport, dport, subs);
 	if (result < 0)
 		goto __end;
 
-	result = snd_seq_port_disconnect(client, sender, sport, receiver, dport, &subs);
+	result = snd_seq_port_disconnect(client, sender, sport, receiver, dport, subs);
 	if (! result) /* broadcast announce */
 		snd_seq_client_notify_subscription(SNDRV_SEQ_ADDRESS_SUBSCRIBERS, 0,
-						   &subs, SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
+						   subs, SNDRV_SEQ_EVENT_PORT_UNSUBSCRIBED);
       __end:
       	if (sport)
 		snd_seq_port_unlock(sport);
@@ -1539,17 +1514,13 @@ static int snd_seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
 
 
 /* CREATE_QUEUE ioctl() */
-static int snd_seq_ioctl_create_queue(struct snd_seq_client *client,
-				      void __user *arg)
+static int snd_seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	int result;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	result = snd_seq_queue_alloc(client->number, info.locked, info.flags);
+	result = snd_seq_queue_alloc(client->number, info->locked, info->flags);
 	if (result < 0)
 		return result;
 
@@ -1557,181 +1528,150 @@ static int snd_seq_ioctl_create_queue(struct snd_seq_client *client,
 	if (q == NULL)
 		return -EINVAL;
 
-	info.queue = q->queue;
-	info.locked = q->locked;
-	info.owner = q->owner;
+	info->queue = q->queue;
+	info->locked = q->locked;
+	info->owner = q->owner;
 
 	/* set queue name */
-	if (! info.name[0])
-		snprintf(info.name, sizeof(info.name), "Queue-%d", q->queue);
-	strlcpy(q->name, info.name, sizeof(q->name));
+	if (!info->name[0])
+		snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
+	strlcpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
 /* DELETE_QUEUE ioctl() */
-static int snd_seq_ioctl_delete_queue(struct snd_seq_client *client,
-				      void __user *arg)
+static int snd_seq_ioctl_delete_queue(struct snd_seq_client *client, void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	return snd_seq_queue_delete(client->number, info.queue);
+	return snd_seq_queue_delete(client->number, info->queue);
 }
 
 /* GET_QUEUE_INFO ioctl() */
 static int snd_seq_ioctl_get_queue_info(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	q = queueptr(info.queue);
+	q = queueptr(info->queue);
 	if (q == NULL)
 		return -EINVAL;
 
-	memset(&info, 0, sizeof(info));
-	info.queue = q->queue;
-	info.owner = q->owner;
-	info.locked = q->locked;
-	strlcpy(info.name, q->name, sizeof(info.name));
+	memset(info, 0, sizeof(*info));
+	info->queue = q->queue;
+	info->owner = q->owner;
+	info->locked = q->locked;
+	strlcpy(info->name, q->name, sizeof(info->name));
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
 /* SET_QUEUE_INFO ioctl() */
 static int snd_seq_ioctl_set_queue_info(struct snd_seq_client *client,
-					void __user *arg)
+					void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	if (info.owner != client->number)
+	if (info->owner != client->number)
 		return -EINVAL;
 
 	/* change owner/locked permission */
-	if (snd_seq_queue_check_access(info.queue, client->number)) {
-		if (snd_seq_queue_set_owner(info.queue, client->number, info.locked) < 0)
+	if (snd_seq_queue_check_access(info->queue, client->number)) {
+		if (snd_seq_queue_set_owner(info->queue, client->number, info->locked) < 0)
 			return -EPERM;
-		if (info.locked)
-			snd_seq_queue_use(info.queue, client->number, 1);
+		if (info->locked)
+			snd_seq_queue_use(info->queue, client->number, 1);
 	} else {
 		return -EPERM;
 	}	
 
-	q = queueptr(info.queue);
+	q = queueptr(info->queue);
 	if (! q)
 		return -EINVAL;
 	if (q->owner != client->number) {
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strlcpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;
 }
 
 /* GET_NAMED_QUEUE ioctl() */
-static int snd_seq_ioctl_get_named_queue(struct snd_seq_client *client, void __user *arg)
+static int snd_seq_ioctl_get_named_queue(struct snd_seq_client *client,
+					 void *arg)
 {
-	struct snd_seq_queue_info info;
+	struct snd_seq_queue_info *info = arg;
 	struct snd_seq_queue *q;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	q = snd_seq_queue_find_name(info.name);
+	q = snd_seq_queue_find_name(info->name);
 	if (q == NULL)
 		return -EINVAL;
-	info.queue = q->queue;
-	info.owner = q->owner;
-	info.locked = q->locked;
+	info->queue = q->queue;
+	info->owner = q->owner;
+	info->locked = q->locked;
 	queuefree(q);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
 	return 0;
 }
 
 /* GET_QUEUE_STATUS ioctl() */
 static int snd_seq_ioctl_get_queue_status(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
-	struct snd_seq_queue_status status;
+	struct snd_seq_queue_status *status = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&status, arg, sizeof(status)))
-		return -EFAULT;
-
-	queue = queueptr(status.queue);
+	queue = queueptr(status->queue);
 	if (queue == NULL)
 		return -EINVAL;
-	memset(&status, 0, sizeof(status));
-	status.queue = queue->queue;
+	memset(status, 0, sizeof(*status));
+	status->queue = queue->queue;
 	
 	tmr = queue->timer;
-	status.events = queue->tickq->cells + queue->timeq->cells;
+	status->events = queue->tickq->cells + queue->timeq->cells;
 
-	status.time = snd_seq_timer_get_cur_time(tmr);
-	status.tick = snd_seq_timer_get_cur_tick(tmr);
+	status->time = snd_seq_timer_get_cur_time(tmr);
+	status->tick = snd_seq_timer_get_cur_tick(tmr);
 
-	status.running = tmr->running;
+	status->running = tmr->running;
 
-	status.flags = queue->flags;
+	status->flags = queue->flags;
 	queuefree(queue);
 
-	if (copy_to_user(arg, &status, sizeof(status)))
-		return -EFAULT;
 	return 0;
 }
 
 
 /* GET_QUEUE_TEMPO ioctl() */
 static int snd_seq_ioctl_get_queue_tempo(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_queue_tempo tempo;
+	struct snd_seq_queue_tempo *tempo = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&tempo, arg, sizeof(tempo)))
-		return -EFAULT;
-
-	queue = queueptr(tempo.queue);
+	queue = queueptr(tempo->queue);
 	if (queue == NULL)
 		return -EINVAL;
-	memset(&tempo, 0, sizeof(tempo));
-	tempo.queue = queue->queue;
+	memset(tempo, 0, sizeof(*tempo));
+	tempo->queue = queue->queue;
 	
 	tmr = queue->timer;
 
-	tempo.tempo = tmr->tempo;
-	tempo.ppq = tmr->ppq;
-	tempo.skew_value = tmr->skew;
-	tempo.skew_base = tmr->skew_base;
+	tempo->tempo = tmr->tempo;
+	tempo->ppq = tmr->ppq;
+	tempo->skew_value = tmr->skew;
+	tempo->skew_base = tmr->skew_base;
 	queuefree(queue);
 
-	if (copy_to_user(arg, &tempo, sizeof(tempo)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1747,31 +1687,25 @@ int snd_seq_set_queue_tempo(int client, struct snd_seq_queue_tempo *tempo)
 EXPORT_SYMBOL(snd_seq_set_queue_tempo);
 
 static int snd_seq_ioctl_set_queue_tempo(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_queue_tempo *tempo = arg;
 	int result;
-	struct snd_seq_queue_tempo tempo;
-
-	if (copy_from_user(&tempo, arg, sizeof(tempo)))
-		return -EFAULT;
 
-	result = snd_seq_set_queue_tempo(client->number, &tempo);
+	result = snd_seq_set_queue_tempo(client->number, tempo);
 	return result < 0 ? result : 0;
 }
 
 
 /* GET_QUEUE_TIMER ioctl() */
 static int snd_seq_ioctl_get_queue_timer(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_queue_timer timer;
+	struct snd_seq_queue_timer *timer = arg;
 	struct snd_seq_queue *queue;
 	struct snd_seq_timer *tmr;
 
-	if (copy_from_user(&timer, arg, sizeof(timer)))
-		return -EFAULT;
-
-	queue = queueptr(timer.queue);
+	queue = queueptr(timer->queue);
 	if (queue == NULL)
 		return -EINVAL;
 
@@ -1780,41 +1714,36 @@ static int snd_seq_ioctl_get_queue_timer(struct snd_seq_client *client,
 		return -ERESTARTSYS;
 	}
 	tmr = queue->timer;
-	memset(&timer, 0, sizeof(timer));
-	timer.queue = queue->queue;
+	memset(timer, 0, sizeof(*timer));
+	timer->queue = queue->queue;
 
-	timer.type = tmr->type;
+	timer->type = tmr->type;
 	if (tmr->type == SNDRV_SEQ_TIMER_ALSA) {
-		timer.u.alsa.id = tmr->alsa_id;
-		timer.u.alsa.resolution = tmr->preferred_resolution;
+		timer->u.alsa.id = tmr->alsa_id;
+		timer->u.alsa.resolution = tmr->preferred_resolution;
 	}
 	mutex_unlock(&queue->timer_mutex);
 	queuefree(queue);
 	
-	if (copy_to_user(arg, &timer, sizeof(timer)))
-		return -EFAULT;
 	return 0;
 }
 
 
 /* SET_QUEUE_TIMER ioctl() */
 static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_queue_timer *timer = arg;
 	int result = 0;
-	struct snd_seq_queue_timer timer;
 
-	if (copy_from_user(&timer, arg, sizeof(timer)))
-		return -EFAULT;
-
-	if (timer.type != SNDRV_SEQ_TIMER_ALSA)
+	if (timer->type != SNDRV_SEQ_TIMER_ALSA)
 		return -EINVAL;
 
-	if (snd_seq_queue_check_access(timer.queue, client->number)) {
+	if (snd_seq_queue_check_access(timer->queue, client->number)) {
 		struct snd_seq_queue *q;
 		struct snd_seq_timer *tmr;
 
-		q = queueptr(timer.queue);
+		q = queueptr(timer->queue);
 		if (q == NULL)
 			return -ENXIO;
 		if (mutex_lock_interruptible(&q->timer_mutex)) {
@@ -1822,13 +1751,13 @@ static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
 			return -ERESTARTSYS;
 		}
 		tmr = q->timer;
-		snd_seq_queue_timer_close(timer.queue);
-		tmr->type = timer.type;
+		snd_seq_queue_timer_close(timer->queue);
+		tmr->type = timer->type;
 		if (tmr->type == SNDRV_SEQ_TIMER_ALSA) {
-			tmr->alsa_id = timer.u.alsa.id;
-			tmr->preferred_resolution = timer.u.alsa.resolution;
+			tmr->alsa_id = timer->u.alsa.id;
+			tmr->preferred_resolution = timer->u.alsa.resolution;
 		}
-		result = snd_seq_queue_timer_open(timer.queue);
+		result = snd_seq_queue_timer_open(timer->queue);
 		mutex_unlock(&q->timer_mutex);
 		queuefree(q);
 	} else {
@@ -1841,38 +1770,30 @@ static int snd_seq_ioctl_set_queue_timer(struct snd_seq_client *client,
 
 /* GET_QUEUE_CLIENT ioctl() */
 static int snd_seq_ioctl_get_queue_client(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
-	struct snd_seq_queue_client info;
+	struct snd_seq_queue_client *info = arg;
 	int used;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	used = snd_seq_queue_is_used(info.queue, client->number);
+	used = snd_seq_queue_is_used(info->queue, client->number);
 	if (used < 0)
 		return -EINVAL;
-	info.used = used;
-	info.client = client->number;
+	info->used = used;
+	info->client = client->number;
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
 
 /* SET_QUEUE_CLIENT ioctl() */
 static int snd_seq_ioctl_set_queue_client(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
+	struct snd_seq_queue_client *info = arg;
 	int err;
-	struct snd_seq_queue_client info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
 
-	if (info.used >= 0) {
-		err = snd_seq_queue_use(info.queue, client->number, info.used);
+	if (info->used >= 0) {
+		err = snd_seq_queue_use(info->queue, client->number, info->used);
 		if (err < 0)
 			return err;
 	}
@@ -1883,78 +1804,70 @@ static int snd_seq_ioctl_set_queue_client(struct snd_seq_client *client,
 
 /* GET_CLIENT_POOL ioctl() */
 static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_client_pool info;
+	struct snd_seq_client_pool *info = arg;
 	struct snd_seq_client *cptr;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	cptr = snd_seq_client_use_ptr(info.client);
+	cptr = snd_seq_client_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;
-	memset(&info, 0, sizeof(info));
-	info.client = cptr->number;
-	info.output_pool = cptr->pool->size;
-	info.output_room = cptr->pool->room;
-	info.output_free = info.output_pool;
-	info.output_free = snd_seq_unused_cells(cptr->pool);
+	memset(info, 0, sizeof(*info));
+	info->client = cptr->number;
+	info->output_pool = cptr->pool->size;
+	info->output_room = cptr->pool->room;
+	info->output_free = info->output_pool;
+	info->output_free = snd_seq_unused_cells(cptr->pool);
 	if (cptr->type == USER_CLIENT) {
-		info.input_pool = cptr->data.user.fifo_pool_size;
-		info.input_free = info.input_pool;
+		info->input_pool = cptr->data.user.fifo_pool_size;
+		info->input_free = info->input_pool;
 		if (cptr->data.user.fifo)
-			info.input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
+			info->input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
 	} else {
-		info.input_pool = 0;
-		info.input_free = 0;
+		info->input_pool = 0;
+		info->input_free = 0;
 	}
 	snd_seq_client_unlock(cptr);
 	
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
 /* SET_CLIENT_POOL ioctl() */
 static int snd_seq_ioctl_set_client_pool(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
-	struct snd_seq_client_pool info;
+	struct snd_seq_client_pool *info = arg;
 	int rc;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-
-	if (client->number != info.client)
+	if (client->number != info->client)
 		return -EINVAL; /* can't change other clients */
 
-	if (info.output_pool >= 1 && info.output_pool <= SNDRV_SEQ_MAX_EVENTS &&
+	if (info->output_pool >= 1 && info->output_pool <= SNDRV_SEQ_MAX_EVENTS &&
 	    (! snd_seq_write_pool_allocated(client) ||
-	     info.output_pool != client->pool->size)) {
+	     info->output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
 			/* remove all existing cells */
 			snd_seq_queue_client_leave_cells(client->number);
 			snd_seq_pool_done(client->pool);
 		}
-		client->pool->size = info.output_pool;
+		client->pool->size = info->output_pool;
 		rc = snd_seq_pool_init(client->pool);
 		if (rc < 0)
 			return rc;
 	}
 	if (client->type == USER_CLIENT && client->data.user.fifo != NULL &&
-	    info.input_pool >= 1 &&
-	    info.input_pool <= SNDRV_SEQ_MAX_CLIENT_EVENTS &&
-	    info.input_pool != client->data.user.fifo_pool_size) {
+	    info->input_pool >= 1 &&
+	    info->input_pool <= SNDRV_SEQ_MAX_CLIENT_EVENTS &&
+	    info->input_pool != client->data.user.fifo_pool_size) {
 		/* change pool size */
-		rc = snd_seq_fifo_resize(client->data.user.fifo, info.input_pool);
+		rc = snd_seq_fifo_resize(client->data.user.fifo, info->input_pool);
 		if (rc < 0)
 			return rc;
-		client->data.user.fifo_pool_size = info.input_pool;
+		client->data.user.fifo_pool_size = info->input_pool;
 	}
-	if (info.output_room >= 1 &&
-	    info.output_room <= client->pool->size) {
-		client->pool->room  = info.output_room;
+	if (info->output_room >= 1 &&
+	    info->output_room <= client->pool->size) {
+		client->pool->room  = info->output_room;
 	}
 
 	return snd_seq_ioctl_get_client_pool(client, arg);
@@ -1963,17 +1876,14 @@ static int snd_seq_ioctl_set_client_pool(struct snd_seq_client *client,
 
 /* REMOVE_EVENTS ioctl() */
 static int snd_seq_ioctl_remove_events(struct snd_seq_client *client,
-				       void __user *arg)
+				       void *arg)
 {
-	struct snd_seq_remove_events info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
+	struct snd_seq_remove_events *info = arg;
 
 	/*
 	 * Input mostly not implemented XXX.
 	 */
-	if (info.remove_mode & SNDRV_SEQ_REMOVE_INPUT) {
+	if (info->remove_mode & SNDRV_SEQ_REMOVE_INPUT) {
 		/*
 		 * No restrictions so for a user client we can clear
 		 * the whole fifo
@@ -1982,8 +1892,8 @@ static int snd_seq_ioctl_remove_events(struct snd_seq_client *client,
 			snd_seq_fifo_clear(client->data.user.fifo);
 	}
 
-	if (info.remove_mode & SNDRV_SEQ_REMOVE_OUTPUT)
-		snd_seq_queue_remove_cells(client->number, &info);
+	if (info->remove_mode & SNDRV_SEQ_REMOVE_OUTPUT)
+		snd_seq_queue_remove_cells(client->number, info);
 
 	return 0;
 }
@@ -1993,26 +1903,23 @@ static int snd_seq_ioctl_remove_events(struct snd_seq_client *client,
  * get subscription info
  */
 static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
-					  void __user *arg)
+					  void *arg)
 {
+	struct snd_seq_port_subscribe *subs = arg;
 	int result;
 	struct snd_seq_client *sender = NULL;
 	struct snd_seq_client_port *sport = NULL;
-	struct snd_seq_port_subscribe subs;
 	struct snd_seq_subscribers *p;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
 	result = -EINVAL;
-	if ((sender = snd_seq_client_use_ptr(subs.sender.client)) == NULL)
+	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
 		goto __end;
-	if ((sport = snd_seq_port_use_ptr(sender, subs.sender.port)) == NULL)
+	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
 		goto __end;
-	p = snd_seq_port_get_subscription(&sport->c_src, &subs.dest);
+	p = snd_seq_port_get_subscription(&sport->c_src, &subs->dest);
 	if (p) {
 		result = 0;
-		subs = p->info;
+		*subs = p->info;
 	} else
 		result = -ENOENT;
 
@@ -2021,10 +1928,7 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 		snd_seq_port_unlock(sport);
 	if (sender)
 		snd_seq_client_unlock(sender);
-	if (result >= 0) {
-		if (copy_to_user(arg, &subs, sizeof(subs)))
-			return -EFAULT;
-	}
+
 	return result;
 }
 
@@ -2032,26 +1936,22 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 /*
  * get subscription info - check only its presence
  */
-static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
-				    void __user *arg)
+static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 {
+	struct snd_seq_query_subs *subs = arg;
 	int result = -ENXIO;
 	struct snd_seq_client *cptr = NULL;
 	struct snd_seq_client_port *port = NULL;
-	struct snd_seq_query_subs subs;
 	struct snd_seq_port_subs_info *group;
 	struct list_head *p;
 	int i;
 
-	if (copy_from_user(&subs, arg, sizeof(subs)))
-		return -EFAULT;
-
-	if ((cptr = snd_seq_client_use_ptr(subs.root.client)) == NULL)
+	if ((cptr = snd_seq_client_use_ptr(subs->root.client)) == NULL)
 		goto __end;
-	if ((port = snd_seq_port_use_ptr(cptr, subs.root.port)) == NULL)
+	if ((port = snd_seq_port_use_ptr(cptr, subs->root.port)) == NULL)
 		goto __end;
 
-	switch (subs.type) {
+	switch (subs->type) {
 	case SNDRV_SEQ_QUERY_SUBS_READ:
 		group = &port->c_src;
 		break;
@@ -2064,22 +1964,22 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
 
 	down_read(&group->list_mutex);
 	/* search for the subscriber */
-	subs.num_subs = group->count;
+	subs->num_subs = group->count;
 	i = 0;
 	result = -ENOENT;
 	list_for_each(p, &group->list_head) {
-		if (i++ == subs.index) {
+		if (i++ == subs->index) {
 			/* found! */
 			struct snd_seq_subscribers *s;
-			if (subs.type == SNDRV_SEQ_QUERY_SUBS_READ) {
+			if (subs->type == SNDRV_SEQ_QUERY_SUBS_READ) {
 				s = list_entry(p, struct snd_seq_subscribers, src_list);
-				subs.addr = s->info.dest;
+				subs->addr = s->info.dest;
 			} else {
 				s = list_entry(p, struct snd_seq_subscribers, dest_list);
-				subs.addr = s->info.sender;
+				subs->addr = s->info.sender;
 			}
-			subs.flags = s->info.flags;
-			subs.queue = s->info.queue;
+			subs->flags = s->info.flags;
+			subs->queue = s->info.queue;
 			result = 0;
 			break;
 		}
@@ -2091,10 +1991,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
 		snd_seq_port_unlock(port);
 	if (cptr)
 		snd_seq_client_unlock(cptr);
-	if (result >= 0) {
-		if (copy_to_user(arg, &subs, sizeof(subs)))
-			return -EFAULT;
-	}
+
 	return result;
 }
 
@@ -2103,31 +2000,26 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client,
  * query next client
  */
 static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
-					   void __user *arg)
+					   void *arg)
 {
+	struct snd_seq_client_info *info = arg;
 	struct snd_seq_client *cptr = NULL;
-	struct snd_seq_client_info info;
-
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
 
 	/* search for next client */
-	info.client++;
-	if (info.client < 0)
-		info.client = 0;
-	for (; info.client < SNDRV_SEQ_MAX_CLIENTS; info.client++) {
-		cptr = snd_seq_client_use_ptr(info.client);
+	info->client++;
+	if (info->client < 0)
+		info->client = 0;
+	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
+		cptr = snd_seq_client_use_ptr(info->client);
 		if (cptr)
 			break; /* found */
 	}
 	if (cptr == NULL)
 		return -ENOENT;
 
-	get_client_info(cptr, &info);
+	get_client_info(cptr, info);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -2135,34 +2027,30 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
  * query next port
  */
 static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
-					 void __user *arg)
+					 void *arg)
 {
+	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port = NULL;
-	struct snd_seq_port_info info;
 
-	if (copy_from_user(&info, arg, sizeof(info)))
-		return -EFAULT;
-	cptr = snd_seq_client_use_ptr(info.addr.client);
+	cptr = snd_seq_client_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
 	/* search for next port */
-	info.addr.port++;
-	port = snd_seq_port_query_nearest(cptr, &info);
+	info->addr.port++;
+	port = snd_seq_port_query_nearest(cptr, info);
 	if (port == NULL) {
 		snd_seq_client_unlock(cptr);
 		return -ENOENT;
 	}
 
 	/* get port info */
-	info.addr = port->addr;
-	snd_seq_get_port_info(port, &info);
+	info->addr = port->addr;
+	snd_seq_get_port_info(port, info);
 	snd_seq_port_unlock(port);
 	snd_seq_client_unlock(cptr);
 
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -2172,13 +2060,8 @@ static const struct ioctl_handler {
 	unsigned int cmd;
 	int (*func)(struct snd_seq_client *client, void *arg);
 } ioctl_handlers[] = {
-	{ 0, NULL },
-};
-
-static struct seq_ioctl_table {
-	unsigned int cmd;
-	int (*func)(struct snd_seq_client *client, void __user * arg);
-} ioctl_tables[] = {
+	{ SNDRV_SEQ_IOCTL_PVERSION, snd_seq_ioctl_pversion },
+	{ SNDRV_SEQ_IOCTL_CLIENT_ID, snd_seq_ioctl_client_id },
 	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, snd_seq_ioctl_system_info },
 	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, snd_seq_ioctl_running_mode },
 	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, snd_seq_ioctl_get_client_info },
@@ -2211,6 +2094,13 @@ static struct seq_ioctl_table {
 	{ 0, NULL },
 };
 
+static struct seq_ioctl_table {
+	unsigned int cmd;
+	int (*func)(struct snd_seq_client *client, void __user * arg);
+} ioctl_tables[] = {
+	{ 0, NULL },
+};
+
 static long seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
-- 
2.7.4
