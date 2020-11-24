Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F1C56201
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:27:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE7020782
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B7WIGZXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE7020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F20AC42;
	Tue, 24 Nov 2020 14:27:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F20AC42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606224476;
	bh=lavjaROK0NMcr5iEMd+kwNylPbqDoc0LVm+aOSgLboM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B7WIGZXjZbnfmXnODmHTRty6C+zBfewud4RZ7Bd6ryDZGCTiKYNJbe2cGaBdBfsCg
	 ubY5AeMMOm2NOYiDH7YAmg7bKVbFSnscosnKKXEpCvZNv3HWxNcwQ/2/aSXGoU0uGZ
	 /GlIn0kkRic2poRNHwRcYgfSQBkkE1uxcbgE7tRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77203F80290;
	Tue, 24 Nov 2020 14:26:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72791F8026C; Tue, 24 Nov 2020 14:26:13 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D8F3F80161
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 14:26:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D8F3F80161
IronPort-SDR: KK+5ISzreX3+oKgJjr6qC6JLejEDjBuvYnoC1GtCjR17JUqxuCyNngtJHK62HESSae42MwoD//
 nhEAj4iDV+Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039530"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172039530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:25:58 -0800
IronPort-SDR: gETpOmSBhzL7Gl+IpiZZtP1DJNplQimRg9iyo6QDFx2+wZbrK+EwrOpUnEjUJgX91+VJjSho8t
 dnpndV72Txew==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="546830554"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:25:54 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/5] soundwire: only clear valid interrupts
Date: Tue, 24 Nov 2020 09:33:13 +0800
Message-Id: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
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

We wrote 1 to the handled interrupts bits along with 0 to all other bits
to the SoundWire DPx interrupt register. However, DP0 has reserved fields
and the read-only SDCA_CASCADE bit. DPN also has reserved fields. We should
not try to write values in these fields.
Besides, we deal with pending interrupts in a loop but we didn't reset the
slave_notify status.

Pierre-Louis Bossart (5):
  soundwire: bus: add comments to explain interrupt loop filter
  soundwire: bus: reset slave_notify status at each loop
  soundwire: registers: add definitions for clearable interrupt fields
  soundwire: bus: only clear valid DP0 interrupts
  soundwire: bus: only clear valid DPN interrupts

 drivers/soundwire/bus.c                 | 27 +++++++++++++++++--------
 include/linux/soundwire/sdw_registers.h | 11 ++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.17.1

