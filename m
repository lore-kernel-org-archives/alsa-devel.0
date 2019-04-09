From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: seq: Fix race of get-subscription
	call vs port-delete ioctls
Date: Tue,  9 Apr 2019 19:00:20 +0200
Message-ID: <20190409170020.20685-6-tiwai@suse.de>
References: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F052F896F6
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:27 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9C6DFB10B
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
In-Reply-To: <20190409170020.20685-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The snd_seq_ioctl_get_subscription() retrieves the port subscriber
information as a pointer, while the object isn't protected, hence it
may be deleted before the actual reference.  This race was spotted by
syzkaller and may lead to a UAF.

The fix is simply copying the data in the lookup function that
performs in the rwsem to protect against the deletion.

Reported-by: syzbot+9437020c82413d00222d@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 10 ++--------
 sound/core/seq/seq_ports.c     | 13 ++++++++-----
 sound/core/seq/seq_ports.h     |  5 +++--
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 976404691261..f256704dc401 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1897,20 +1897,14 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	int result;
 	struct snd_seq_client *sender = NULL;
 	struct snd_seq_client_port *sport = NULL;
-	struct snd_seq_subscribers *p;
 
 	result = -EINVAL;
 	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
 		goto __end;
 	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
 		goto __end;
-	p = snd_seq_port_get_subscription(&sport->c_src, &subs->dest);
-	if (p) {
-		result = 0;
-		*subs = p->info;
-	} else
-		result = -ENOENT;
-
+	result = snd_seq_port_get_subscription(&sport->c_src, &subs->dest,
+					       subs);
       __end:
       	if (sport)
 		snd_seq_port_unlock(sport);
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 1e2239240f21..d964d728681e 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -632,20 +632,23 @@ int snd_seq_port_disconnect(struct snd_seq_client *connector,
 
 
 /* get matched subscriber */
-struct snd_seq_subscribers *snd_seq_port_get_subscription(struct snd_seq_port_subs_info *src_grp,
-							  struct snd_seq_addr *dest_addr)
+int snd_seq_port_get_subscription(struct snd_seq_port_subs_info *src_grp,
+				  struct snd_seq_addr *dest_addr,
+				  struct snd_seq_port_subscribe *subs)
 {
-	struct snd_seq_subscribers *s, *found = NULL;
+	struct snd_seq_subscribers *s;
+	int err = -ENOENT;
 
 	down_read(&src_grp->list_mutex);
 	list_for_each_entry(s, &src_grp->list_head, src_list) {
 		if (addr_match(dest_addr, &s->info.dest)) {
-			found = s;
+			*subs = s->info;
+			err = 0;
 			break;
 		}
 	}
 	up_read(&src_grp->list_mutex);
-	return found;
+	return err;
 }
 
 /*
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index 26bd71f36c41..06003b36652e 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -135,7 +135,8 @@ int snd_seq_port_subscribe(struct snd_seq_client_port *port,
 			   struct snd_seq_port_subscribe *info);
 
 /* get matched subscriber */
-struct snd_seq_subscribers *snd_seq_port_get_subscription(struct snd_seq_port_subs_info *src_grp,
-							  struct snd_seq_addr *dest_addr);
+int snd_seq_port_get_subscription(struct snd_seq_port_subs_info *src_grp,
+				  struct snd_seq_addr *dest_addr,
+				  struct snd_seq_port_subscribe *subs);
 
 #endif
-- 
2.16.4
