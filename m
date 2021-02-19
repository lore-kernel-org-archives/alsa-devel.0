Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC27C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C6864EB2
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C6864EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7856B166C;
	Sat, 20 Feb 2021 00:10:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7856B166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776283;
	bh=jDQc2ksD6zFiOAlYoPWzL5fwJ6b9h4gKJW4VRKco50Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJe+05BrX1HZIGQWttMAfc0XC69dutq1j/ObvRYjmnH1o82PZc5I1ncuN8Q9tMgoC
	 qw2vymr+gkt/0iQ7VexQ6QE8JD1ZTAvKKjfAjOFOnrfgw4QNlZQ61t9ifQO5e3YiN3
	 Rkq/+B5O2feCSC2mYbazhMXtdYCCOA8xDeFiXfZk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C59DF801F5;
	Sat, 20 Feb 2021 00:09:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50394F8028B; Sat, 20 Feb 2021 00:09:43 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D3CAF801F5
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:09:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D3CAF801F5
IronPort-SDR: pn0cYVWMFHNGVMK/e/IyCqf92r2/PJn27oRss2aWVS6R49xNQE2Lr8UkY6Oez15zEqBn8uvHlh
 6k41S+D2bCTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163139051"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="163139051"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:29 -0800
IronPort-SDR: SgIBcEpP7hbDCx2i95QaJGrXpaZQUFYHI/fs7bFdd5lxnaJXWupVaCXjrZkB/CGiBW8GEx1ynn
 Ai8FIsj9AKoA==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="365362848"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:28 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/6] ASoC: samsung: i2s: remove unassigned variable
Date: Fri, 19 Feb 2021 17:09:13 -0600
Message-Id: <20210219230918.5058-2-pierre-louis.bossart@linux.intel.com>
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

sound/soc/samsung/i2s.c:1159:18: style: Variable 'dai' is not assigned
a value. [unassignedVariable]
 struct i2s_dai *dai;
                 ^

This variable is only used for a sizeof(*dai).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b043183174b2..c632842d42eb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1156,11 +1156,10 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 	static const char *stream_names[] = { "Primary Playback",
 					      "Secondary Playback" };
 	struct snd_soc_dai_driver *dai_drv;
-	struct i2s_dai *dai;
 	int i;
 
 	priv->dai = devm_kcalloc(&priv->pdev->dev, num_dais,
-				     sizeof(*dai), GFP_KERNEL);
+				     sizeof(struct i2s_dai), GFP_KERNEL);
 	if (!priv->dai)
 		return -ENOMEM;
 
-- 
2.25.1

