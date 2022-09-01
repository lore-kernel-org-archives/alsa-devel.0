Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DADECAAD1
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Sep 2022 17:42:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7ACE41660;
	Thu,  1 Sep 2022 19:41:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7ACE41660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662054141;
	bh=Pdh/wSauElxjtjAHzr+4IBhDH7DzSJXcvsr+mokavSw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRtWyY/eUx4TEvNkCBGvNIviNTbI2Sq6by4CDIF6xkABclo9iJcD2h4ZJs5WSzKhq
	 z/DlONWtBurwspsG8n2tkejG+cGnpJuxkTTnY5B2C1RdahCcEDUWFhmzRpCpC8JfJ0
	 36tWq+cOoWLwisJO1/U9SFoVm+Y6TwDwAlJWj/Fo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB2B4F80535;
	Thu,  1 Sep 2022 19:40:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DB28F8052F; Thu,  1 Sep 2022 19:40:43 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB6DFF80236
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2022 19:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB6DFF80236
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OVHPWH8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662054038; x=1693590038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pdh/wSauElxjtjAHzr+4IBhDH7DzSJXcvsr+mokavSw=;
 b=OVHPWH8oYgSjI8N0Lx5rXK4RU9PHwjTN+ecPTVopUKTTTx6/qVMRh5y5
 qr0Zhapg2sq5sk8dklGcx24pTK7tL1Dl0dpCWsnmtOneJhH25G3Gclve8
 feS+N0mTVEpDPTT9MHrCwoKoFCRbYcXC5UMxJSvoShwrdv0FEk1Xu17b6
 bPPA8oSEKfMf4KSz/HUmWlsOMq+zp/xlYAPO8w4bbW6PdzTLLRbV8dufi
 vVhKMKo++DIHtBsCEVFa5vdGoKheSa6bYnxxtnRQPuRL5x8RfRxUgSFXr
 Q3Af//Nn90WnH+O8LP0cQZvzYO0l7J09o0RB3wqLgMsU66aFOIhamIUov Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295792351"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; d="scan'208";a="295792351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2022 10:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; d="scan'208";a="680960395"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 10:40:33 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v3 2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
Date: Thu,  1 Sep 2022 19:50:22 +0200
Message-Id: <20220901175022.334824-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901175022.334824-1-cezary.rojewski@intel.com>
References: <20220901175022.334824-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: andy@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, willy@infradead.org, lgirdwood@gmail.com,
 hdegoede@redhat.com, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, peter.ujfalusi@linux.intel.com,
 linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Make use of global user input tokenization helper instead of the
internal one as both serve same purpose. With that, both strsplit_u32()
and tokenize_input() become unused so remove them.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/sof/sof-client-probes.c | 93 ++++---------------------------
 1 file changed, 12 insertions(+), 81 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index eb246b823461..e9c44831fae1 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_helpers.h>
 #include <sound/soc.h>
 #include <sound/sof/header.h>
 #include "sof-client.h"
@@ -410,79 +411,6 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
 	.copy = sof_probes_compr_copy,
 };
 
-/**
- * strsplit_u32 - Split string into sequence of u32 tokens
- * @buf:	String to split into tokens.
- * @delim:	String containing delimiter characters.
- * @tkns:	Returned u32 sequence pointer.
- * @num_tkns:	Returned number of tokens obtained.
- */
-static int strsplit_u32(char *buf, const char *delim, u32 **tkns, size_t *num_tkns)
-{
-	char *s;
-	u32 *data, *tmp;
-	size_t count = 0;
-	size_t cap = 32;
-	int ret = 0;
-
-	*tkns = NULL;
-	*num_tkns = 0;
-	data = kcalloc(cap, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	while ((s = strsep(&buf, delim)) != NULL) {
-		ret = kstrtouint(s, 0, data + count);
-		if (ret)
-			goto exit;
-		if (++count >= cap) {
-			cap *= 2;
-			tmp = krealloc(data, cap * sizeof(*data), GFP_KERNEL);
-			if (!tmp) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-			data = tmp;
-		}
-	}
-
-	if (!count)
-		goto exit;
-	*tkns = kmemdup(data, count * sizeof(*data), GFP_KERNEL);
-	if (!(*tkns)) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-	*num_tkns = count;
-
-exit:
-	kfree(data);
-	return ret;
-}
-
-static int tokenize_input(const char __user *from, size_t count,
-			  loff_t *ppos, u32 **tkns, size_t *num_tkns)
-{
-	char *buf;
-	int ret;
-
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = simple_write_to_buffer(buf, count, ppos, from, count);
-	if (ret != count) {
-		ret = ret >= 0 ? -EIO : ret;
-		goto exit;
-	}
-
-	buf[count] = '\0';
-	ret = strsplit_u32(buf, ",", tkns, num_tkns);
-exit:
-	kfree(buf);
-	return ret;
-}
-
 static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 					  size_t count, loff_t *ppos)
 {
@@ -548,8 +476,8 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
 	struct sof_probe_point_desc *desc;
-	size_t num_tkns, bytes;
-	u32 *tkns;
+	size_t bytes;
+	u32 num_tkns, *tkns;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -557,16 +485,18 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = tokenize_user_input(from, count, (int **)&tkns);
 	if (ret < 0)
 		return ret;
+
+	num_tkns = *tkns;
 	bytes = sizeof(*tkns) * num_tkns;
 	if (!num_tkns || (bytes % sizeof(*desc))) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	desc = (struct sof_probe_point_desc *)tkns;
+	desc = (struct sof_probe_point_desc *)&tkns[1];
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
@@ -603,8 +533,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 	struct sof_client_dev *cdev = file->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
-	size_t num_tkns;
-	u32 *tkns;
+	u32 num_tkns, *tkns;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -612,9 +541,11 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = tokenize_user_input(from, count, (int **)&tkns);
 	if (ret < 0)
 		return ret;
+
+	num_tkns = *tkns;
 	if (!num_tkns) {
 		ret = -EINVAL;
 		goto exit;
@@ -626,7 +557,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		goto exit;
 	}
 
-	ret = sof_probes_points_remove(cdev, tkns, num_tkns);
+	ret = sof_probes_points_remove(cdev, &tkns[1], num_tkns);
 	if (!ret)
 		ret = count;
 
-- 
2.25.1

