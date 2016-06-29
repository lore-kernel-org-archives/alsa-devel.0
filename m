From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ctl: support dimension test for
	user-defined element set
Date: Wed, 29 Jun 2016 22:43:03 +0900
Message-ID: <1467207783-19792-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 90309266D90
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 15:43:10 +0200 (CEST)
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

In former commits, APIs to add an element set are extended to support extra
fields to information structure. Currently, the fields are mainly used to
describe dimension level.

This commit adds tests to check the dimension level.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 51e850c..c346e03 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -17,6 +17,7 @@ struct elem_set_trial {
 	unsigned int element_count;
 
 	snd_ctl_elem_id_t *id;
+	int dimension[4];
 
 	int (*add_elem_set)(struct elem_set_trial *trial,
 			    snd_ctl_elem_info_t *info);
@@ -229,6 +230,7 @@ static int add_elem_set(struct elem_set_trial *trial)
 {
 	snd_ctl_elem_info_t *info;
 	char name[64] = {0};
+	int err;
 
 	snprintf(name, 64, "userspace-control-element-%s",
 		 snd_ctl_elem_type_name(trial->type));
@@ -236,8 +238,13 @@ static int add_elem_set(struct elem_set_trial *trial)
 	snd_ctl_elem_info_alloca(&info);
 	snd_ctl_elem_info_set_interface(info, SND_CTL_ELEM_IFACE_MIXER);
 	snd_ctl_elem_info_set_name(info, name);
+	snd_ctl_elem_info_set_dimension(info, trial->dimension);
+
+	err = trial->add_elem_set(trial, info);
+	if (err >= 0)
+		snd_ctl_elem_info_get_id(info, trial->id);
 
-	return trial->add_elem_set(trial, info);
+	return err;
 }
 
 static int check_event(struct elem_set_trial *trial, unsigned int mask,
@@ -301,6 +308,7 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 	unsigned int numid;
 	unsigned int index;
 	unsigned int i;
+	unsigned int j;
 	int err;
 
 	snd_ctl_elem_id_alloca(&id);
@@ -329,6 +337,11 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 			return -EIO;
 		if (snd_ctl_elem_info_get_count(info) != trial->member_count)
 			return -EIO;
+		for (j = 0; j < 4; ++j) {
+			if (snd_ctl_elem_info_get_dimension(info, j) !=
+							trial->dimension[j])
+				return -EIO;
+		}
 
 		/*
 		 * In a case of IPC, this is the others. But in this case,
@@ -464,6 +477,10 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_BOOLEAN:
 			trial.element_count = 900;
 			trial.member_count = 128;
+			trial.dimension[0] = 4;
+			trial.dimension[1] = 4;
+			trial.dimension[2] = 8;
+			trial.dimension[3] = 0;
 			trial.add_elem_set = add_bool_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bool_elem_members;
@@ -471,6 +488,10 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_INTEGER:
 			trial.element_count = 900;
 			trial.member_count = 128;
+			trial.dimension[0] = 128;
+			trial.dimension[1] = 0;
+			trial.dimension[2] = 0;
+			trial.dimension[3] = 0;
 			trial.add_elem_set = add_int_elem_set;
 			trial.check_elem_props = check_int_elem_props;
 			trial.change_elem_members = change_int_elem_members;
@@ -478,6 +499,10 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
 			trial.element_count = 900;
 			trial.member_count = 128;
+			trial.dimension[0] = 16;
+			trial.dimension[1] = 8;
+			trial.dimension[2] = 0;
+			trial.dimension[3] = 0;
 			trial.add_elem_set = add_enum_elem_set;
 			trial.check_elem_props = check_enum_elem_props;
 			trial.change_elem_members = change_enum_elem_members;
@@ -485,6 +510,10 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_BYTES:
 			trial.element_count = 900;
 			trial.member_count = 512;
+			trial.dimension[0] = 8;
+			trial.dimension[1] = 4;
+			trial.dimension[2] = 8;
+			trial.dimension[3] = 4;
 			trial.add_elem_set = add_bytes_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bytes_elem_members;
@@ -492,6 +521,10 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_IEC958:
 			trial.element_count = 1;
 			trial.member_count = 1;
+			trial.dimension[0] = 0;
+			trial.dimension[1] = 0;
+			trial.dimension[2] = 0;
+			trial.dimension[3] = 0;
 			trial.add_elem_set = add_iec958_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_iec958_elem_members;
@@ -500,6 +533,10 @@ int main(void)
 		default:
 			trial.element_count = 900;
 			trial.member_count = 64;
+			trial.dimension[0] = 0;
+			trial.dimension[1] = 0;
+			trial.dimension[2] = 0;
+			trial.dimension[3] = 0;
 			trial.add_elem_set = add_int64_elem_set;
 			trial.check_elem_props = check_int64_elem_props;
 			trial.change_elem_members = change_int64_elem_members;
-- 
2.7.4
