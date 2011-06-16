From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] alsa-utils: amixer: Fix SND_CTL_TLVT_DB_RANGE
	handling
Date: Thu, 16 Jun 2011 14:19:18 +0200
Message-ID: <1308226758-5852-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-083.synserver.de (smtp-out-112.synserver.de
	[212.40.185.112])
	by alsa0.perex.cz (Postfix) with ESMTP id A93AA2466F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 14:21:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Current support for handling SND_CTL_TLVT_DB_RANGE in amixer is completely
broken. This patch fixes it.

Reported-by: Daniel Mack <zonque@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 amixer/amixer.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index a177288..9d2855d 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -517,20 +517,20 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 #ifdef SND_CTL_TLVT_DB_RANGE
 	case SND_CTL_TLVT_DB_RANGE:
 		printf("dBrange-\n");
-		if ((size / (6 * sizeof(unsigned int))) != 0) {
+		if ((size % (6 * sizeof(unsigned int))) != 0) {
 			while (size > 0) {
 				printf("0x%08x,", tlv[idx++]);
 				size -= sizeof(unsigned int);
 			}
 			break;
 		}
-		idx = 0;
-		while (idx < size) {
+		while (size > 0) {
 			print_spaces(spaces + 2);
-			printf("rangemin=%i,", tlv[0]);
-			printf(",rangemax=%i\n", tlv[1]);
-			decode_tlv(spaces + 4, tlv + 2, 6 * sizeof(unsigned int));
-			idx += 6 * sizeof(unsigned int);
+			printf("rangemin=%i,", tlv[idx++]);
+			printf(",rangemax=%i\n", tlv[idx++]);
+			decode_tlv(spaces + 4, tlv + idx, 4 * sizeof(unsigned int));
+			idx += 4;
+			size -= 6 * sizeof(unsigned int);
 		}
 		break;
 #endif
-- 
1.7.2.5
