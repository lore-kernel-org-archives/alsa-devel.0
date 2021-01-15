Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06394C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 06:17:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B4A239EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 06:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B4A239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFC00179D;
	Fri, 15 Jan 2021 07:16:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFC00179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610691469;
	bh=EBpqPwNEW3RS1wQc4TOxPgX2QjEVsxEHndSuYLZnLiI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l8kWkRku8xIhIPjww5ZzGlBQdH+wH+hVKxjR3i4QVdMluqVd55AZ5Dop0nI+Mp4y+
	 zGn7u5Wj9TaX7E2sRUoN+odQoUZWbzEgBjiCRSzDvm8/A/0GweB9U4WR1Fko/u5Gfq
	 JZQr3eX88NPo0VcEelARnFst4vUmQNLa7k0IBVlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52326F80254;
	Fri, 15 Jan 2021 07:16:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67446F80113; Fri, 15 Jan 2021 07:16:57 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 338BFF80134
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 07:16:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 338BFF80134
IronPort-SDR: 3EcOqEiXs47vDPmjRlwNxxFSYax5pTq+aiE34LxLLwdnRRl63hauatx2axwiiv95srGAvc/oQ3
 ypYoAv7yJZHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166174457"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="166174457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 22:16:48 -0800
IronPort-SDR: mnVgka02Sl1SnutUAJk+1wWr2oACyhES3UBR8sx5a+sh96oUIQtho+6nMIcVYvHCrQG+ksXjAT
 TKFLeZffMh8A==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="382551858"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 22:16:45 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/2] ASoC/SoundWire: fix timeout values
Date: Fri, 15 Jan 2021 14:16:49 +0800
Message-Id: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

The timeout for an individual transaction w/ the Cadence IP is the same as
the entire resume operation for codecs.
This doesn't make sense, we need to have at least one order of magnitude
between individual transactions and the entire resume operation.

Set the timeout on the Cadence side to 500ms and 5s for the codec resume.

Both ASoC and SoundWire trees are fine for this series.

Pierre-Louis Bossart (2):
  ASoC: codecs: soundwire: increase resume timeout
  soundwire: cadence: reduce timeout on transactions

 drivers/soundwire/cadence_master.c | 2 +-
 sound/soc/codecs/max98373-sdw.c    | 4 +++-
 sound/soc/codecs/rt1308-sdw.c      | 2 +-
 sound/soc/codecs/rt5682.h          | 2 +-
 sound/soc/codecs/rt700-sdw.c       | 2 +-
 sound/soc/codecs/rt711-sdw.c       | 2 +-
 sound/soc/codecs/rt715-sdw.c       | 2 +-
 7 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.17.1

