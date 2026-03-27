Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A26D10ED675
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:19:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1171F601F0;
	Fri, 27 Mar 2026 14:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1171F601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774617552;
	bh=lIcEeJUAxHlLV+3EoJu2rdgzUpTAIhxvKJOwKa/Fqvg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cdUVFfWYSusenR0LSR4hCYQ6AsCK/1EPJWyjZFoT1DCDI6W6exxKumdwlV/SJqC5R
	 vJM/1sjPzuK2y1RqrQw8AO7ZwqAV7KfbMP4Tnc/bYN051A/rTMutS142v48gE1s9A9
	 Ev7n/Vaj1ehpLe35YE+mJqEBkZbpzRxfBBQ3Wd7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B023F805F6; Fri, 27 Mar 2026 14:18:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13646F805F5;
	Fri, 27 Mar 2026 14:18:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E6A5F804F3; Fri, 27 Mar 2026 14:18:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0571AF80212
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 14:18:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0571AF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gZXgl7Tk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774617510; x=1806153510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lIcEeJUAxHlLV+3EoJu2rdgzUpTAIhxvKJOwKa/Fqvg=;
  b=gZXgl7TkPrq1WVmkiq6XM6PRcMc1hGVTi+/ai+7ijFNeqTRBPrlga+S7
   tznFviR6Pq0VNpkVuCcVttzwKiWcktNl/Y9kMipzGiXWVRy0AZqx3KMBJ
   bT5o6bq6I5xyiEQXQi7fu2nnxJhqeu2BRZswPCWhr20NtVUJwDWdxX+jj
   H4HfM+v8rJI5AeAv3mpJFb5kJ/qmEXXTYPtasHLIvMzrnLY+7Cr2nTlI5
   g43XQDtmato+B513MDjcv3yo0FkVJebFYX6hXuykfq+tH4Pf1H9UjsuuV
   aBe21v7Ghm2A1RHxQyqaetg97IkaXzf4qQ2b+0HHAY3JcEybn0LNH9Gr+
   g==;
X-CSE-ConnectionGUID: iS7aJVPEQnCPiReHHbqmWg==
X-CSE-MsgGUID: YQUdJRhtSya3pDvfO1a4kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75571283"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000";
   d="scan'208";a="75571283"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:18:25 -0700
X-CSE-ConnectionGUID: DVjpZ390Rn2/FpCszCsiXQ==
X-CSE-MsgGUID: /2HYjI6gTIyOGNylFRiIZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000";
   d="scan'208";a="248354538"
Received: from jpp-desktop.igk.intel.com ([10.91.221.24])
  by fmviesa002.fm.intel.com with ESMTP; 27 Mar 2026 06:18:23 -0700
From: Sachin Mokashi <sachin.mokashi@intel.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	Sachin Mokashi <sachin.mokashi@intel.com>
Subject: [PATCH] ASoC: Intel: ehl_rt5660: Use the correct rtd->dev device in
 hw_params
Date: Fri, 27 Mar 2026 09:14:39 -0400
Message-Id: <20260327131439.1330373-1-sachin.mokashi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID-Hash: RXXTR6IDWSFIVSIW5U6HNDHJIA2BRMDI
X-Message-ID-Hash: RXXTR6IDWSFIVSIW5U6HNDHJIA2BRMDI
X-MailFrom: sachin.mokashi@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RXXTR6IDWSFIVSIW5U6HNDHJIA2BRMDI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In rt5660_hw_params(), the error path for snd_soc_dai_set_sysclk()
correctly uses rtd->dev as the logging device, but the error path for
snd_soc_dai_set_pll() uses codec_dai->dev instead.

These two devices are distinct:
- rtd->dev is the platform device of the PCM runtime (the Intel HDA/SSP
  controller, e.g. 0000:00:1f.3), which owns the machine driver callback.
- codec_dai->dev is the I2C device of the rt5660 codec itself
  (i2c-10EC5660:00).

Since hw_params is a machine driver operation and both calls are made
within the same function from the machine driver's context, all error
messages should be attributed to rtd->dev. Using codec_dai->dev for one
of them would suggest the error originates inside the codec driver,
which is misleading.

Align the PLL error log with the sysclk one to use rtd->dev, matching
the convention used by all other Intel board drivers in this directory.

Signed-off-by: Sachin Mokashi <sachin.mokashi@intel.com>
---
 sound/soc/intel/boards/ehl_rt5660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/ehl_rt5660.c b/sound/soc/intel/boards/ehl_rt5660.c
index 5c7b218f22b7..c40cd9fb1a26 100644
--- a/sound/soc/intel/boards/ehl_rt5660.c
+++ b/sound/soc/intel/boards/ehl_rt5660.c
@@ -127,7 +127,7 @@ static int rt5660_hw_params(struct snd_pcm_substream *substream,
 				  params_rate(params) * 50,
 				  params_rate(params) * 512);
 	if (ret < 0)
-		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 
 	return ret;
 }
-- 
2.34.1

Intel Deutschland GmbH
Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
Tel: +49 89 991 430, www.intel.de
Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorrell
Chairperson of the Supervisory Board: Nicole Lau
Registered Seat: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

