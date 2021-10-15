Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169ECC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:17:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B5361090
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48B5361090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CE821832;
	Fri, 15 Oct 2021 18:16:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CE821832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634314648;
	bh=Bm0gfdhxBCS71UAW7skj623uNzM/TpG46HpL2f8aWg4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/mgf9Em+cA4wq6aXDgC0mundR9/BDGeZmjxLNVowjSnE1tICfF1+aJ7dBn5e2Icr
	 dLZOKpTLV3+urMRY7r/JKO814aHZCIuEN4z13Ittmq0gHxqD1el6MO9Zy+gchlokSf
	 vLjnnXomxpNx2Ryb0EOyFBPZbbepHRlEK/2ecb2M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E9CAF804E6;
	Fri, 15 Oct 2021 18:15:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF79EF804E7; Fri, 15 Oct 2021 18:15:52 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B14A8F80423
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 18:15:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B14A8F80423
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225404652"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="225404652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 09:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="564375255"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2021 09:11:14 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/6] ASoC: topology: Check for dapm widget completeness
Date: Fri, 15 Oct 2021 18:12:54 +0200
Message-Id: <20211015161257.27052-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015161257.27052-1-cezary.rojewski@intel.com>
References: <20211015161257.27052-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 hdegoede@redhat.com, broonie@kernel.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Add sanity checks to make sure the data is read within file boundary.
Helps in situations where file is only partially copied or malformed.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/soc-topology.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2484de8fd79a..5b73e1455c23 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1591,11 +1591,28 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 		struct snd_soc_tplg_dapm_widget *widget = (struct snd_soc_tplg_dapm_widget *) tplg->pos;
 		int ret;
 
+		/*
+		 * check if widget itself fits within topology file
+		 * use sizeof instead of widget->size, as we can't be sure
+		 * it is set properly yet (file may end before it is present)
+		 */
+		if (soc_tplg_get_offset(tplg) + sizeof(*widget) >= tplg->fw->size) {
+			dev_err(tplg->dev, "ASoC: invalid widget data size\n");
+			return -EINVAL;
+		}
+
+		/* check if widget has proper size */
 		if (le32_to_cpu(widget->size) != sizeof(*widget)) {
 			dev_err(tplg->dev, "ASoC: invalid widget size\n");
 			return -EINVAL;
 		}
 
+		/* check if widget private data fits within topology file */
+		if (soc_tplg_get_offset(tplg) + le32_to_cpu(widget->priv.size) >= tplg->fw->size) {
+			dev_err(tplg->dev, "ASoC: invalid widget private data size\n");
+			return -EINVAL;
+		}
+
 		ret = soc_tplg_dapm_widget_create(tplg, widget);
 		if (ret < 0) {
 			dev_err(tplg->dev, "ASoC: failed to load widget %s\n",
-- 
2.25.1

