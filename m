From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH v2 2/2] test: obsolete usage of APIs
	of dimensional information
Date: Mon, 13 Nov 2017 09:14:11 +0900
Message-ID: <20171113001411.7430-3-o-takashi@sakamocchi.jp>
References: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 16FE0266A73
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 01:14:19 +0100 (CET)
In-Reply-To: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

APIs of dimensional information are deprecated for future removal. This
commit removes test codes for user-defined element set in an aspect of
the feature.
---
 test/user-ctl-element-set.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index f3710732..668831a8 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -19,7 +19,6 @@ struct elem_set_trial {
 	unsigned int element_count;
 
 	snd_ctl_elem_id_t *id;
-	int dimension[4];
 
 	int (*add_elem_set)(struct elem_set_trial *trial,
 			    snd_ctl_elem_info_t *info);
@@ -373,7 +372,6 @@ static int add_elem_set(struct elem_set_trial *trial)
 	snd_ctl_elem_info_alloca(&info);
 	snd_ctl_elem_info_set_interface(info, SND_CTL_ELEM_IFACE_MIXER);
 	snd_ctl_elem_info_set_name(info, name);
-	snd_ctl_elem_info_set_dimension(info, trial->dimension);
 
 	err = trial->add_elem_set(trial, info);
 	if (err >= 0)
@@ -544,11 +542,6 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 			return -EIO;
 		if (snd_ctl_elem_info_get_count(info) != trial->member_count)
 			return -EIO;
-		for (j = 0; j < 4; ++j) {
-			if (snd_ctl_elem_info_get_dimension(info, j) !=
-							trial->dimension[j])
-				return -EIO;
-		}
 
 		/*
 		 * In a case of IPC, this is the others. But in this case,
@@ -745,10 +738,6 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_BOOLEAN:
 			trial.element_count = 900;
 			trial.member_count = 128;
-			trial.dimension[0] = 4;
-			trial.dimension[1] = 4;
-			trial.dimension[2] = 8;
-			trial.dimension[3] = 0;
 			trial.add_elem_set = add_bool_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bool_elem_members;
@@ -759,10 +748,6 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_INTEGER:
 			trial.element_count = 900;
 			trial.member_count = 128;
-			trial.dimension[0] = 128;
-			trial.dimension[1] = 0;
-			trial.dimension[2] = 0;
-			trial.dimension[3] = 0;
 			trial.add_elem_set = add_int_elem_set;
 			trial.check_elem_props = check_int_elem_props;
 			trial.change_elem_members = change_int_elem_members;
@@ -773,10 +758,6 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
 			trial.element_count = 900;
 			trial.member_count = 128;
-			trial.dimension[0] = 16;
-			trial.dimension[1] = 8;
-			trial.dimension[2] = 0;
-			trial.dimension[3] = 0;
 			trial.add_elem_set = add_enum_elem_set;
 			trial.check_elem_props = check_enum_elem_props;
 			trial.change_elem_members = change_enum_elem_members;
@@ -786,10 +767,6 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_BYTES:
 			trial.element_count = 900;
 			trial.member_count = 512;
-			trial.dimension[0] = 8;
-			trial.dimension[1] = 4;
-			trial.dimension[2] = 8;
-			trial.dimension[3] = 2;
 			trial.add_elem_set = add_bytes_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bytes_elem_members;
@@ -800,10 +777,6 @@ int main(void)
 		case SND_CTL_ELEM_TYPE_IEC958:
 			trial.element_count = 1;
 			trial.member_count = 1;
-			trial.dimension[0] = 0;
-			trial.dimension[1] = 0;
-			trial.dimension[2] = 0;
-			trial.dimension[3] = 0;
 			trial.add_elem_set = add_iec958_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_iec958_elem_members;
@@ -814,10 +787,6 @@ int main(void)
 		default:
 			trial.element_count = 900;
 			trial.member_count = 64;
-			trial.dimension[0] = 0;
-			trial.dimension[1] = 0;
-			trial.dimension[2] = 0;
-			trial.dimension[3] = 0;
 			trial.add_elem_set = add_int64_elem_set;
 			trial.check_elem_props = check_int64_elem_props;
 			trial.change_elem_members = change_int64_elem_members;
-- 
2.14.1
