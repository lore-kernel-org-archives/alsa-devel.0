From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V2] pcm: plugin_ops.h: Add
	S24_3LE/S20_3LE/S18_3LE support in gets_label
Date: Tue, 22 Jul 2014 10:30:41 +0800
Message-ID: <1405996241-24764-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F962654BF
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 04:30:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When route_policy is average, src format is S24_3LE, the get_idx will exceed
length of table gets_label. So add items for S24_3LE/S20_3LE/S18_3LE in the
table.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/plugin_ops.h |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index 21535c9..1213b69 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -670,7 +670,7 @@ getu_1234_C321: sample = bswap_32(as_u32c(src) ^ 0x80); goto GETU_END;
 
 #ifdef GETS_LABELS
 /* width endswap sign_toggle */
-static void *const gets_labels[4 * 2 * 2] = {
+static void *const gets_labels[4 * 2 * 2 + 4 * 3] = {
 	&&gets_1_1,		/*  8h ->  8h */
 	&&gets_1_9,		/*  8h ^>  8h */
 	&&gets_1_1,		/*  8s ->  8h */
@@ -687,6 +687,19 @@ static void *const gets_labels[4 * 2 * 2] = {
 	&&gets_1234_9234,	/* 32h ^> 32h */
 	&&gets_1234_4321,	/* 32s -> 32h */
 	&&gets_1234_C321,	/* 32s ^> 32h */
+	/* 3bytes format */
+	&&gets_123_0123,	/* 24h -> 24h */
+	&&gets_123_0923,	/* 24h ^> 24h */
+	&&gets_123_0321,	/* 24s -> 24h */
+	&&gets_123_0B21,	/* 24s ^> 24h */
+	&&gets_123_0123_20,	/* 20h -> 24h */
+	&&gets_123_0923_20,	/* 20h ^> 24h */
+	&&gets_123_0321_20,	/* 20s -> 24h */
+	&&gets_123_0B21_20,	/* 20s ^> 24h */
+	&&gets_123_0123_18,	/* 18h -> 24h */
+	&&gets_123_0923_18,	/* 18h ^> 24h */
+	&&gets_123_0321_18,	/* 18s -> 24h */
+	&&gets_123_0B21_18,	/* 18s ^> 24h */
 };
 #endif
 
@@ -706,6 +719,18 @@ gets_1234_1234: sample = as_s32c(src); goto GETS_END;
 gets_1234_9234: sample = (int32_t)(as_s32c(src) ^ 0x80000000); goto GETS_END;
 gets_1234_4321: sample = (int32_t)bswap_32(as_s32c(src)); goto GETS_END;
 gets_1234_C321: sample = (int32_t)bswap_32(as_s32c(src) ^ 0x80); goto GETS_END;
+gets_123_0123: sample = sx24(_get_triple(src)); goto GETS_END;
+gets_123_0923: sample = sx24(_get_triple(src) ^ 0x800000); goto GETS_END;
+gets_123_0321: sample = sx24(_get_triple_s(src)); goto GETS_END;
+gets_123_0B21: sample = sx24(_get_triple_s(src) ^ 0x800000); goto GETS_END;
+gets_123_0123_20: sample = sx24(_get_triple(src) << 4); goto GETS_END;
+gets_123_0923_20: sample = sx24((_get_triple(src) << 4) ^ 0x800000); goto GETS_END;
+gets_123_0321_20: sample = sx24(_get_triple_s(src) << 4); goto GETS_END;
+gets_123_0B21_20: sample = sx24((_get_triple_s(src) << 4) ^ 0x800000); goto GETS_END;
+gets_123_0123_18: sample = sx24(_get_triple(src) << 6); goto GETS_END;
+gets_123_0923_18: sample = sx24((_get_triple(src) << 6) ^ 0x800000); goto GETS_END;
+gets_123_0321_18: sample = sx24(_get_triple_s(src) << 6); goto GETS_END;
+gets_123_0B21_18: sample = sx24((_get_triple_s(src) << 6) ^ 0x800000); goto GETS_END;
 }
 #endif
 
-- 
1.7.9.5
