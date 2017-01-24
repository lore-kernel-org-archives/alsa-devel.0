From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/7] ALSA: seq: Delete unnecessary checks in
 snd_seq_ioctl_query_subs()
Date: Tue, 24 Jan 2017 11:21:13 +0100
Message-ID: <39bc00c0-ffe7-851c-f329-e7d499f561be@users.sourceforge.net>
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
Date: Tue, 24 Jan 2017 08:00:34 +0100

Two checks were repeated by the snd_seq_ioctl_query_subs() function
despite of pointer determinations for the used variables at the beginning.

* Adjust jump targets according to the Linux coding style convention.

* Delete extra variable initialisations and the repeated checks
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/seq/seq_clientmgr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 4c935202ce23..594c341a193e 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1925,16 +1925,16 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 {
 	struct snd_seq_query_subs *subs = arg;
 	int result = -ENXIO;
-	struct snd_seq_client *cptr = NULL;
-	struct snd_seq_client_port *port = NULL;
+	struct snd_seq_client *cptr;
+	struct snd_seq_client_port *port;
 	struct snd_seq_port_subs_info *group;
 	struct list_head *p;
 	int i;
 
 	if ((cptr = snd_seq_client_use_ptr(subs->root.client)) == NULL)
-		goto __end;
+		goto exit;
 	if ((port = snd_seq_port_use_ptr(cptr, subs->root.port)) == NULL)
-		goto __end;
+		goto unlock_client;
 
 	switch (subs->type) {
 	case SNDRV_SEQ_QUERY_SUBS_READ:
@@ -1944,7 +1944,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 		group = &port->c_dest;
 		break;
 	default:
-		goto __end;
+		goto unlock_port;
 	}
 
 	down_read(&group->list_mutex);
@@ -1970,13 +1970,11 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 		}
 	}
 	up_read(&group->list_mutex);
-
-      __end:
-   	if (port)
-		snd_seq_port_unlock(port);
-	if (cptr)
-		snd_seq_client_unlock(cptr);
-
+unlock_port:
+	snd_seq_port_unlock(port);
+unlock_client:
+	snd_seq_client_unlock(cptr);
+exit:
 	return result;
 }
 
-- 
2.11.0
