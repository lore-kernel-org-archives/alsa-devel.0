Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B934C77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 06:57:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89194828;
	Mon, 15 May 2023 08:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89194828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684133821;
	bh=P4I4WMgNIQxYQ334Q+vWNS1kymuWnkPuLaU0h554R2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uu5lsI/7V6nxuEMFAN2m4Yv7oNTlbYDhH8L5Syj/B6Eq/naNPIIjCTOJMPhbiIc/T
	 XsKIOU9z4Zi8HRD6CUWxqtju5UZgnf8CoE1iPLk8Hx1xEOWgAuCfB13t80rnPwSVKa
	 7x1mpYJO2CO9/AWP/FFZe3WFHcNU+EVYKkCFzzF0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEEC7F80649; Mon, 15 May 2023 08:51:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01C07F80649;
	Mon, 15 May 2023 08:51:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEE3CF80620; Mon, 15 May 2023 08:51:21 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A99B1F80611
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 08:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A99B1F80611
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mvOQJKJT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133478; x=1715669478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4I4WMgNIQxYQ334Q+vWNS1kymuWnkPuLaU0h554R2Q=;
  b=mvOQJKJT7rNK4M6flrP6A80bhQ7g8OiiXg+/ELjACsn13w0Ziv21OO4w
   4POXhGj9W8EaCHmdnFSBqCAl8l00Lg9wT5b7wFH284rodvTtUYmPHuacC
   bKaT5Ve1jpygTFpdNmWHukMMcNuu7QscrdFkdc9ob0FuJKWeJtCwzeq2G
   Y06M/0ua6ciUlQzdTpTJfgo13V2Fmr7la6EdzYIf84uHY76YSr83nZK47
   lJ/ShUP1O2nQe+1FWfe183N3O/x4wSYU11uTA4k/AetNTEBCBzxq59FR5
   mkJb/1FJ95P72f5flewpF2URNcFZ3edPmT/197SCWJnmYq8+qpQYicNtG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966557"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="349966557"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908791"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200";
   d="scan'208";a="694908791"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2023 23:51:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	vinod.koul@linaro.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 23/26] soundwire: intel: remove .trigger callback
 implementation
Date: Mon, 15 May 2023 15:10:39 +0800
Message-Id: <20230515071042.2038-24-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SHZ3HS6E64DAKX26NYBGKXBO2QU252JV
X-Message-ID-Hash: SHZ3HS6E64DAKX26NYBGKXBO2QU252JV
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SHZ3HS6E64DAKX26NYBGKXBO2QU252JV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The interface is not needed for IPC3 solutions but will be needed
with an updated parameter list for ACE2.x+IPC4 combinations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c8eb1ec512c4..15cecd2e062d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -872,18 +872,9 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret = 0;
 
-	/*
-	 * The .trigger callback is used to send required IPC to audio
-	 * firmware. The .free_stream callback will still be called
-	 * by intel_free_stream() in the TRIGGER_SUSPEND case.
-	 */
-	if (res->ops && res->ops->trigger)
-		res->ops->trigger(dai, cmd, substream->stream);
-
 	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
 		dev_err(dai->dev, "failed to get dai runtime in %s\n",
-- 
2.25.1

