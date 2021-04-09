Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE57C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:11:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8C161165
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8C161165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD846166F;
	Sat, 10 Apr 2021 00:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD846166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618006261;
	bh=UnvjL2YBU2vkHgizrzvifYluJpk/BDsUtQJYlD2RlOc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oV69ANliPqhGooWPegqzpCF9BrG31x+gBbgP09o8YA72l6P2Uqcjg5DDXTdGmNPpU
	 dbUD6184HAqhZn/lbD3vhQDzkPZOsXFUQyR5fG5IlbzZ4dn4yBnv/6y/wC1Z+L33YZ
	 h0Mw9BoEziDRY9CLGbF6Ln8/sJYTtCGkyoA/yOgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50560F8016D;
	Sat, 10 Apr 2021 00:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 428FDF8016A; Sat, 10 Apr 2021 00:10:09 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2218DF80162
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:10:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2218DF80162
IronPort-SDR: ehB8+UApHYObzJz8fpE1B1FPUtmB8v0hUu8GzRgQU7iYgwZlEf+cnCkwtfiMuFxq8XPpOSum6d
 6RJocBpcbQbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214285707"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="214285707"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:10:04 -0700
IronPort-SDR: SmvDBgfwtMcseT+7VmehDFh0jnD31rAE07AMXKJNjx2LT9Dlr2FoHVwqPqvkvkNuuQa/KfiAmb
 IrNRfiCSW5NQ==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599292823"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:10:04 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: simplify probe and report errors
Date: Fri,  9 Apr 2021 15:09:57 -0700
Message-Id: <20210409220959.1543456-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

These patches simplify the sof_probe_complete handling and
address reporting of errors during probe.

Peter Ujfalusi (2):
  ASoC: SOF: core: Add missing error prints to device probe operation
  ASoC: SOF: Simplify sof_probe_complete handling for acpi/pci/of

 sound/soc/sof/core.c         |  9 +++++++--
 sound/soc/sof/sof-acpi-dev.c | 18 +++---------------
 sound/soc/sof/sof-of-dev.c   | 18 +++---------------
 sound/soc/sof/sof-pci-dev.c  | 20 ++++----------------
 4 files changed, 17 insertions(+), 48 deletions(-)

-- 
2.25.1

