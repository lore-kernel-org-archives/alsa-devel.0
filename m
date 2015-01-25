From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 5/6] ALSA: seq: remove unused callback_all field
Date: Sun, 25 Jan 2015 14:36:27 +0100
Message-ID: <54C4F15B.8080508@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BEF9F26049B
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:36:28 +0100 (CET)
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

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/seq_kernel.h     |    1 -
 sound/core/seq/seq_clientmgr.c |    1 -
 sound/core/seq/seq_ports.c     |    7 ++-----
 sound/core/seq/seq_ports.h     |    1 -
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index ab8ddd9..f1c8e94 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -64,7 +64,6 @@ struct snd_seq_port_callback {
 	int (*unuse)(void *private_data, struct snd_seq_port_subscribe *info);
 	int (*event_input)(struct snd_seq_event *ev, int direct, void *private_data, int atomic, int hop);
 	void (*private_free)(void *private_data);
-	unsigned int callback_all;	/* call subscribe callbacks at each connection/disconnection */
 	/*...*/
 };

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 808918a..29182f5 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1279,7 +1279,6 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client,
 				port->owner = callback->owner;
 			port->private_data = callback->private_data;
 			port->private_free = callback->private_free;
-			port->callback_all = callback->callback_all;
 			port->event_input = callback->event_input;
 			port->c_src.open = callback->subscribe;
 			port->c_src.close = callback->unsubscribe;
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 52b279b..46ff593 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -411,9 +411,6 @@ int snd_seq_get_port_info(struct snd_seq_client_port * port,
  * invoked.
  * This feature is useful if these callbacks are associated with
  * initialization or termination of devices (see seq_midi.c).
- *
- * If callback_all option is set, the callback function is invoked
- * at each connection/disconnection.
  */

 static int subscribe_port(struct snd_seq_client *client,
@@ -427,7 +424,7 @@ static int subscribe_port(struct snd_seq_client *client,
 	if (!try_module_get(port->owner))
 		return -EFAULT;
 	grp->count++;
-	if (grp->open && (port->callback_all || grp->count == 1)) {
+	if (grp->open && grp->count == 1) {
 		err = grp->open(port->private_data, info);
 		if (err < 0) {
 			module_put(port->owner);
@@ -452,7 +449,7 @@ static int unsubscribe_port(struct snd_seq_client *client,
 	if (! grp->count)
 		return -EINVAL;
 	grp->count--;
-	if (grp->close && (port->callback_all || grp->count == 0))
+	if (grp->close && grp->count == 0)
 		err = grp->close(port->private_data, info);
 	if (send_ack && client->type == USER_CLIENT)
 		snd_seq_client_notify_subscription(port->addr.client, port->addr.port,
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index 9d71171..26bd71f 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -73,7 +73,6 @@ struct snd_seq_client_port {
 			   int atomic, int hop);
 	void (*private_free)(void *private_data);
 	void *private_data;
-	unsigned int callback_all : 1;
 	unsigned int closing : 1;
 	unsigned int timestamping: 1;
 	unsigned int time_real: 1;
