Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FFC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 22:59:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60D864F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 22:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60D864F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74B301ACD;
	Tue,  2 Mar 2021 23:58:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74B301ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614725958;
	bh=49OFKiFyivyMyklkbJOUJdreoqk0sPY8gf5/lQ0kCiQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+IxvS43+U2lNp0C0wGpoXWmLWQg7VNaI0824jLAyJPFPeINwUnw6C7MMQdk5pkc2
	 q/amlDMdYdHexA2DyDUlpj0GzvvodYbZUrZMCueEy/Y6ISQY7yR3lP0xP+qcCU7bPF
	 dJFhmTO8OkWw1C683ACLJGJBuvqzn/YgJI3GVd/s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1325CF80277;
	Tue,  2 Mar 2021 23:57:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99286F80273; Tue,  2 Mar 2021 23:57:35 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD1AFF8025B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 23:57:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD1AFF8025B
IronPort-SDR: sSXfMnppsGeFZVPiDcJnr+ePQI2P3HRrA0SmgOTvmgbDeoo/QFnteJ9Kl6SMN97sRflWXbxm48
 giTElPMt4S7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174146204"
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; d="scan'208";a="174146204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 14:57:24 -0800
IronPort-SDR: iLQsksdjxmN9Ef8vJXR8vJ1TbfpFQUgHR8hliYlgmHyGtPFOSAjjPUluGScmDt22zivoGQAlBB
 0+ulSUsnAuIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; d="scan'208";a="369134573"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 02 Mar 2021 14:57:22 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lHDxB-0000jB-N8; Tue, 02 Mar 2021 22:57:21 +0000
Date: Wed, 3 Mar 2021 06:56:23 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Tanure <tanureal@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: cs42l42: fix semicolon.cocci warnings
Message-ID: <20210302225623.GA39303@1d317909719f>
References: <20210302170454.39679-13-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-13-tanureal@opensource.cirrus.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kbuild-all@lists.01.org,
 Lucas Tanure <tanureal@opensource.cirrus.com>, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
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

From: kernel test robot <lkp@intel.com>

sound/soc/codecs/cs42l42.c:811:2-3: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

CC: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

url:    https://github.com/0day-ci/linux/commits/Lucas-Tanure/Report-jack-and-button-detection-Capture-Support/20210303-012348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

 cs42l42.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -808,7 +808,7 @@ static int cs42l42_pcm_hw_params(struct
 		break;
 	default:
 		break;
-	};
+	}
 
 	return cs42l42_pll_config(component);
 }
