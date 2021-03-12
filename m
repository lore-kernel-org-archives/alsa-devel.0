Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A913C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:03:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C78964F40
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C78964F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CA561714;
	Fri, 12 Mar 2021 19:02:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CA561714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615572224;
	bh=KROTqqWOYX6RjyZyg1ZMwJe1vdS7NLHO8y/Z0fLSnF0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PKGDHSYdPyXfhx+Bw2O+dtbk/ALMCeaVU162VNq6WD3EI0g2zE6mPqj9R31Ru/rCB
	 TXKZqg2gMqwIj1eacfAFCJgBhOQ9xRkRTSd02AHZ4RY5t0a2i8c8JIa/BUSY3hnjt6
	 VA0vJqNdSp3NQivX/q+G7shwnJ7kuNuap1SawILM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2B7DF8016C;
	Fri, 12 Mar 2021 19:02:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E39A6F800AB; Fri, 12 Mar 2021 19:02:52 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65B91F800AB
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:02:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65B91F800AB
IronPort-SDR: nAtOAbhFFwBSu7f29Jc+ReWcT54E/EKxEjPc2jMtQcvCWV3Cdnsp+L+1ab7rRxI/Asg8QlbErI
 CiSlOQXCJ4Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176459528"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="176459528"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:02:39 -0800
IronPort-SDR: ZkDXOoi3Yx1OXMpXxlpHbBAUj3SBMqB+ryYdgfdHenYNlHx/URSdlw8SjJyqX5wI+HynrWosoc
 4RKSzKb5eppw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="432013358"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:02:38 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 0/2] ASoC: samsung: remove cppcheck warnings
Date: Fri, 12 Mar 2021 12:02:29 -0600
Message-Id: <20210312180231.2741-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

v4:
corrected Fixes tag
Added added Krzysztof Kozlowski's r-v-b tag
reverted patch2 to v2 since this is the agreement.

v3:
Added Sylwester tag
Rebased and squashed fix with initial patch which was merged at some
point but can't be found in broonie/for-next (not sure what happened?)
Corrected patch subjects to tm2_wm5110
Reverted second patch to initial v1, after agreement between Krzysztof
and Sylwester

v2:
added Krzysztof Kozlowski's tags
added fix for first patch already merged as suggested by Krzysztof Kozlowski
moved variable to lower scope in patch6

Pierre-Louis Bossart (2):
  ASoC: samsung: tm2_wm5110: check of of_parse return value
  ASoC: samsung: tm2_wm5110: remove shadowed variable

 sound/soc/samsung/tm2_wm5110.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1

