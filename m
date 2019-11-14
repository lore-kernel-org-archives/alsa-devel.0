Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F103C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B087206F4
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R2HfaUbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B087206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA1CF1614;
	Thu, 14 Nov 2019 16:33:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA1CF1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573745651;
	bh=LrnF4oVsDNfHpc3GI/+5BTJddRwcMRHS8qzSjDg+hNM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2HfaUbVUuH3nSjK0DkBQPwtPpqke8cAFVYHEDJGBfCRmwaIPiZ6xJPzfwMBL9bre
	 zDEPw7XXFrWdmN35JzLRHr6Ua8M/nJKt5CM0jqwNguFoaK5qA45zo2XUboka55H/sU
	 nppBrASWjeyNvGaq2ND5dNPjrgTCYZexxhjq7HIs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 595D5F800CD;
	Thu, 14 Nov 2019 16:33:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63F39F800E9; Thu, 14 Nov 2019 16:33:19 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D753F8007E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 16:33:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D753F8007E
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 07:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="405008904"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2019 07:33:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1iVH7N-0003cb-Er; Thu, 14 Nov 2019 23:33:09 +0800
Date: Thu, 14 Nov 2019 23:33:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Ben Zhang <benzh@chromium.org>
Message-ID: <20191114153304.n4pyix7qadu76tx4@4978f4969bb8>
References: <201911142322.pHmcOJHb%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201911142322.pHmcOJHb%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
 Curtis Malainey <cujomalainey@chromium.org>
Subject: [alsa-devel] [RFC PATCH linux-next] ASoC: rt5677:
 rt5677_check_hotword() can be static
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


Fixes: 21c00e5df439 ("ASoC: rt5677: Enable jack detect while DSP is running")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rt5677.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 48955b22262fa..cd01a3a8daa82 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5243,7 +5243,7 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 	},
 };
 
-bool rt5677_check_hotword(struct rt5677_priv *rt5677)
+static bool rt5677_check_hotword(struct rt5677_priv *rt5677)
 {
 	int reg_gpio;
 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
