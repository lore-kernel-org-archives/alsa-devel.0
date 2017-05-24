From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] test: add a test for list operation
	to user-defined element sets
Date: Wed, 24 May 2017 23:34:14 +0900
Message-ID: <20170524143414.15888-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 6BF2226680F
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 16:34:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Current implementation of test for user-defined element doesn't perform
list operation. This commit adds easy test for the operation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 75083d21..8635c156 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -433,6 +433,78 @@ static int check_event(struct elem_set_trial *trial, unsigned int mask,
 	return 0;
 }
 
+static int check_elem_list(struct elem_set_trial *trial)
+{
+	snd_ctl_elem_list_t *list;
+	snd_ctl_elem_id_t *id;
+	int e;
+	unsigned int i;
+	int err;
+
+	snd_ctl_elem_list_alloca(&list);
+	snd_ctl_elem_id_alloca(&id);
+
+	err = snd_ctl_elem_list(trial->handle, list);
+	if (err < 0)
+		return err;
+
+	/* Certainly some elements are already added. */
+	if (snd_ctl_elem_list_get_count(list) == 0)
+		return -EIO;
+
+	err = snd_ctl_elem_list_alloc_space(list,
+					    snd_ctl_elem_list_get_count(list));
+	if (err < 0)
+		return err;
+
+	err = snd_ctl_elem_list(trial->handle, list);
+	if (err < 0)
+		goto end;
+
+	if (trial->element_count > snd_ctl_elem_list_get_count(list)) {
+		err = -EIO;
+		goto end;
+	}
+
+	i = 0;
+	for (e = 0; e < snd_ctl_elem_list_get_count(list); ++e) {
+		snd_ctl_elem_list_get_id(list, e, id);
+
+		if (strcmp(snd_ctl_elem_id_get_name(id),
+			   snd_ctl_elem_id_get_name(trial->id)) != 0)
+			continue;
+		if (snd_ctl_elem_id_get_interface(id) !=
+		    snd_ctl_elem_id_get_interface(trial->id))
+			continue;
+		if (snd_ctl_elem_id_get_device(id) !=
+		    snd_ctl_elem_id_get_device(trial->id))
+			continue;
+		if (snd_ctl_elem_id_get_subdevice(id) !=
+		    snd_ctl_elem_id_get_subdevice(trial->id))
+			continue;
+
+		/*
+		 * Here, I expect the list includes element ID data in numerical
+		 * order. Actually, it does.
+		 */
+		if (snd_ctl_elem_id_get_numid(id) !=
+		    snd_ctl_elem_id_get_numid(trial->id) + i)
+			continue;
+		if (snd_ctl_elem_id_get_index(id) !=
+		    snd_ctl_elem_id_get_index(trial->id) + i)
+			continue;
+
+		++i;
+	}
+
+	if (i != trial->element_count)
+		err = -EIO;
+end:
+	snd_ctl_elem_list_free_space(list);
+
+	return err;
+}
+
 static int check_elem_set_props(struct elem_set_trial *trial)
 {
 	snd_ctl_elem_id_t *id;
@@ -701,6 +773,14 @@ int main(void)
 			break;
 		}
 
+		/* Check added elements are retrieved in a list. */
+		err = check_elem_list(&trial);
+		if (err < 0) {
+			printf("Fail to list each element with %s type.\n",
+			       snd_ctl_elem_type_name(trial.type));
+			break;
+		}
+
 		/* Check properties of each element in this element set. */
 		err = check_elem_set_props(&trial);
 		if (err < 0) {
-- 
2.11.0
