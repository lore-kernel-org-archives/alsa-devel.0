Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5BFC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Dec 2022 08:51:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9059C1890;
	Mon, 12 Dec 2022 09:50:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9059C1890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670835087;
	bh=F9zq1yrr8sAp03e3KEwHeY8qevfvAAdWWCtEIuNte2c=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=iKAPbq+wpfN8xiBzZB8P3LvAAVQjJ8VsMCJTOON+3toEzcEhQl3UfKhGkn60rTqb/
	 DPnpA+yUkz4Z+maBkzb7Ca5WlurQp0KpJpdRRv6XLWJkBCU8V2kNQYz0BjbB0VWtgm
	 vE+CwOJxGS/iYxIkhiK/wmuO5qwudrcKZk2BOqus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42F49F8042F;
	Mon, 12 Dec 2022 09:50:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BE7CF80115; Mon, 12 Dec 2022 09:50:36 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06914F80115
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2022 09:50:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06914F80115
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lMWvPa5Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670835035; x=1702371035;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F9zq1yrr8sAp03e3KEwHeY8qevfvAAdWWCtEIuNte2c=;
 b=lMWvPa5YFRVbKBbk8O9fDr3Vy0f3b3aLdyZyOnI9TvzuIcYfO+JdEsvd
 C/0uaOuZ/1eX5qQUWtPQK1ECjq+L+7e207LdCkFwwbNDrzLeqTXk5zLbU
 H5RDvTJoX/gUJdwI07uJh9IMwkLp6EvaAZ4HsLRhezIJN6/KFcUXarfbW
 yIiS4m9d45yJIwgsxU9lAhsiE++rrLNSKRkT3gvT8AqRpz01zwoEDKFM9
 UN9LBWIRsCLO5uqEqW7yTZRFsS3P0TVHKaWWxO3obPh/J5lfk+EK//968
 79J6d84dIk69iuBD7DdXfzHipClXxGSDV2Rw8uJYmKareZrEjobEFZlAd A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="318945177"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; d="scan'208";a="318945177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 00:50:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="772520853"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; d="scan'208";a="772520853"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 00:50:29 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH] ASoC: Intel: soc-acpi: update codec addr on 0C11/0C4F product
Date: Mon, 12 Dec 2022 16:55:27 +0800
Message-Id: <20221212085527.1886168-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Gongjun Song <gongjun.song@intel.com>

The unique ID is determined by the ADR pin level of rt1318.
ODM changed design, update codec addr to match new design.

Fixes: 0050e3d3d43d ("ASoC: Intel: soc-acpi: add SKU 0C11 SoundWire configuration")
Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 3c5229f41bb0..31b43116e3d8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -112,7 +112,7 @@ static const struct snd_soc_acpi_adr_device rt1316_1_group2_adr[] = {
 
 static const struct snd_soc_acpi_adr_device rt1318_1_group1_adr[] = {
 	{
-		.adr = 0x000131025D131801ull,
+		.adr = 0x000132025D131801ull,
 		.num_endpoints = 1,
 		.endpoints = &spk_l_endpoint,
 		.name_prefix = "rt1318-1"
-- 
2.25.1

