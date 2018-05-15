From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 4/6] pcm: hw: use position offset
	macro of TLV data
Date: Tue, 15 May 2018 21:36:37 +0900
Message-ID: <20180515123639.18255-5-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7D1926707F
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:21 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id c10-v6so7667373pfi.12
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:21 -0700 (PDT)
In-Reply-To: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
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

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 65b198c5..a728b23b 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1199,6 +1199,7 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 	snd_ctl_t *ctl;
 	snd_ctl_elem_id_t id = {0};
 	unsigned int tlv[2048], *start;
+	unsigned int type;
 	snd_pcm_chmap_query_t **map;
 	int i, ret, nums;
 
@@ -1223,9 +1224,10 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 	/* FIXME: the parser below assumes that the TLV only contains
 	 * chmap-related blocks
 	 */
-	if (tlv[0] != SND_CTL_TLVT_CONTAINER) {
-		if (!is_chmap_type(tlv[0])) {
-			SYSMSG("Invalid TLV type %d\n", tlv[0]);
+	type = tlv[SNDRV_CTL_TLVO_TYPE];
+	if (type != SND_CTL_TLVT_CONTAINER) {
+		if (!is_chmap_type(type)) {
+			SYSMSG("Invalid TLV type %d\n", type);
 			return NULL;
 		}
 		start = tlv;
@@ -1234,7 +1236,7 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 		unsigned int *p;
 		int size;
 		start = tlv + 2;
-		size = tlv[1];
+		size = tlv[SNDRV_CTL_TLVO_LEN];
 		nums = 0;
 		for (p = start; size > 0; ) {
 			if (!is_chmap_type(p[0])) {
-- 
2.14.1
