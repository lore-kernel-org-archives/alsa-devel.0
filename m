Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F42C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:41:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2125D64E9C
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2125D64E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A96121699;
	Tue,  9 Feb 2021 00:41:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A96121699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827712;
	bh=Cl7GGVvVfUZcz3BTJR/nZqtkTQDw6UV3wqX6KSzflQQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XQ+qK7APGO4NixLUZk2UyPjB+XDtRswffK0yAEZUXr5DNNDSHZRU0ktjZX7xRwlmI
	 ddYy0tfWtUeW1EUbjk4KpCa/r9sOSEni2GpD8GnTdMTJSxrIcqauyAXdZpVrde7CWz
	 yRLUtL+8WuRTdy4Ut/K8sN8WKfTzlEbfQAO40ysU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42F9BF8022D;
	Tue,  9 Feb 2021 00:41:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A41FF8022D; Tue,  9 Feb 2021 00:41:00 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1B2FF80114
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:40:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1B2FF80114
IronPort-SDR: haMegh4VhBtmY+GgXBmcloAqAGRnvABxKLyEdZJ9F5yBoko7YP8Mi5JjQFRmaNCBbUrU2a74DN
 95xb/csZ+lzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243297906"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="243297906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:52 -0800
IronPort-SDR: 08TlvZ2Z0JtPxTYUvsHYL0qcXCBR0p7V66U9T+ZHBq1/+72hZkFG+zRT6og7lj4jkT2z0Lddcp
 TG4DepZK46LA==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="487640911"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/2] ASoC: dapm/pins: handle component prefix
Date: Mon,  8 Feb 2021 17:40:41 -0600
Message-Id: <20210208234043.59750-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

SoundWire machine drivers make a heavy use of component prefixes to
uniquify control names. This however results in errors when looking
for widgets or pins. This patchset suggests two solutions but feedback
or suggestions on how to take the prefix into account would be
welcome.

Bard Liao (1):
  ASoC: Intel: boards: max98373: get dapm from cpu_dai

Shuming Fan (1):
  ASoC: dapm: use component prefix when checking widget names

 sound/soc/intel/boards/sof_maxim_common.c |  5 +++--
 sound/soc/soc-dapm.c                      | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.25.1

