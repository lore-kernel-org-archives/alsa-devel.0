From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/7] ALSA: seq: Delete unnecessary checks in
 snd_seq_ioctl_get_subscription()
Date: Tue, 24 Jan 2017 11:22:11 +0100
Message-ID: <0f4cc184-1a9a-70ec-fba5-4c2224805e34@users.sourceforge.net>
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
Date: Tue, 24 Jan 2017 08:54:36 +0100

Two checks were repeated by the snd_seq_ioctl_get_subscription() function
despite of pointer determinations for the used variables at the beginning.

* Adjust jump targets according to the Linux coding style convention.

* Convert an assignment for the variable "result" to a direct initialisation.

* Delete extra variable initialisations and the repeated checks
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/seq/seq_clientmgr.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 594c341a193e..8e804ff784ed 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1891,16 +1891,15 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 					  void *arg)
 {
 	struct snd_seq_port_subscribe *subs = arg;
-	int result;
-	struct snd_seq_client *sender = NULL;
-	struct snd_seq_client_port *sport = NULL;
+	int result = -EINVAL;
+	struct snd_seq_client *sender;
+	struct snd_seq_client_port *sport;
 	struct snd_seq_subscribers *p;
 
-	result = -EINVAL;
 	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
-		goto __end;
+		goto exit;
 	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
-		goto __end;
+		goto unlock_client;
 	p = snd_seq_port_get_subscription(&sport->c_src, &subs->dest);
 	if (p) {
 		result = 0;
@@ -1908,12 +1907,10 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	} else
 		result = -ENOENT;
 
-      __end:
-      	if (sport)
-		snd_seq_port_unlock(sport);
-	if (sender)
-		snd_seq_client_unlock(sender);
-
+	snd_seq_port_unlock(sport);
+unlock_client:
+	snd_seq_client_unlock(sender);
+exit:
 	return result;
 }
 
-- 
2.11.0
