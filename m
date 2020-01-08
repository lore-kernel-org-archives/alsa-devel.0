Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB6C282DD
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:56:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8E320705
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eFkHcPnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8E320705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59A041736;
	Wed,  8 Jan 2020 18:55:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59A041736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578506158;
	bh=N7qlOiNwwRf8W0fNyKbt3rYFRPnMRe4QDLOlkJsJvus=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eFkHcPnHyvFl3BkQCZ4Zni2lz7QuYBVlnSeKsdH8j2oPKObV6lsrtXlhnQoBo9ex3
	 hZavH8nFW5k+mc5jTc+0VER78s1lt1P3IsYWJlPRPV4UeAfdgKa87UnbLT8d+TxNSP
	 2pvaS0FgsTmEQfspHDUOv+Cft3Gpt0RfAwh0d6bA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72850F80161;
	Wed,  8 Jan 2020 18:55:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAC44F801DA; Wed,  8 Jan 2020 18:55:04 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C178AF80116
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 18:55:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C178AF80116
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 09:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; d="scan'208";a="211617351"
Received: from cozturk-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.17.77])
 by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 09:54:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  8 Jan 2020 11:54:32 -0600
Message-Id: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/6] soundwire: stream: fix state machines and
	transitions
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

The existing stream support works fine with simple cases, but does not
map well with ALSA transitions for underflows/resume where prepare()
can be called multiple times. Concurrency with multiple devices per
links or multiple streams enabled on the same link also needs to be
fixed.

These patches are the result of hours of validation on the Intel side
and should benefit other implementations since there is nothing
hardware-specific. The Intel-specific changes being reviewed do depend
on those stream changes though to be functional.

Bard Liao (1):
  soundwire: stream: only prepare stream when it is configured.

Pierre-Louis Bossart (3):
  soundwire: stream: remove redundant pr_err traces
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

Rander Wang (2):
  soundwire: stream: fix support for multiple Slaves on the same link
  soundwire: stream: don't program ports for a stream that has not been
    prepared

 Documentation/driver-api/soundwire/stream.rst | 63 ++++++++----
 drivers/soundwire/stream.c                    | 97 +++++++++++++++----
 2 files changed, 124 insertions(+), 36 deletions(-)


base-commit: 09f6a72d014386939d21899921dd379006471a4b
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
