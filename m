From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 1/5] namehint: Fix invalid list access in
	snd_device_name_hint()
Date: Thu, 30 Apr 2015 15:06:14 +0200
Message-ID: <1430399178-15173-2-git-send-email-tiwai@suse.de>
References: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED35A261566
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 386FCAC1B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
In-Reply-To: <1430399178-15173-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_device_name_hint() tries to free the allocated list at the error
path via snd_device_name_free_hint().  But snd_device_name_free_hint()
expects a list terminated by NULL while snd_device_name_hint() doesn't
add it.  Adding it may again result in an error and thus isn't
guaranteed to work.  Hence we can't add NULL at the error path.

Instead, now the code always allocates one entry more, and zero-clears
the newly allocated beforehand to guarantee the NULL termination.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/control/namehint.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 28975a400b75..66de634d3550 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -52,10 +52,11 @@ static int hint_list_add(struct hint_list *list,
 {
 	char *x;
 
-	if (list->count == list->allocated) {
+	if (list->count + 1 >= list->allocated) {
 		char **n = realloc(list->list, (list->allocated + 10) * sizeof(char *));
 		if (n == NULL)
 			return -ENOMEM;
+		memset(n + list->allocated, 0, 10 * sizeof(*n));
 		list->allocated += 10;
 		list->list = n;
 	}
@@ -620,18 +621,16 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 	}
 	err = 0;
       __error:
-      	if (err < 0) {
+	/* add an empty entry if nothing has been added yet; the caller
+	 * expects non-NULL return
+	 */
+	if (!err && !list.list)
+		err = hint_list_add(&list, NULL, NULL);
+	if (err < 0)
       		snd_device_name_free_hint((void **)list.list);
-      		if (list.cardname)
-	      		free(list.cardname);
-      	} else {
-      		err = hint_list_add(&list, NULL, NULL);
-      		if (err < 0)
-      			goto __error;
+	else
       		*hints = (void **)list.list;
-      		if (list.cardname)
-	      		free(list.cardname);
-	}
+	free(list.cardname);
 	if (local_config_rw)
 		snd_config_delete(local_config_rw);
 	if (local_config)
-- 
2.3.6
