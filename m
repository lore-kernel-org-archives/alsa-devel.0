Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66745C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 01:00:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F241619A8
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 01:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F241619A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 955D510E;
	Tue, 23 Mar 2021 01:59:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 955D510E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616461205;
	bh=dPa6diMaeROfbkKxUFbp6b7Rp/r/oqAl1amDhymFkho=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NKihp4++u8gkR3kkF1bAyjYa+w//EWDASlJPZz6wX74eYMVMAQtCc/5tX++f7+Fvm
	 t5oO4agjzcsQ2JtHQ4kQPp0NW1sRpUo5H0rjvuoC7EBu7ABwyUiyc950x7GNtPvwPR
	 K7M40CorjdzJIYEYxKY5zok8Nyewdj4Zxy4mQnO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 664B2F801D5;
	Tue, 23 Mar 2021 01:59:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7D44F801D5; Tue, 23 Mar 2021 01:59:12 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E66D8F80107
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 01:59:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E66D8F80107
IronPort-SDR: YctxeqY2kThUqsAvR/lJn4XVhHaPX0JjOPAw7MnVxX8EZM/PRfrHj4YXiLwMhkKxaTVzY6Xg4H
 r36iLERf2JyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275477943"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275477943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 17:59:06 -0700
IronPort-SDR: ZdKNzNMz8SYQ1t8eRal3511rk5tunH7tqDiwiuAf5DnLxi2fCyQ3SWLTmB+/5qt18wpCdvVuau
 f3d0aXGnrN/A==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="414728307"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 17:59:02 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/5] soundwire: add missing \n in dev_err()
Date: Tue, 23 Mar 2021 08:58:50 +0800
Message-Id: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
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

We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
adding new ones...

Pierre-Louis Bossart (5):
  soundwire: intel: add missing \n in dev_err()
  soundwire: bandwidth_allocation: add missing \n in dev_err()
  soundwire: cadence: add missing \n in dev_err()
  soundwire: stream: add missing \n in dev_err()
  soundwire: qcom: add missing \n in dev_err()

 drivers/soundwire/cadence_master.c             |  2 +-
 .../soundwire/generic_bandwidth_allocation.c   |  4 ++--
 drivers/soundwire/intel.c                      | 18 +++++++++---------
 drivers/soundwire/qcom.c                       |  2 +-
 drivers/soundwire/stream.c                     | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.17.1

