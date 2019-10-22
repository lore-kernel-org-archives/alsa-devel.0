Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A90CA9EB7
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218C3222BE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="omAfencC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218C3222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2DD21607;
	Wed, 23 Oct 2019 01:48:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2DD21607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571788181;
	bh=sqWOjdINJyyRSoWNlA4Fh0wyeGYoDOC/rwgsmpeiCKA=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=omAfencCUZZJKlvrszCe1KcrYTIuLaUVUCbsVX/zahC9uA0Rg88YjiDGU9KHClSHl
	 SjtLfhj77XDowecZn9uHQQ9LnpTNYEv8bmGcn4+zBVey/Q+fzRcEJhJYy292v46JmY
	 6K6UkGo7xWM3ZErH5asRZBvFmcRQ1xBoKbzDB72U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B196AF8031A;
	Wed, 23 Oct 2019 01:48:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5888F8026A; Wed, 23 Oct 2019 01:48:48 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB34AF8026A
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 01:48:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB34AF8026A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 16:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="399211273"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.20.203])
 by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 16:48:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 18:48:05 -0500
Message-Id: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/3] soundwire: use UniqueID only when relevant
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The hardware UniqueID, typically enabled with pin-strapping, is
required during enumeration to avoid conflicts between devices of the
same type.

When there are no devices of the same type, using the UniqueID is
overkill and results in a lot of probe errors due to mismatches
between ACPI tables and hardware capabilities. For example it's not
uncommon for BIOS vendors to copy/paste the same settings between
platforms but the hardware pin-strapping is different. This is
perfectly legit and permitted by MIPI specs.

With this patchset, the UniqueID is only used when multiple devices of
the same type are detected. The loop to detect multiple identical
devices is not super efficient but with typically fewer than 4 devices
per link there's no real incentive to be smarter.

This change is only implemented for ACPI platforms, for DeviceTree
there is no change.

Pierre-Louis Bossart (3):
  soundwire: remove bitfield for unique_id, use u8
  soundwire: slave: add helper to extract slave ID
  soundwire: ignore uniqueID when irrelevant

 drivers/soundwire/bus.c       |  7 +--
 drivers/soundwire/slave.c     | 98 +++++++++++++++++++++++++++--------
 include/linux/soundwire/sdw.h |  4 +-
 3 files changed, 84 insertions(+), 25 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
