From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ctl: optimize a test for user-defined
	element set to older kernels
Date: Wed, 29 Jun 2016 22:43:01 +0900
Message-ID: <1467207783-19792-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23DA9266D8F
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

In Linux 4.0 or former, call of ioctl(2) with SNDRV_CTL_IOCTL_ELEM_ADD
doesn't fill all of identical information in an argument; i.e. numid.
With the kernel, a test of user-defined element set fails.

This commit fixes the bug. The 'numid' field in identical information
is always zero when adding an element set, therefore zero check has an
effect.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 09c7929..bfb11d7 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -279,6 +279,7 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 	snd_ctl_elem_id_t *id;
 	snd_ctl_elem_info_t *info;
 	unsigned int numid;
+	unsigned int index;
 	unsigned int i;
 	int err;
 
@@ -286,10 +287,18 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 	snd_ctl_elem_info_alloca(&info);
 
 	snd_ctl_elem_info_set_id(info, trial->id);
-	numid = snd_ctl_elem_info_get_numid(info);
+	numid = snd_ctl_elem_id_get_numid(trial->id);
+	index = snd_ctl_elem_id_get_index(trial->id);
 
 	for (i = 0; i < trial->element_count; ++i) {
-		snd_ctl_elem_info_set_numid(info, numid + i);
+		snd_ctl_elem_info_set_index(info, index + i);
+
+		/*
+		 * In Linux 4.0 or former, ioctl(SNDRV_CTL_IOCTL_ELEM_ADD)
+		 * doesn't fill all of fields for identification.
+		 */
+		if (numid > 0)
+			snd_ctl_elem_info_set_numid(info, numid + i);
 
 		err = snd_ctl_elem_info(trial->handle, info);
 		if (err < 0)
@@ -335,25 +344,25 @@ static int check_elems(struct elem_set_trial *trial)
 {
 	snd_ctl_elem_value_t *data;
 	unsigned int numid;
+	unsigned int index;
 	unsigned int i;
 	int err;
 
 	snd_ctl_elem_value_alloca(&data);
 
 	snd_ctl_elem_value_set_id(data, trial->id);
-
-	/*
-	 * Get the value of numid field in identical information for the first
-	 * element of this element set.
-	 */
-	numid = snd_ctl_elem_value_get_numid(data);
+	numid = snd_ctl_elem_id_get_numid(trial->id);
+	index = snd_ctl_elem_id_get_index(trial->id);
 
 	for (i = 0; i < trial->element_count; ++i) {
+		snd_ctl_elem_value_set_index(data, index + i);
+
 		/*
-		 * Here, I increment numid, while we can also increment offset
-		 * to enumerate each element in this element set.
+		 * In Linux 4.0 or former, ioctl(SNDRV_CTL_IOCTL_ELEM_ADD)
+		 * doesn't fill all of fields for identification.
 		 */
-		snd_ctl_elem_value_set_numid(data, numid + i);
+		if (numid > 0)
+			snd_ctl_elem_value_set_numid(data, numid + i);
 
 		err = snd_ctl_elem_read(trial->handle, data);
 		if (err < 0)
-- 
2.7.4
