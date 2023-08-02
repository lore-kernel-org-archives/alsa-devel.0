Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A1BC00528
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 09:40:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A5BB210;
	Fri,  4 Aug 2023 11:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A5BB210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691142008;
	bh=Q4Mr+xkgTjGBFACbNn4h5Zt9PM79qGV8IrQ4WQ3+NC0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Io5mwVXbdhGxvmTbZpkzTRgPjflT1SD5s80vgAJ1FPfTJJ0M5GqoPx5D58MZOQ4um
	 /jvGUqnMEC9af/yU8I3izR4/s07mDJvsqUtEQQa9D6YN3fDXklX9foialeajnSjhYj
	 e74YI4qQO/zSTPeInF/YXKZolW7mWIjm9V5itJDo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D062AF80589; Fri,  4 Aug 2023 11:37:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B828F80589;
	Fri,  4 Aug 2023 11:37:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAB14F801D5; Wed,  2 Aug 2023 04:30:01 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01CBFF80087
	for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2023 04:29:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01CBFF80087
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFwr255SJzVjDr;
	Wed,  2 Aug 2023 10:28:02 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 10:29:46 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <liaoyu15@huawei.com>, <set_pte_at@outlook.com>,
	<alsa-devel@alsa-project.org>, <liwei391@huawei.com>
Subject: [PATCH -next] ALSA: ac97: set variables dev_attr_vendor_id to static
Date: Wed, 2 Aug 2023 10:26:49 +0800
Message-ID: <20230802022649.2514787-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-MailFrom: liaoyu15@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4JWGUR5HCF72HUWYCLH4SZNB7X37RKXO
X-Message-ID-Hash: 4JWGUR5HCF72HUWYCLH4SZNB7X37RKXO
X-Mailman-Approved-At: Fri, 04 Aug 2023 09:37:38 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4JWGUR5HCF72HUWYCLH4SZNB7X37RKXO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

sparse reports
sound/ac97/bus.c:465:1: sparse: sparse: symbol 'dev_attr_vendor_id' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242300.Oy0Dp2QI-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 sound/ac97/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 6067c04ce4c0..3173e9d98927 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -462,7 +462,7 @@ static ssize_t vendor_id_show(struct device *dev,
 
 	return sysfs_emit(buf, "%08x", codec->vendor_id);
 }
-DEVICE_ATTR_RO(vendor_id);
+static DEVICE_ATTR_RO(vendor_id);
 
 static struct attribute *ac97_dev_attrs[] = {
 	&dev_attr_vendor_id.attr,
-- 
2.25.1

