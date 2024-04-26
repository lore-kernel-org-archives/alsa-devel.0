Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B7C4345F
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:32:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4CF31914;
	Fri, 26 Apr 2024 17:31:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4CF31914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714145521;
	bh=zYIR1CwCqTkT5fLAkl+YxT+RCYwjH04aAtHQ3/Vmp4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RpAIbhBJsKZE+4Ud6zkRFhjvXCo2f8r2WCfUvnO+uF0hIrqQDr90XB4WocsQndO/9
	 S92OieVWdiK0WforQFOGq7NXxSw2Ce2phijDxqdkmIxxdJGq+7XI7sFMwmb9dJVr/k
	 KJSE5J+e0k6stti4jqzxBTCddxi5VRPLmKwfF818=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AE93F896DD; Fri, 26 Apr 2024 17:26:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 703A3F896E3;
	Fri, 26 Apr 2024 17:26:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4595F806DD; Fri, 26 Apr 2024 17:26:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39809F80612
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2024 17:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39809F80612
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PwV7gsib
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714145157; x=1745681157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYIR1CwCqTkT5fLAkl+YxT+RCYwjH04aAtHQ3/Vmp4w=;
  b=PwV7gsibzhBll85Gr+Csa4VcDsIBHp/d65E2NEnSpVQwPN/VpsyRV7gq
   5ukfO/Z3Hhq5gsy6U/bnEx7gY5b78MP4v/CAafwFWgd3yfRxNDyiUJ87B
   4gmGmL9PgWIXofXHCgEks6iIDiVkoXFcxnG7NR9PkGmoOmc8hn+dS+jZk
   intZ7hty8NtoNHv/vFbIqM95/gVgQN7gFbvs1MNDa8sCRUj/IEaqQHP6o
   m3UcrF7Mvh1J+AdWd2TbATFy7qdldUtHS+6wpofH7zm5D3xJmDLfUFg6r
   855XA1HCEUmXRbYiwpQHEfzFFKLRKIkjTu/B4LsL0nuXxy6ti26HsMCb9
   g==;
X-CSE-ConnectionGUID: Pv7XI9URSI+XSNsW7fQmuw==
X-CSE-MsgGUID: phogw+yeS9miE/KvKodiyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="21291375"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="21291375"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 08:25:54 -0700
X-CSE-ConnectionGUID: 6ofE5vUVS8yURfdDkHnEFg==
X-CSE-MsgGUID: Yan3E4FuRLSGJe3nTRbd+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="30259627"
Received: from atarkhan-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.212.33.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 08:25:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 23/23] ASoC: Intel: sof-rt5682: support bclk as PLL source on
 rt5682s
Date: Fri, 26 Apr 2024 10:25:29 -0500
Message-Id: <20240426152529.38345-24-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240426152529.38345-1-pierre-louis.bossart@linux.intel.com>
References: <20240426152529.38345-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6IVRQNL6OGTEEMR4Y2FFBZ7P46BLY2R5
X-Message-ID-Hash: 6IVRQNL6OGTEEMR4Y2FFBZ7P46BLY2R5
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6IVRQNL6OGTEEMR4Y2FFBZ7P46BLY2R5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

For rt5682s codec, we could use bclk as PLL source when the frequency
is 3.072MHz but no 2.4MHz. Update the code to select correct pll_id
and clk_id for 3.072MHz bclk.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index c3b026868653..e3a2ec6b4c7c 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -355,18 +355,23 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 			clk_id = RT5682_SCLK_S_PLL1;
 			break;
 		case CODEC_RT5682S:
-			/*
-			 * For MCLK = 24.576MHz and sample rate = 96KHz case, use PLL1  We don't test
-			 * pll_out or params_rate() here since rt5682s PLL2 doesn't support 24.576MHz
-			 * input, so we have no choice but to use PLL1. Besides, we will not use PLL at
-			 * all if pll_in == pll_out. ex, MCLK = 24.576Mhz and sample rate = 48KHz
-			 */
-			if (pll_in == 24576000) {
+			/* check plla_table and pllb_table in rt5682s.c */
+			switch (pll_in) {
+			case 3072000:
+			case 24576000:
+				/*
+				 * For MCLK = 24.576MHz and sample rate = 96KHz case, use PLL1  We don't test
+				 * pll_out or params_rate() here since rt5682s PLL2 doesn't support 24.576MHz
+				 * input, so we have no choice but to use PLL1. Besides, we will not use PLL at
+				 * all if pll_in == pll_out. ex, MCLK = 24.576Mhz and sample rate = 48KHz
+				 */
 				pll_id = RT5682S_PLL1;
 				clk_id = RT5682S_SCLK_S_PLL1;
-			} else {
+				break;
+			default:
 				pll_id = RT5682S_PLL2;
 				clk_id = RT5682S_SCLK_S_PLL2;
+				break;
 			}
 			break;
 		default:
-- 
2.40.1

