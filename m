From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-utils)] amixer: Print TLV of channel map
	controls
Date: Fri, 14 Jun 2013 11:41:01 +0200
Message-ID: <1371202861-18758-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 421A3261A6B
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 11:41:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Previously these were written as "unk-25..." which wasn't very user friendly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 amixer/amixer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index fe83b49..7727943 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -443,6 +443,7 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 	unsigned int type = tlv[0];
 	unsigned int size;
 	unsigned int idx = 0;
+	const char *chmap_type = NULL;
 
 	if (tlv_size < 2 * sizeof(unsigned int)) {
 		printf("TLV size error!\n");
@@ -541,6 +542,27 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 		}
 		break;
 #endif
+#ifdef SND_CTL_TLVT_CHMAP_FIXED
+	case SND_CTL_TLVT_CHMAP_FIXED:
+		chmap_type = "fixed";
+		/* Fall through */
+	case SND_CTL_TLVT_CHMAP_VAR:
+		if (!chmap_type)
+			chmap_type = "variable";
+		/* Fall through */
+	case SND_CTL_TLVT_CHMAP_PAIRED:
+		if (!chmap_type)
+			chmap_type = "paired";
+		printf("chmap-%s=", chmap_type);
+
+		while (size > 0) {
+			printf("%s", snd_pcm_chmap_name(tlv[idx++]));
+			size -= sizeof(unsigned int);
+			if (size > 0)
+				printf(",");
+		}
+		break;
+#endif
 	default:
 		printf("unk-%i-", type);
 		while (size > 0) {
-- 
1.8.3
