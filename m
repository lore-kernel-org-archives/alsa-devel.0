From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] amixer: add support for TLV byte control read
Date: Fri, 22 Jan 2016 11:16:52 +0530
Message-ID: <1453441612-29902-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B479A26061E
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 06:43:14 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

TLV byte control are new type of byte controls added in kernel where
controls can have large sizes.

For these controls querying with 4096 size fails, so use the queried size to
read the control

This fixes the crash with current cget/contents on these type of controls

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 amixer/amixer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index db1849333da3..cfe13592347f 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -588,7 +588,7 @@ static int show_control(const char *space, snd_hctl_elem_t *elem,
 			int level)
 {
 	int err;
-	unsigned int item, idx, count, *tlv;
+	unsigned int item, idx, count, *tlv, tlv_sz;
 	snd_ctl_elem_type_t type;
 	snd_ctl_elem_id_t *id;
 	snd_ctl_elem_info_t *info;
@@ -682,13 +682,20 @@ static int show_control(const char *space, snd_hctl_elem_t *elem,
 	      __skip_read:
 		if (!snd_ctl_elem_info_is_tlv_readable(info))
 			goto __skip_tlv;
-		tlv = malloc(4096);
-		if ((err = snd_hctl_elem_tlv_read(elem, tlv, 4096)) < 0) {
+
+		if (type == SND_CTL_ELEM_TYPE_BYTES)
+			tlv_sz = count + 2 * sizeof(unsigned int);
+		else
+			tlv_sz = 4096;
+
+		tlv = malloc(tlv_sz);
+
+		if ((err = snd_hctl_elem_tlv_read(elem, tlv, tlv_sz)) < 0) {
 			error("Control %s element TLV read error: %s\n", card, snd_strerror(err));
 			free(tlv);
 			return err;
 		}
-		decode_tlv(strlen(space), tlv, 4096);
+		decode_tlv(strlen(space), tlv, tlv_sz);
 		free(tlv);
 	}
       __skip_tlv:
-- 
1.9.1
