Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:32:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C4F64F6A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C4F64F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24CC317AE;
	Fri, 12 Mar 2021 19:31:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24CC317AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573927;
	bh=9iRGPjL2CRBVinZ5dqJmuuYAafqu7EKakTtWed79rjk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cqCdTMdezxorhfqm5n55djgWkfYEJMPPC7qKRL9mKQk0xOTcw0vA5lN2BGKtWcvbp
	 +vDEenzA6ohfwpCLcCIjwZ9r/V7o78H9cnE0e3v2tD04olMrGYzJqi+IcQgiH7Bd5C
	 vq8gmz5K6ekBBw7c5reJVhzfZrb229XlUIaa4xq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF2E1F8042F;
	Fri, 12 Mar 2021 19:24:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66593F80529; Fri, 12 Mar 2021 19:24:03 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BF2DF8050F
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BF2DF8050F
IronPort-SDR: Z4ZaE16BzHiElk5OqQQJG6ZjBogHkqFzjGSbIvxLtozy5pQkv9WGvkKZIOcBTM6h6Y5gOLiYZY
 O+ENBHq47fsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188236507"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="188236507"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:52 -0800
IronPort-SDR: o8BsyRpU/yc0CdyM5I3L1bh5ATKYgIyYoD4rM7Z3YXWGPwZgTOw+zfGiYLvYsTGC2dYAqXCbBS
 kcCRuVHdnKnQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377792064"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:51 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 20/23] ASoC: tas2562: remove warning on return value
Date: Fri, 12 Mar 2021 12:22:43 -0600
Message-Id: <20210312182246.5153-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jonghwan Choi <charlie.jh@kakaocorp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org,
 Dan Murphy <dmurphy@ti.com>
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

sound/soc/codecs/tas2562.c:530:9: warning: Identical condition and return expression 'ret', return value is always 0 [identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/codecs/tas2562.c:525:6: note: If condition 'ret' is true, the function will return/exit
 if (ret)
     ^
sound/soc/codecs/tas2562.c:530:9: note: Returning identical expression 'ret'
 return ret;
        ^

Fix with return 0

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index ba23f9f07f04..10302552195e 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -526,7 +526,7 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 
 	tas2562->volume_lvl = ucontrol->value.integer.value[0];
 
-	return ret;
+	return 0;
 }
 
 /* Digital Volume Control. From 0 dB to -110 dB in 1 dB steps */
-- 
2.25.1

