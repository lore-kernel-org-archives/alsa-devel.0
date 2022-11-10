Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94695C43217
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Nov 2022 22:56:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCED5163A;
	Thu, 10 Nov 2022 23:55:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCED5163A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668120957;
	bh=W0eIJYHhA6U00wfcU8AuwbRFd/2vy+U9LQqb9hJf/ds=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f7YoWFFbCyU9ZIA9wQ2v4DlDTx4N59iiIYl27YPKI7VWD8IKi0th0lXtiwV3krviR
	 tnxmnWnHOkAtMzr/JXVv9vWGg7yyAYGlgTn4nwkT4+bR6SIkfGfNIM9k7neTGz3hLN
	 fqccCxeh14axVhX+0a7LQR5MNthNAFN4PGoJODSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6286BF80163;
	Thu, 10 Nov 2022 23:55:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1A4DF80163; Thu, 10 Nov 2022 23:55:05 +0100 (CET)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F7B1F80104
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2022 23:55:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F7B1F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="knX/rgI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668120903; x=1699656903;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=W0eIJYHhA6U00wfcU8AuwbRFd/2vy+U9LQqb9hJf/ds=;
 b=knX/rgI4Nxjd5S+EAISJXOhq/DuYLM865bmLx7nmPDGkUQCC++9pgYuc
 E0bDPE12mq4wXn3tomtT9BWEfNkIvb4eLe1/2PoeH1HMfq7bQolNWyNhN
 iKBoyoM7aV1pj+KGC/FkpA8VPLfrpHaz42J1+34z8iSIz1d73JZaLnZ5M
 RZqpEcXGkGuT0/ym2k82vJJyNGx0AzH29OerfiLtv3P6GjXK3UHAnLLBV
 P0sQ/Qjba324p9HOrgOY0UEvoxkDOVvYtbkh/sSo0/j5Dk3hPgNCrZS5u
 N98PY/9dqDz06L4p2jdyqYPovv6Gd4gl2da/3lCY6JBbyJqf984uXIQEV Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373588004"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="373588004"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 14:54:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="670533691"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; d="scan'208";a="670533691"
Received: from tleibov-mobl.ger.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.214.199.216])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 14:54:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: Intel: add more ACPI tables/quirks for RPL/MTL 
Date: Thu, 10 Nov 2022 16:54:27 -0600
Message-Id: <20221110225432.144184-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for two RaptorLake SoundWire SKUs and one test board for
MeteorLake.

There will be additional RaptorLake SKUs shared when validation is
complete.

Gongjun Song (4):
  ASoC: Intel: sof_sdw: Add support for SKU 0C10 product
  ASoC: Intel: soc-acpi: add SKU 0C10 SoundWire configuration
  ASoC: Intel: sof_sdw: Add support for SKU 0C40 product
  ASoC: Intel: soc-acpi: add SKU 0C40 SoundWire configuration

Yong Zhi (1):
  ASoC: Intel: soc-acpi: add MTL AIC SoundWire configurations

 sound/soc/intel/boards/sof_sdw.c              |  21 ++++
 .../intel/common/soc-acpi-intel-mtl-match.c   |  59 ++++++++++
 .../intel/common/soc-acpi-intel-rpl-match.c   | 109 ++++++++++++++++++
 3 files changed, 189 insertions(+)

-- 
2.34.1

