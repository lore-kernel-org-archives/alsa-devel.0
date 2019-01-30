From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Subject: [PATCH 3/3] asoc: (cosmetic) simplify a function
Date: Wed, 30 Jan 2019 17:22:41 +0100
Message-ID: <1548865361-12816-4-git-send-email-guennadi.liakhovetski@intel.com>
References: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
 by alsa0.perex.cz (Postfix) with ESMTP id D76C4267914
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:44 +0100 (CET)
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMP5-1giVdn1Mfj-00TVfn for
 <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:44 +0100
Received: from 200r.grange (200r.grange [192.168.1.16])
 by axis700.grange (Postfix) with ESMTP id 6C5D561CEB
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 17:22:42 +0100 (CET)
In-Reply-To: <1548865361-12816-1-git-send-email-guennadi.liakhovetski@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Doing "if (a >= b) return 1; return 0;" can be trivially simplified to
"return a >= b;" Use this for soc_tplg_is_eof().

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 045ef136903d..041e7c680a6b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -111,11 +111,7 @@ static int soc_tplg_check_elem_count(struct soc_tplg *tplg, size_t elem_size,
 
 static inline int soc_tplg_is_eof(struct soc_tplg *tplg)
 {
-	const u8 *end = tplg->hdr_pos;
-
-	if (end >= tplg->fw->data + tplg->fw->size)
-		return 1;
-	return 0;
+	return tplg->hdr_pos >= tplg->fw->data + tplg->fw->size;
 }
 
 static inline unsigned long soc_tplg_get_hdr_offset(struct soc_tplg *tplg)
-- 
2.17.1
