From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] test: use proper threshold level
	information for user-ctl-element-set test
Date: Sat, 17 Sep 2016 23:49:26 +0900
Message-ID: <1474123768-13160-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id ECC26265A8B
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 16:49:33 +0200 (CEST)
In-Reply-To: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, broonie@kernel.org
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Currently, this test program uses invalid array for threshold level
information.

This commit replaces the array with valid information, which consists of
newly exported TLV macros from kernel land.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 9b9dc59..7d22ca6 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -8,6 +8,7 @@
  */
 
 #include "../include/asoundlib.h"
+#include <sound/tlv.h>
 
 struct elem_set_trial {
 	snd_ctl_t *handle;
@@ -414,22 +415,34 @@ static int check_elems(struct elem_set_trial *trial)
 
 static int check_tlv(struct elem_set_trial *trial)
 {
-	unsigned int orig[8], curr[8];
-	int err;
-
 	/*
-	 * See a layout of 'struct snd_ctl_tlv'. I don't know the reason to
-	 * construct this buffer with the same layout. It should be abstracted
-	 * inner userspace library...
+	 * Use unlikely data for threshold level.
+	 *
+	 *  Linear: dB range (coeff)
+	 *  0<-> 4: -5940<->-5636 (44)
+	 *  4<->22: -5636<->-4556 (60)
+	 * 22<->33: -4556<->-4072 (76)
+	 * 33<->37: -4072<->-3832 (44)
+	 * 37<->48: -3832<->-2996 (76)
+	 * 48<->66: -2996<->-2204 (60)
+	 * 66<->84: -2204<-> -836 (44)
+	 * 84<->95:  -836<-> -176 (60)
+	 * 95<->99:  -176<->    0 (76)
 	 */
-	orig[0] = snd_ctl_elem_id_get_numid(trial->id);
-	orig[1] = 6 * sizeof(orig[0]);
-	orig[2] = 'a';
-	orig[3] = 'b';
-	orig[4] = 'c';
-	orig[5] = 'd';
-	orig[6] = 'e';
-	orig[7] = 'f';
+	static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(orig,
+		SNDRV_CTL_TLVD_DB_RANGE_HEAD(9),
+		 0,   4, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5940, 44, 1),
+		 4,  22, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5636, 60, 0),
+		22,  33, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4556, 76, 0),
+		33,  37, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4072, 44, 0),
+		37,  48, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-3832, 76, 0),
+		48,  66, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2996, 60, 0),
+		66,  84, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2204, 44, 0),
+		84,  95, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -836, 60, 0),
+		95,  99, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -176, 76, 0),
+	);
+	unsigned int curr[sizeof(orig)/sizeof(orig[0])];
+	int err;
 
 	/*
 	 * In in-kernel implementation, write and command operations are the
-- 
2.7.4
