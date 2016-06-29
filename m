From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ctl: optimize a test for user-defined
	element set to changes of APIs
Date: Wed, 29 Jun 2016 22:43:02 +0900
Message-ID: <1467207783-19792-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 2150C266D8D
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 15:43:08 +0200 (CEST)
In-Reply-To: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commits, APIs to add an element set are changed, while a test
program for user-defined element set doesn't follow them.

This commit add support the change.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 54 +++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index bfb11d7..51e850c 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -18,7 +18,8 @@ struct elem_set_trial {
 
 	snd_ctl_elem_id_t *id;
 
-	int (*add_elem_set)(struct elem_set_trial *trial);
+	int (*add_elem_set)(struct elem_set_trial *trial,
+			    snd_ctl_elem_info_t *info);
 	int (*check_elem_props)(struct elem_set_trial *trial,
 				snd_ctl_elem_info_t *info);
 	void (*change_elem_members)(struct elem_set_trial *trial,
@@ -26,9 +27,10 @@ struct elem_set_trial {
 };
 
 /* Operations for elements in an element set with boolean type. */
-static int add_bool_elem_set(struct elem_set_trial *trial)
+static int add_bool_elem_set(struct elem_set_trial *trial,
+			     snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_boolean_set(trial->handle, trial->id,
+	return snd_ctl_elem_add_boolean_set(trial->handle, info,
 				trial->element_count, trial->member_count);
 }
 
@@ -45,9 +47,10 @@ static void change_bool_elem_members(struct elem_set_trial *trial,
 }
 
 /* Operations for elements in an element set with integer type. */
-static int add_int_elem_set(struct elem_set_trial *trial)
+static int add_int_elem_set(struct elem_set_trial *trial,
+			    snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_integer_set(trial->handle, trial->id,
+	return snd_ctl_elem_add_integer_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				0, 99, 1);
 }
@@ -86,9 +89,10 @@ static const char *const labels[] = {
 	"xenial",
 };
 
-static int add_enum_elem_set(struct elem_set_trial *trial)
+static int add_enum_elem_set(struct elem_set_trial *trial,
+			     snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_enumerated_set(trial->handle, trial->id,
+	return snd_ctl_elem_add_enumerated_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				sizeof(labels) / sizeof(labels[0]),
 				labels);
@@ -134,9 +138,10 @@ static void change_enum_elem_members(struct elem_set_trial *trial,
 }
 
 /* Operations for elements in an element set with bytes type. */
-static int add_bytes_elem_set(struct elem_set_trial *trial)
+static int add_bytes_elem_set(struct elem_set_trial *trial,
+			      snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_bytes_set(trial->handle, trial->id,
+	return snd_ctl_elem_add_bytes_set(trial->handle, info,
 				trial->element_count, trial->member_count);
 }
 
@@ -153,9 +158,22 @@ static void change_bytes_elem_members(struct elem_set_trial *trial,
 }
 
 /* Operations for elements in an element set with iec958 type. */
-static int add_iec958_elem_set(struct elem_set_trial *trial)
+static int add_iec958_elem_set(struct elem_set_trial *trial,
+			       snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_iec958(trial->handle, trial->id);
+	int err;
+
+	snd_ctl_elem_info_get_id(info, trial->id);
+
+	err = snd_ctl_elem_add_iec958(trial->handle, trial->id);
+	if (err < 0)
+	        return err;
+
+	/*
+	 * In historical reason, the above API is not allowed to fill all of
+	 * fields in identification data.
+	 */
+	return snd_ctl_elem_info(trial->handle, info);
 }
 
 static void change_iec958_elem_members(struct elem_set_trial *trial,
@@ -173,9 +191,10 @@ static void change_iec958_elem_members(struct elem_set_trial *trial,
 }
 
 /* Operations for elements in an element set with integer64 type. */
-static int add_int64_elem_set(struct elem_set_trial *trial)
+static int add_int64_elem_set(struct elem_set_trial *trial,
+			      snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_integer64_set(trial->handle, trial->id,
+	return snd_ctl_elem_add_integer64_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				100, 10000, 30);
 }
@@ -208,16 +227,17 @@ static void change_int64_elem_members(struct elem_set_trial *trial,
 /* Common operations. */
 static int add_elem_set(struct elem_set_trial *trial)
 {
+	snd_ctl_elem_info_t *info;
 	char name[64] = {0};
 
 	snprintf(name, 64, "userspace-control-element-%s",
 		 snd_ctl_elem_type_name(trial->type));
 
-	memset(trial->id, 0, snd_ctl_elem_id_sizeof());
-	snd_ctl_elem_id_set_interface(trial->id, SND_CTL_ELEM_IFACE_MIXER);
-	snd_ctl_elem_id_set_name(trial->id, name);
+	snd_ctl_elem_info_alloca(&info);
+	snd_ctl_elem_info_set_interface(info, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_info_set_name(info, name);
 
-	return trial->add_elem_set(trial);
+	return trial->add_elem_set(trial, info);
 }
 
 static int check_event(struct elem_set_trial *trial, unsigned int mask,
-- 
2.7.4
