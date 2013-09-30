From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] amixer: actually print all TLVs in a container
	TLV
Date: Mon, 30 Sep 2013 23:46:50 +0300
Message-ID: <1380574010-6024-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AE5026512B
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 22:47:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Due to a wrong indexing of tlv[] decode_tlv() always skips to the end of
the container TLV since the used tlv[1] contains the container TLV size
instead of the intended element size.

This causes, for example, only the first HDMI channel map TLV to be
shown.

Fix the indexing to actually use the element size.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 amixer/amixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index 7727943..b83b0c3 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -468,7 +468,7 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 				return;
 			}
 			decode_tlv(spaces + 2, tlv + idx, tlv[idx+1] + 8);
-			idx += 2 + (tlv[1] + sizeof(unsigned int) - 1) / sizeof(unsigned int);
+			idx += 2 + (tlv[idx+1] + sizeof(unsigned int) - 1) / sizeof(unsigned int);
 		}
 		break;
 	case SND_CTL_TLVT_DB_SCALE:
-- 
1.8.1.5
