Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEFC56201
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:49:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C7F22203
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tU7SHZGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C7F22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 369A2950;
	Fri, 30 Oct 2020 07:48:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 369A2950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604040550;
	bh=ie/Sru96Pe95Uwf0yEkhTOim1Xbl2xZkX0bzdyEbWKM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tU7SHZGxZVUP/MxutCY46FQc0+XJ1aHFzwa18RfPe+Fv6pqn3ui7JTDmAOZEp0csH
	 zn52E329dd9hk0dHl7yR0wVVp0TBaZDEwKHsLbY5u9dqPR3pXPPTrwCKcQAMlLBSVP
	 QhlOSkz3H96vUIlfxKJ6DiPLHTybHM+C5oIfBhnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53BB0F800C0;
	Fri, 30 Oct 2020 07:48:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FEA9F800C0; Fri, 30 Oct 2020 07:48:17 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0475F800C0
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 07:48:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0475F800C0
IronPort-SDR: EaY4VvJ/r6AYFLuU0gDx0GNWk9SSbBJ2QaPwFFnMtL8gLC8WkJwJxekLz/79P+YUx0SsFbQL0C
 YT+1FtnRSGWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168697914"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="168697914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 23:48:09 -0700
IronPort-SDR: IFt1+nBqLLkX+l35QIPUUmSBbUlkSuVnLhPzrmHKAVzzfSBlrjNmdZKQDx9XOzMviCj9iA3seM
 58xAKyTukACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="361760812"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2020 23:47:54 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] Add rt1015 support to CML boards
Date: Fri, 30 Oct 2020 14:36:52 +0800
Message-Id: <20201030063654.25877-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jason Yan <yanaijie@huawei.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Brent Lu <brent.lu@intel.com>,
 Yong Zhi <yong.zhi@intel.com>
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

First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
64fs on CML boards. Second patch is a DMI quirk for HP Dooly.


Brent Lu (2):
  ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
  ASoC: intel: sof_rt5682: Add quirk for Dooly

 sound/soc/intel/boards/sof_rt5682.c           | 61 +++++++++++++++++--
 .../intel/common/soc-acpi-intel-cml-match.c   | 13 ++++
 2 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.17.1

