From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: control: add dimension validator for
	userspace element
Date: Fri,  1 Jul 2016 13:15:10 +0900
Message-ID: <1467346511-28051-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 0A2852652C1
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 06:15:16 +0200 (CEST)
In-Reply-To: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
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

The 'dimen' field in struct snd_ctl_elem_info is used to compose all of
members in the element as multi-dimensional matrix. The field has four
members. Each member represents the width in each dimension level by
element member unit. For example, if the members consist of typical
two dimensional matrix, the dimen[0] represents the number of rows
and dimen[1] represents the number of columns (or vise-versa).

The total members in the matrix should be within the number of members in
the element, while current implementation has no validator of this
information. In a view of userspace applications, the information must be
valid so that it cannot cause any bugs such as buffer-over-run.

This commit adds a validator of dimension information for userspace
applications which add new element sets. When they add the element sets
with wrong dimension information, they receive -EINVAL.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index a85d455..eeb080f 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -805,6 +805,43 @@ static int snd_ctl_elem_list(struct snd_card *card,
 	return 0;
 }
 
+static bool validate_element_member_dimension(struct snd_ctl_elem_info *info)
+{
+	unsigned int members;
+	unsigned int i = 0;
+
+	/* The value for each level should be zero or positive. */
+	if (info->dimen.d[0] < 0)
+		return false;
+	members = info->dimen.d[0];
+
+	if (members > 0) {
+		for (++i; i < ARRAY_SIZE(info->dimen.d); ++i) {
+			if (info->dimen.d[i] < 0)
+				return false;
+			if (info->dimen.d[i] == 0)
+				break;
+
+			/* Prevention of division by zero, for safe. */
+			if (members == 0)
+				return false;
+			/* Prevent arithmetic overflow. */
+			if (info->dimen.d[i] > UINT_MAX / members)
+				return false;
+
+			members *= info->dimen.d[i];
+		}
+	}
+
+	/* The rest of level should be zero. */
+	for (++i; i < ARRAY_SIZE(info->dimen.d); ++i) {
+		if (info->dimen.d[i] != 0)
+			return false;
+	}
+
+	return members <= info->count;
+}
+
 static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 			     struct snd_ctl_elem_info *info)
 {
@@ -1272,6 +1309,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (info->count < 1 ||
 	    info->count > max_value_counts[info->type])
 		return -EINVAL;
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
 	private_size = value_sizes[info->type] * info->count;
 
 	/*
-- 
2.7.4
