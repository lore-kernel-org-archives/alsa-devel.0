Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C56C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:50:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3F220757
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="egwAqfD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3F220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AD661692;
	Thu,  9 Apr 2020 20:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AD661692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586458201;
	bh=RyVmpvUEYrpY5IkvweEyzuV9k59LUHs9rUDWQ3j+P4w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=egwAqfD5ydgQXGrXnuit7ePWwjqcnXrNwFkqxH+gIUhs9TW0oXpdMdnaZN1su6VRN
	 o3uyvvi5WdhOE+yno/qVCUOp16oSbXJ4RXdF7VZqTsqbYYsqVtTXn2MHbiKHPcORCj
	 5R5F/vBibpa+fHetL9Bl+16fxD16rvy+kSg6WxvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA41CF801F9;
	Thu,  9 Apr 2020 20:49:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84536F80213; Thu,  9 Apr 2020 20:49:09 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29722F80107
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29722F80107
IronPort-SDR: NQmXjMSTeCoRFtkIZlfNY4bLYQxkM0RE2SsFnpTvzYhuQKcBeFeXIDaJTLWNGvVN9OeFc/7sJR
 YMnOlbZF6LpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 11:49:03 -0700
IronPort-SDR: WwH0szwiFRkqq+SYextK+Hs9gerD88kE1esRMDUBhG5OgOxqMM63niAidMRSVAtxUlqFQbsulY
 Nfms/6X4RMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="255246430"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by orsmga006.jf.intel.com with ESMTP; 09 Apr 2020 11:49:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: trivial code cleanups
Date: Thu,  9 Apr 2020 13:48:51 -0500
Message-Id: <20200409184853.15896-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

Fix warnings reported by tools - no functionality change.

Payal Kshirsagar (2):
  ASoC: SOF: remove unneeded variables
  ASoC: SOF: Intel: hda: remove unnecessary parentheses

 sound/soc/sof/intel/hda-codec.c | 5 +----
 sound/soc/sof/intel/hda-dsp.c   | 8 ++++----
 sound/soc/sof/nocodec.c         | 6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)


base-commit: dd8e871d4e560eeb8d22af82dde91457ad835a63
-- 
2.20.1

