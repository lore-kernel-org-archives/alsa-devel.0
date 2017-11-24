From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] test: correct emulation for channel-map TLV
Date: Fri, 24 Nov 2017 21:10:51 +0900
Message-ID: <20171124121051.9968-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 45C88266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 13:11:00 +0100 (CET)
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

Current implementation of channel-map TLV on test program is not valid.
Furthermore, it brings buffer-over-run due to byte counting.

This commit fixes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 668831a8..e94152b9 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -126,33 +126,39 @@ static void change_int_elem_members(struct elem_set_trial *trial,
 static int allocate_int_elem_set_tlv(struct elem_set_trial *trial,
 				     unsigned int **tlv)
 {
-	unsigned int len, pos;
+	unsigned int count, pos;
 	unsigned int i, j;
 	struct chmap_entry *entry;
 
 	/* Calculate size of TLV packet for channel-mapping information. */
-	len = 0;
+	count = 0;
 	for (i = 1; i <= 25; ++i) {
-		len += sizeof(struct chmap_entry);
-		len += i * sizeof(unsigned int);
+		count += 2; /* sizeof(struct chmap_entry). */
+		count += i; /* struct chmap_entry.maps. */
 	}
 
-	*tlv = malloc(len);
-	if (*tlv == NULL)
+	*tlv = malloc((2 + count) * sizeof(unsigned int));
+	if (!*tlv)
 		return -ENOMEM;
 
 	/*
 	 * Emulate channel-mapping information in in-kernel implementation.
 	 * Here, 25 entries are for each different channel.
 	 */
-	pos = 0;
-	for (i = 1; i <= 25 && pos < len; ++i) {
+	(*tlv)[0] = SNDRV_CTL_TLVT_CONTAINER;
+	(*tlv)[1] = count * sizeof(unsigned int);
+	pos = 2;
+
+	for (i = 1; i <= 25 && pos < count; ++i) {
 		entry = (struct chmap_entry *)&(*tlv)[pos];
+
 		entry->type = SNDRV_CTL_TLVT_CHMAP_FIXED;
 		entry->length = i * sizeof(unsigned int);
+		pos += 2;
+
 		for (j = 0; j < i; ++j)
 			entry->maps[j] = SND_CHMAP_MONO + j;
-		pos += sizeof(struct chmap_entry) + i * sizeof(unsigned int);
+		pos += i;
 	}
 
 	return 0;
-- 
2.14.1
