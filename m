Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20875C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 02:51:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C9460C3F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 02:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0C9460C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D766166E;
	Wed, 18 Aug 2021 04:50:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D766166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629255081;
	bh=T6CDCAXMZdpz/2Q2pH+mrVnDMtvGl7JNb7Fj4NIjTb4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lc9mCbr/FRB/hS/o7Iu8R7tJuD/9eM228q3F0Gww1cLHi1L/NFmChCvMvq4x4LedH
	 O+tNCAnalgkgS+1XpSunFWYcEYWYc1yhyNvc+IQrPHN88PnaTQvVI5K/wl8KLhYVi3
	 xMmpNExnCnr/Bgyh7JVHKMUA8rl1SfnQ4i64AfnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E07ABF80163;
	Wed, 18 Aug 2021 04:50:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11974F8028D; Wed, 18 Aug 2021 04:50:27 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 726E9F80246
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 04:50:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 726E9F80246
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="213119349"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="213119349"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 19:50:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="520723283"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 19:50:12 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/3] soundwire: intel: exit clock-stop mode before system
 suspend
Date: Wed, 18 Aug 2021 10:49:51 +0800
Message-Id: <20210818024954.16873-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
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

Intel validation reported an issue where the HW_RST self-clearing bit
is not cleared in hardware, which as a ripple effect creates issues
with the clock stop mode.

This happens is a specific sequence where the Intel manager is
pm_runtime suspended with the clock-stop mode enabled. During the
system suspend, we currently do nothing, which can lead to potential
issues on system resume and the following pm_runtime suspend,
depending on the hardware state.

This patch suggests a full resume if the clock-stop mode is used. This
may require extra time but will make the suspend/resume flows
completely symmetric. This also removes a race condition where we
could not access SHIM registers if the parent was suspended as
well. Resuming the link also resumes the parent by construction.

BugLink: https://github.com/thesofproject/linux/issues/2606

v2:
 - Better comments and commit messages.
 - Modified the .prepare callback to only deal with the corner case that is
   NOT covered today instead of systematically doing a full resume.

Pierre-Louis Bossart (3):
  soundwire: intel: fix potential race condition during power down
  soundwire: intel: skip suspend/resume/wake when link was not started
  soundwire: intel: conditionally exit clock stop mode on system suspend

 drivers/soundwire/intel.c | 150 ++++++++++++++++++++++++++++++--------
 drivers/soundwire/intel.h |   1 +
 2 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.17.1

