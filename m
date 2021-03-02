Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92794C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:26:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981EB64F2E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981EB64F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C1CB190D;
	Tue,  2 Mar 2021 22:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C1CB190D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614720397;
	bh=eHUD/BRDTBk8i4NvA5X8uoH2Ib9baUYYhKVJ1YEFN8w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KgX1yjVxoBzUv7H5MKawzfZpJutXeX7MXx+xHE/PW+Sd3yFDZh3Drzt/FXsw6Hdli
	 ojW/yc/kCSOW/a8e2+h3lHukJ7AAbCkgfSsKhQIBetdOr5tDbC/wAcX5J/zONZd84h
	 xfH5Ba824ZjBzKLlaJi9UIJAS9s7EW32FUfbvxVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7A6FF80088;
	Tue,  2 Mar 2021 22:25:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22395F80269; Tue,  2 Mar 2021 22:25:45 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67A17F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:25:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67A17F80088
IronPort-SDR: AUn/+WN8TT4mC3Naq/ZWenzYRFTLZOzTYa/w+qgRF4qBFUsqdaZ89jTQMXTcqEXyJVBkM7MHkN
 2aGZOUaE5Hzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166885447"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="166885447"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:39 -0800
IronPort-SDR: iPAxRYXFX4tARwzH60FN7VqSvV00Y7wW2yY9gt3z6o6jj+e3TffEx6DTDM4dYlGIVp3n4k1gYw
 zDa+vqCzHkIg==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="399223335"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:25:38 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/24] ASoC: realtek: fix cppcheck warnings
Date: Tue,  2 Mar 2021 15:25:03 -0600
Message-Id: <20210302212527.55158-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Shuming Fan <shumingf@realtek.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>
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

Lots of trivial issues that make cppcheck too verbose. There shouldn't
be any functionality change with this patchset.

Pierre-Louis Bossart (24):
  ASoC: rt1011: use logical OR
  ASoC: rt1011: remove redundant test
  ASoC: rt1011: clarify expression
  ASoC: rt1015: clarify expression
  ASoC: rt1016: clarify expression
  ASoC: rt1305: clarify expression
  ASoC: rt1308: clarify expression
  ASoC: rt5640: clarify expression
  ASoC: rt5645: use logical OR
  ASoC: rt5645: clarify expression
  ASoC: rt5651: clarify expression
  ASoC: rt5651: remove useless assignment
  ASoC: rt5659: clarify expression
  ASoC: rt5660: clarify expression
  ASoC: rt5663: clarify expression
  ASoC: rt5665: clarify expression
  ASoC: rt5668: clarify expression
  ASoC: rt5668: remove useless assignments
  ASoC: rt5670: clarify expression
  ASoC: rt5677: clarify expression
  ASoC: rt5677: remove useless assignment
  ASoC: rt5682: clarify expression
  ASoC: rt5682: remove useless assignments
  ASoC: rt5682: remove useless initialization

 sound/soc/codecs/rt1011.c | 47 ++++++++++++++++++---------------------
 sound/soc/codecs/rt1015.c |  5 +++--
 sound/soc/codecs/rt1016.c |  7 +++---
 sound/soc/codecs/rt1305.c |  4 ++--
 sound/soc/codecs/rt1308.c |  8 +++----
 sound/soc/codecs/rt5640.c |  6 ++---
 sound/soc/codecs/rt5645.c |  6 ++---
 sound/soc/codecs/rt5651.c |  6 ++---
 sound/soc/codecs/rt5659.c |  4 ++--
 sound/soc/codecs/rt5660.c |  4 ++--
 sound/soc/codecs/rt5663.c |  4 ++--
 sound/soc/codecs/rt5665.c |  4 ++--
 sound/soc/codecs/rt5668.c |  8 +++----
 sound/soc/codecs/rt5670.c |  4 ++--
 sound/soc/codecs/rt5677.c |  6 ++---
 sound/soc/codecs/rt5682.c | 12 +++++-----
 16 files changed, 67 insertions(+), 68 deletions(-)

-- 
2.25.1

