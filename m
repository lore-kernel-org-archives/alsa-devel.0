Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B9C35E0C
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:02:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2E420CC7
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P5mzi8+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E86A5166F;
	Tue, 25 Feb 2020 18:01:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E86A5166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582650134;
	bh=h2dUEqZ4NbMK6BnHXpKdAdVjxFwTUVtTJOfrpWYd3hA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P5mzi8+ea81/l3TjP4ihcKwzZhj/Q99RLNSNIXVn8uego3bShSakFCvtyZ3VGyTZx
	 UXpKHYHJezRLD/O+UiV8zEMhH07ORp11YdIH4aIvu4M3DIlmpPrNZysvDSyDzF2VbW
	 cxl+BpQSMUFHkII1RdbwJUEmnex377vEwY8yOAmg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BE06F80143;
	Tue, 25 Feb 2020 18:01:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80704F800AD; Tue, 25 Feb 2020 18:01:21 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 638CBF800AD
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 18:01:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 638CBF800AD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2020 09:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; d="scan'208";a="317139620"
Received: from sorin-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.45.43])
 by orsmga001.jf.intel.com with ESMTP; 25 Feb 2020 09:00:54 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] SoundWire: ASoC interfaces for multi-cpu dais and DisCo
 helpers
Date: Tue, 25 Feb 2020 11:00:38 -0600
Message-Id: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

The first two patches prepare the support of multi-cpu dais for
synchronized playback and capture. We remove an unused set of
prototypes and add a get_sdw_stream() callback prototype currently
missing (the implementation will come later as part of the
synchronized playback)

The last exposes macros used internally, so that they can be reused to
extract information from the _ADR 64-bit values in SOF platform
drivers and related machine drivers.

I think it's simpler if all these simple patches are merged through
the SoundWire tree. With the additional changes to remove the platform
drivers and the merge of interrupt handling, that will result in a
single immutable tag provided to Mark Brown.

Pierre-Louis Bossart (3):
  soundwire: cadence: remove useless prototypes
  ASoC: soc-dai: add get_sdw_stream() callback
  soundwire: add helper macros for devID fields

 drivers/soundwire/bus.c            | 21 +++++----------------
 drivers/soundwire/cadence_master.h |  8 --------
 include/linux/soundwire/sdw.h      | 23 +++++++++++++++++++++++
 include/sound/soc-dai.h            | 21 +++++++++++++++++++++
 4 files changed, 49 insertions(+), 24 deletions(-)

-- 
2.20.1

