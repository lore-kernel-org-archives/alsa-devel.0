Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B2C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 08:52:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BA8208BA
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 08:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BA8208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 838BE16EF;
	Tue, 29 Dec 2020 09:51:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 838BE16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609231925;
	bh=UoGj64UJGsZuQEw/8K/Jnu5yIyyGitFb0Nl6PnGcvVM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UzQ8xbQ5jAYxWKrT+7BdJ83BJEujeB1G6H8vrlwYoPtnoPK6wyBdLDYYu+k5QTEWW
	 7fn+2Lj6gQ7q9hXpmMxtELcULmWeKLyzpTi0G9Y/qT1PNlqBRXu0VJsBP6R6hOjDnI
	 zd22TDuzt9A+UstYiBFFEK7Gh6wDuDR14vAA4mAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14A81F80143;
	Tue, 29 Dec 2020 09:51:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 662D9F8022B; Tue, 29 Dec 2020 09:51:13 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 264B1F80143
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 09:51:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 264B1F80143
Received: from localhost.localdomain ([93.22.37.45]) by mwinf5d25 with ME
 id A8r32400F0ySWMH038r4gt; Tue, 29 Dec 2020 09:51:06 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Dec 2020 09:51:06 +0100
X-ME-IP: 93.22.37.45
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com
Subject: [PATCH] ASoC: Intel: common: Fix some typos
Date: Tue, 29 Dec 2020 09:51:03 +0100
Message-Id: <20201229085103.192715-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

s/apci/acpi/

Turn an ICL into a TGL because it is likely a cut'n'paste error

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/intel/common/soc-acpi-intel-ehl-match.c | 2 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ehl-match.c b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
index badafc1d54d2..5c7a1214403d 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-ehl-match.c - tables and support for EHL ACPI enumeration.
+ * soc-acpi-intel-ehl-match.c - tables and support for EHL ACPI enumeration.
  *
  * Copyright (c) 2019, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 98196e9fad62..4933184df5f5 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-tgl-match.c - tables and support for ICL ACPI enumeration.
+ * soc-acpi-intel-tgl-match.c - tables and support for TGL ACPI enumeration.
  *
  * Copyright (c) 2019, Intel Corporation.
  *
-- 
2.27.0

