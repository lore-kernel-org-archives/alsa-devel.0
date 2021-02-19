Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C34C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D885A64EB3
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D885A64EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AE92166E;
	Sat, 20 Feb 2021 00:10:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AE92166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776287;
	bh=L/NpH8ZjN7mKv8x0YuNa6lrlb0mP69e3aVlWZXFmSWI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=id5+ZVJ2Xteo2MHPQSnBsEeI48gGKSqnhp6594j9og+H8LGWZNe+fRDRrZ/Y79F0/
	 MiHvIPGDPflrHuU7f0Wb74krTDMBJLI1G2APhYSuKv9xAg9fujqZffppMRxC2WkPHV
	 3X7omEajUgkVmwPHiQAEYVyA3ftuMCHmOsT2Qw5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38303F802C8;
	Sat, 20 Feb 2021 00:09:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08A3EF802A9; Sat, 20 Feb 2021 00:09:45 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E3D4F8020B
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:09:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E3D4F8020B
IronPort-SDR: jpDlM7EfwUL/aZSP9sddXQMoAIGt/NCSfaiYMlncl5xGcUuF38bRaA490r743Wq9tvA5jgERF6
 TLeJZQ747oVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163139054"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="163139054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:30 -0800
IronPort-SDR: 6+cuZZ1vzky70C1+L7g+WfRtm7BCao8GniZjlKCCLsVTBhF1Mw02TajR0Aqivfq2XIs6MclpFH
 ZiPMgKECTlow==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="365362852"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:29 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/6] ASoC: samsung: s3c24xx_simtec: add missing error check
Date: Fri, 19 Feb 2021 17:09:14 -0600
Message-Id: <20210219230918.5058-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck warning:

sound/soc/samsung/s3c24xx_simtec.c:191:7: style: Variable 'ret' is
assigned a value that is never used. [unreadVariable]
  ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
      ^

Looking at the code, it's not clear why the return value is checked in
the two other cases but not here, so mirror the behavior and add a
check.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/s3c24xx_simtec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 3cddd11344ac..81a29d12c57d 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -190,6 +190,11 @@ static int simtec_hw_params(struct snd_pcm_substream *substream,
 
 		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
 					     cdclk_scale);
+		if (ret) {
+			pr_err("%s: failed to set clock div\n",
+			       __func__);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1

