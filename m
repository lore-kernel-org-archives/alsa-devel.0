Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB08C433E2
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:41:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED33207EA
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aWy1G/G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED33207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1D4F1AB1;
	Fri,  4 Sep 2020 10:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1D4F1AB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599208897;
	bh=a5JaVI7WX4Ffo7kJCU+cIbeMeMuRyD0R7v+o3m/evaI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aWy1G/G89Ps3PQB7zFQggoWLceAihCDngMsJmfqHGMj000LaUjc8f7+068+GlGZ81
	 nIulWfzuLv/gj3cpCnGbjc/ZFsVapgvJGbmPnMVi/BFk8ZBqKDmb3xFOMBMjNorjtJ
	 7GOnBrRuZUPfckGZtq62HAG5IIDwo8S9bAtzvq7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C321F80257;
	Fri,  4 Sep 2020 10:40:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDFC2F80257; Fri,  4 Sep 2020 10:40:45 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C73CF80113
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 10:40:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C73CF80113
IronPort-SDR: G6UV9YiQ2JhfnsnyE87mq1aGgDwJMtgDHDMAKQYIdK/m+dxaX2OO198GZnYlvXIHe1wZgHJYO6
 zNJZ/VXIrrzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137231238"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="137231238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 01:40:34 -0700
IronPort-SDR: SArn5SKMBnPwKqdjUimlbTiMJ8yKzoB0sqc6YHLrl13UwYQRYsnXSyM+29UpGwYUMcBUyYVz0r
 GtBjRVdL8u9w==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="478402057"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 01:40:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/3] ASoC: Add sdw stream operations to dailink ops.
Date: Fri,  4 Sep 2020 04:46:47 +0800
Message-Id: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

Sdw stream operation APIs can be called once per stream. Move these
operations to dailink ops. The linked series is "soundwire: Remove sdw
stream operations from Intel soundwire dai".

Pierre-Louis Bossart (3):
  ASoC: soc-dai: clarify return value for get_sdw_stream()
  ASOC: Intel: sof_sdw: add dailink .trigger callback
  ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback

 include/sound/soc-dai.h          |  3 +-
 sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.17.1

