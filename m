Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B748C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 01:15:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD47619CD
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 01:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD47619CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CDE4112;
	Wed, 31 Mar 2021 03:14:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CDE4112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617153309;
	bh=fBwwvJhWCaCiBgApBu0aHh3U5yjRSFjrIT6y3wI14eg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V1EImQrjox5LI66aywBqx6xScXPoqy57TVbltQ4zZ8jukd8vgGLPQlyjVfw0TOPTe
	 1Ux/w6a0INwCgRBGviX4wLE8rHhlQOk874ljoPTL3+RVUg0ssZhjZ5jWuzjXWeZRO7
	 OthCOzeKMTtMzqXKTyD/UB4uYOZNsjqP5Ah7WHtw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACCFAF8023E;
	Wed, 31 Mar 2021 03:14:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49B37F8023E; Wed, 31 Mar 2021 03:14:17 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE29AF800B9
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 03:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE29AF800B9
IronPort-SDR: waWa44IfNMM5tsDC9weRP2CtKnOqhGsryg2OWAnfWp8hbAalCk3svoXnoe6UmgezatUV++m/Q+
 mhOIeacyXXvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191919202"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="191919202"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 18:14:11 -0700
IronPort-SDR: MzsrEQo7I1AypxZhMjlEiHsNJMiukxVdmvKyyukMSeudJQQ8ZmMMQj0Y2+s7PmTbeljyg1v0FA
 m3O5Xi6sAZDA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="418414692"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 18:14:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/2] soundwire: bus: handle errors in clock stop/start
 sequences
Date: Wed, 31 Mar 2021 09:13:53 +0800
Message-Id: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

If a device lost sync and can no longer ACK a command, it may not be
able to enter a lower-power state but it will still be able to resync
when the clock restarts. In those cases, we want to continue with the
clock stop sequence.

This patch modifies the behavior when -ENODATA is received, with the
error level demoted to a dev_dbg() since it's a recoverable issue.

For consistency the log messages are also modified to be unique and
self-explanatory, and missing logs are also added on clock stop exit.

Pierre-Louis Bossart (2):
  soundwire: add macro to selectively change error levels
  soundwire: bus: handle errors in clock stop/start sequences

 drivers/soundwire/bus.c | 70 +++++++++++++++++++----------------------
 drivers/soundwire/bus.h |  8 +++++
 2 files changed, 40 insertions(+), 38 deletions(-)

-- 
2.17.1

