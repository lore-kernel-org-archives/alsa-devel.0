Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD076C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:18:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB2461A2A
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB2461A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ABE21688;
	Fri, 26 Mar 2021 23:17:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ABE21688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616797107;
	bh=0b+TEVoMxflbC0cnb4ORvWoipVBE6x2IjHqq9cMq0zg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/5DIilIPIR3DxQXHs/Db4bgbutgDDY596GY6AAOhaJOM/N77VWJYqWqzMJMp18W/
	 3emHIG6ekOQcsosY5oUIsuk4ZKzdYCr4i7EPtL/VKscge5hIIXgJZmu7O9rbWMbdA3
	 +pRan+PINeAumyy2EZ/MuWi14GLhobBOxent7x2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6792F80156;
	Fri, 26 Mar 2021 23:16:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE463F801EC; Fri, 26 Mar 2021 23:16:45 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06F06F80103
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:16:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F06F80103
IronPort-SDR: c4rkSqDzLCnKgf5exEf3jplwwXTuCcJXzmE6osInhqEgfvRf53O0dfbE/FM0T/0dRZDlQ22qN+
 mm3Zm4vSKFYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="276373853"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="276373853"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:16:35 -0700
IronPort-SDR: 34QJdPUncT96lUQIYIzihS44wToWZicF1nK572qYaqKj6FzzfNSXbRJ0+hj6A9OaazW9HTHrfV
 ze6P0bviXeHg==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416713337"
Received: from schine-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.213.191.61])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:16:34 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/2] ASoC: lm49453: fix useless assignment before return
Date: Fri, 26 Mar 2021 17:16:18 -0500
Message-Id: <20210326221619.949961-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
References: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, broonie@kernel.org,
 M R Swami Reddy <mr.swami.reddy@ti.com>
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

Cppcheck warning:

sound/soc/codecs/lm49453.c:1210:11: style: Variable 'pll_clk' is
assigned a value that is never used. [unreadVariable]

  pll_clk = BIT(4);
          ^

FIXME: What is the correct fix?
	/* fll clk slection */
	pll_clk = BIT(4);
	return 0;

is the assignment redundant or the 'return 0' a mistake?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/lm49453.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index eb3dd0bd80d9..fb0fb23537e7 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1206,8 +1206,6 @@ static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		break;
 	case 48000:
 	case 32576:
-		/* fll clk slection */
-		pll_clk = BIT(4);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.25.1

