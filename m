Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8353FC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:28:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0991B207F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b3WLayev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991B207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 996CE1679;
	Wed,  1 Jul 2020 20:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 996CE1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593628128;
	bh=rQAi/s5XFU2GAp163k1Ju7ZtRxNQIR2I2cYqxGpg8xI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3WLayevisS/hOSrT5nD3QktyxIdvXN0j2HGKiiiOZl0RIugEcGB8W2d2oqvIkg/4
	 Gzql5pk3Ww3jHJadgWDIoyMgAJUDaT1hIFrcekM1wCJ4DlvY7Rx1Ya8vR5nAa7k3DF
	 ttwhdgLzF0cHR8kX0qvZ1GwH/O5le9QWjP2CM71Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 077EAF802DD;
	Wed,  1 Jul 2020 20:24:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F51EF80256; Wed,  1 Jul 2020 20:24:48 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E494F80269
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:24:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E494F80269
IronPort-SDR: rXzEeDPImsi6l/DNUI1adf4lnVFTbHNPgZheSsr2Esfj54YFBjaiiPMw2y0fhxGNly6sCYkx1y
 fiu8ZsZdfYQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="208189511"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="208189511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:37 -0700
IronPort-SDR: UB3QaTSuxk04et/prg4LZXBeU1HzWKvk4FbAbnzOZpw2Zklvd3ROYpZvcq1mBWzJ6nm/Q+v/t0
 jLwQzP4VgYSw==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="425679568"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:24:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/11] ASoC: codecs: es8316: fix 'defined but not used' warning
Date: Wed,  1 Jul 2020 13:24:16 -0500
Message-Id: <20200701182422.81496-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>, broonie@kernel.org,
 Daniel Drake <drake@endlessm.com>
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

Fix W=1 warning

sound/soc/codecs/es8316.c:842:36: warning: 'es8316_acpi_match' defined
but not used [-Wunused-const-variable=]
  842 | static const struct acpi_device_id es8316_acpi_match[] = {
      |                                    ^~~~~~~~~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/es8316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 36eef1fb3d18..70af35c5f727 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -839,11 +839,13 @@ static const struct of_device_id es8316_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, es8316_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id es8316_acpi_match[] = {
 	{"ESSX8316", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, es8316_acpi_match);
+#endif
 
 static struct i2c_driver es8316_i2c_driver = {
 	.driver = {
-- 
2.25.1

