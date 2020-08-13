Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830FC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:05:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C73920774
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hGhsEgpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C73920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2447742;
	Thu, 13 Aug 2020 22:04:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2447742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349146;
	bh=GkK48CJ3Mgn5QuBr3j4lUlXnLACVqO3+mpz6rC+C5hg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hGhsEgpSTUvjWykGhiI0DEYPGoVVq3cIFzAMKn7q74fUAX463Og7f7cOPTKiZTh0I
	 Yzf++1j/yovQ+U8LcYtz1ozf0ucZOMkm+dQeeyXPIwyC1Q4TxTZLHDUaD8b1EvbKYO
	 DAsplCbKPzrYj9F93kej0nk5kBmIr/XFi1gJ7vSI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A0FEF802FF;
	Thu, 13 Aug 2020 22:02:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F26CDF802E1; Thu, 13 Aug 2020 22:02:18 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0D27F8025E
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0D27F8025E
IronPort-SDR: YkbjIdJWPv2xSApaYAzfrfKqJIASmrXBYA2rDqAVeEgP3V+bvX7bdhYhOx8/+KJ3L66XIIZguW
 XcgBXxSzdrZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="172360709"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="172360709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:02 -0700
IronPort-SDR: Cr9AOzCAflzw3/vOnS1t4x/0ToZ8OosOuThh1Ynf9xxtyKze0JI4kD6MoPEEtxhcIxEOJb3emu
 oyMe8w0zPcUw==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506272"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 03/21] ASoC: Intel: Atom: platform-pcm: remove redundant
 assignment
Date: Thu, 13 Aug 2020 15:01:29 -0500
Message-Id: <20200813200147.61990-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
References: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
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

fix cppcheck warning:

sound/soc/intel/atom/sst-mfld-platform-pcm.c:387:9: warning: Identical
condition and return expression 'ret_val', return value is always 0
[identicalConditionAfterEarlyExit]
 return ret_val;
        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 49b9f18472bc..58628c7e7a0a 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -365,7 +365,7 @@ static int sst_media_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct sst_runtime_stream *stream;
-	int ret_val = 0, str_id;
+	int ret_val, str_id;
 
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
-- 
2.25.1

